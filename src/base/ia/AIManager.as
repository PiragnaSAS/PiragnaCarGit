package base.ia
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import base.levels.map.Level1;
	import base.levels.map.parts.PiragnaSprite;
	
	import car.Car;
	import car.enemyCar.AgresiveBlueCar;
	import car.enemyCar.AgresiveRedCar;
	import car.enemyCar.BlueCar;
	import car.enemyCar.RedCar;
	import car.enemyCar.Taxi;
	import car.enemyCar.Truck;
	
	public class AIManager
	{
		private var context:Level1;
		private var  raceLayerRectangles:Array;
		private var  frontLayerRectangles:Array;
		private var  carsLayerRectangles:Array;
		
		private var tamBorderX:Number = 200;
		private var tamBorderY:Number = 15;
		
		private var tamCarX:Number = 38;
		private var tamCarY:Number = 20;
		
		private var tamTruckX:Number = 65;
		private var tamTruckY:Number = 23;
		
		public function AIManager(context:Level1)
		{
			this.context = context;
			this.raceLayerRectangles = new Array();
			this.frontLayerRectangles = new Array();
			this.carsLayerRectangles = new Array();
			this.generateRaceLayerRectangles();
			this.generateFrontObjectsLayerRectangles();
		}
		
		
		private function checkCollision(layer:Sprite, hero:Sprite):void
		{
			//por el momento se va a comprobar la colisión entre los demás carros
			//y liego la colisión entre los demás carros con el heroe
			checkCollisionLayer(layer);
			checkCollisionHeroCar(layer,hero);
			
			checkCollisionRaceLayer();
			checkCollitionsCollitionsLayer();
		}
		
		private function checkCollitionsCollitionsLayer():void
		{
			
		}
		
		private function checkCollisionRaceLayer():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function checkCollisionLayer(layer:Sprite):void
		{
			var numChildren:int = layer.numChildren;
			for(var i:uint = 0; i< numChildren; i++)
			{
				for(var j:uint = 0; j< numChildren; j++)
				{
					if ((i != j)&&((layer.getChildAt(i) as Sprite).hitTestObject(layer.getChildAt(j) as Sprite)))
					{
						//acá se debe manejar la colisión con base a nuestro contexto que es el mapa
						
					}
				}	
			}
		}
		
		private function checkCollisionHeroCar(layer:Sprite, hero:Sprite):void
		{
			var numChildren:int = layer.numChildren;
			for(var i:uint = 0; i< numChildren; i++)
			{
				if ((layer.getChildAt(i).hitTestObject(hero)))
				{
					//acá se debe manejar la colisión con base a nuestro contexto que es el mapa
				}
			}
		}
		
		//implementado pero no usado, se debe cambiar la lógica de las colisiones de acuerdo a la perspectiva
		private function collide(obj1:Sprite, obj2:Sprite):Boolean
		{
			//este método va a cambiar deacuerdo a la perspectiva, por ahora se utilizará este
			
			return obj1.hitTestObject(obj2);
			
		}
		
		
		
		public function update():Level1
		{
			this.raceLayerRectangles = new Array();
			this.generateRaceLayerRectangles();
			
			this.frontLayerRectangles = new Array();
			this.generateFrontObjectsLayerRectangles();
			
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var hr:Car = this.context.getHero();
			var hPoint:Point = new Point(hr.x+156 - 47, hr.y+95 -26); //la primera suma es una constante de desface, la segunda otro desface de pivote
			var tPoimt:Point = mt.transformPoint(hPoint);
			
			var tRectangle:Rectangle = new Rectangle(tPoimt.x,tPoimt.y, tamCarX,tamCarY);	
			
			for each (var i:Rectangle in this.raceLayerRectangles) 
			{
				if(tRectangle.intersects(i))
				{
					trace("choca");
//					this.context.setCurrentSpeed(0);
				}		
			}
			
			for each (var j:Rectangle in this.frontLayerRectangles) 
			{
				if(tRectangle.intersects(j))
				{
					trace("choca");
//					this.context.setCurrentSpeed(0);
				}		
			}
			
			var hPointCarro:Point = new Point(hr.x  , hr.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
			var tPoimtCarro:Point = mt.transformPoint(hPointCarro);
			var tRectangleCarro:Rectangle = new Rectangle(tPoimtCarro.x,tPoimtCarro.y, this.tamCarX,this.tamCarY);	
		
			//este es el mas importante, acá se mira si se estrelló contra otro carro, hueco o algo
			checkCarsLayerEvents();
			
//			for each (var p:Rectangle in this.carsLayerRectangles) 
//			{
//				if(tRectangleCarro.intersects(p) && this.context.getHero().getState() != Car.EST_DRIFTING)
//				{
//					if(p.y >= tRectangleCarro.y ){
//						this.context.getHero().drift(context.getCurrentSpeed(), false);
//						this.context.setCurrentSpeed(0);
//					}else{
//						this.context.getHero().drift(context.getCurrentSpeed(), true);
//						this.context.setCurrentSpeed(0);
//					} 
//				}		
//			}
			
			return this.context;
		}
		
		private function checkCarsLayerEvents():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var hr:Car = this.context.getHero();
			var hPointCarro:Point = new Point(hr.x  , hr.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
			var tPoimtCarro:Point = mt.transformPoint(hPointCarro);
			var tRectangleCarro:Rectangle = new Rectangle(tPoimtCarro.x,tPoimtCarro.y, this.tamCarX,this.tamCarY);	
			
			var numChildRace:Number = this.context.getCarsLayer().numChildren;
			for (var i:int = 0; i < this.context.getCarsLayer().numChildren; i++) 
			{
				var tempPiragna:Car = this.context.getCarsLayer().getChildAt(i) as Car;
				if(tempPiragna is  AgresiveBlueCar)
				{
					var tCar:AgresiveBlueCar = tempPiragna as AgresiveBlueCar;
					var tPoint:Point = new Point(tCar.x,tCar.y);
					var tp_1:Point =  mt.transformPoint(tPoint);
					var tRectangle:Rectangle = new Rectangle((tp_1.x ),
						(tp_1.y) , this.tamCarX,this.tamCarY);	
//					
					if(tRectangleCarro.intersects(tRectangle) && this.context.getHero().getState() != Car.EST_DRIFTING)
					{
						if(tRectangle.y >= tRectangleCarro.y ){
							this.context.getHero().drift(context.getCurrentSpeed(), false);
							tCar.drift(tCar.speed,true);
							this.context.setCurrentSpeed(0);
						}else{
							this.context.getHero().drift(context.getCurrentSpeed(), true);
							tCar.drift(tCar.speed,false);
							this.context.setCurrentSpeed(0);}
					}
					
				}
				if(tempPiragna is BlueCar)
				{
					var tCarblue:BlueCar = tempPiragna as BlueCar;
					var tPointBX:Point = new Point(tCarblue.x,tCarblue.y);
					var tp_1BC:Point =  mt.transformPoint(tPointBX);
					var tRectangleBC:Rectangle = new Rectangle((tp_1BC.x ),
						(tp_1BC.y) , this.tamCarX,this.tamCarY);	
				
					if(tRectangleCarro.intersects(tRectangleBC) && this.context.getHero().getState() != Car.EST_DRIFTING)
					{
						if(tRectangleBC.y >= tRectangleCarro.y ){
							this.context.getHero().drift(context.getCurrentSpeed(), false);
							tCarblue.drift(tCarblue.speed,true);
							this.context.setCurrentSpeed(0);
						}else{
							this.context.getHero().drift(context.getCurrentSpeed(), true);
							tCarblue.drift(tCarblue.speed,false);
							this.context.setCurrentSpeed(0);}
					}
					
				}
				if(tempPiragna is AgresiveRedCar)
				{
					var tCar2:AgresiveRedCar = tempPiragna as AgresiveRedCar;
					var tPointAR:Point = new Point(tCar2.x,tCar2.y);
					var tp_1AR:Point =  mt.transformPoint(tPointAR);
					var tRectangleAR:Rectangle = new Rectangle((tp_1AR.x ),
						(tp_1AR.y) , this.tamCarX,this.tamCarY);	
					
					if(tRectangleCarro.intersects(tRectangleAR) && this.context.getHero().getState() != Car.EST_DRIFTING)
					{
						if(tRectangleAR.y >= tRectangleCarro.y ){
							this.context.getHero().drift(context.getCurrentSpeed(), false);
							tCar2.drift(tCar2.speed,true);
							this.context.setCurrentSpeed(0);
						}else{
							this.context.getHero().drift(context.getCurrentSpeed(), true);
							tCar2.drift(tCar2.speed,false);
							this.context.setCurrentSpeed(0);}
					}
				}
				if(tempPiragna is RedCar)
				{
					var tCarRed:RedCar = tempPiragna as RedCar;
					var tPointRC:Point = new Point(tCarRed.x,tCarRed.y);
					var tp_1RC:Point =  mt.transformPoint(tPointRC);
					var tRectangleRC:Rectangle = new Rectangle((tp_1RC.x ),
						(tp_1RC.y) , this.tamCarX,this.tamCarY);	
					
					if(tRectangleCarro.intersects(tRectangleRC) && this.context.getHero().getState() != Car.EST_DRIFTING)
					{
						if(tRectangleRC.y >= tRectangleCarro.y ){
							this.context.getHero().drift(context.getCurrentSpeed(), false);
							tCarRed.drift(tCarRed.speed,true);
							this.context.setCurrentSpeed(0);
						}else{
							this.context.getHero().drift(context.getCurrentSpeed(), true);
							tCarRed.drift(tCarRed.speed,false);
							this.context.setCurrentSpeed(0);}
					}
				}
				
				if(tempPiragna is Taxi)
				{
					var tCar3:Taxi = tempPiragna as Taxi;
					var tPointTa:Point = new Point(tCar3.x,tCar3.y);
					var tp_1Ta:Point =  mt.transformPoint(tPointTa);
					var tRectangleTa:Rectangle = new Rectangle((tp_1Ta.x ),
						(tp_1Ta.y) , this.tamCarX,this.tamCarY);	
				
					if(tRectangleCarro.intersects(tRectangleTa) && this.context.getHero().getState() != Car.EST_DRIFTING)
					{
						if(tRectangleTa.y >= tRectangleCarro.y ){
							this.context.getHero().drift(context.getCurrentSpeed(), false);
							tCar3.drift(tCar3.speed,true);
							this.context.setCurrentSpeed(0);
						}else{
							this.context.getHero().drift(context.getCurrentSpeed(), true);
							tCar3.drift(tCar3.speed,false);
							this.context.setCurrentSpeed(0);}
					}
				}
				
				if(tempPiragna is Truck)
				{
					var tCar4:Truck = tempPiragna as Truck;
					var tPointTr:Point = new Point(tCar4.x,tCar4.y);
					var tp_1Tr:Point =  mt.transformPoint(tPointTr);
					var tRectangleTr:Rectangle = new Rectangle((tp_1Tr.x ),
						(tp_1Tr.y) , this.tamTruckX,this.tamTruckY);	
					
					if(tRectangleCarro.intersects(tRectangleTr) && this.context.getHero().getState() != Car.EST_DRIFTING)
					{
						if(tRectangleTr.y >= tRectangleCarro.y ){
							this.context.getHero().drift(context.getCurrentSpeed(), false);
							this.context.setCurrentSpeed(0);
						}else{
							this.context.getHero().drift(context.getCurrentSpeed(), true);
							this.context.setCurrentSpeed(0);}
					}
				}
				
			}			
		}
		
		private function generateRaceLayerRectangles():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var numChildRace:Number = this.context.getRaceLayer().numChildren;
			for (var i:int = 0; i < this.context.getRaceLayer().numChildren; i++) 
			{
				var tempPiragna:PiragnaSprite = PiragnaSprite(this.context.getRaceLayer().getChildAt(i));
				var tPoint:Point = new Point(tempPiragna.x,tempPiragna.y);
				var tp_1:Point =  mt.transformPoint(tPoint);
				
				if(tempPiragna.getName() ==  "bgTack_7_7" || tempPiragna.getName() ==  "bgTack_0_0" || tempPiragna.getName() ==  "bgTack_1_1"  || tempPiragna.getName() ==  "bgTack_3_1" || tempPiragna.getName() ==  "bgTack_3_2"|| tempPiragna.getName() ==  "bgTack_3_3" || tempPiragna.getName() ==  "bgTack_7_3"|| tempPiragna.getName() ==  "bgTack_7_5"|| tempPiragna.getName() ==  "bgTack_7_6" || tempPiragna.getName() ==  "bgTack_7_7")
				{
					var tRectangle:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +62, this.tamBorderX,this.tamBorderY);	
					this.raceLayerRectangles.push(tRectangle);
				}
				if(tempPiragna.getName() ==  "bgTack_2_2" || tempPiragna.getName() ==  "bgTack_6_2" || tempPiragna.getName() ==  "bgTack_6_4" || tempPiragna.getName() ==  "bgTack_6_6"|| tempPiragna.getName() ==  "bgTack_7_2")
				{
					var tRectangle:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +130, this.tamBorderX,this.tamBorderY);	
					this.raceLayerRectangles.push(tRectangle);
				}
				if(tempPiragna.getName() ==  "bgTack_4_4" )
				{
					var tRectangle:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +200, this.tamBorderX,this.tamBorderY);	
					this.raceLayerRectangles.push(tRectangle);
				}
				if(tempPiragna.getName() ==  "bgTack_5_5" )
				{
					var tRectangle1:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +200, this.tamBorderX,this.tamBorderY);	
					this.raceLayerRectangles.push(tRectangle1);
					var tRectangle2:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +62, this.tamBorderX,this.tamBorderY);	
					this.raceLayerRectangles.push(tRectangle2);
				}
			}			
		}
		
		private function generateFrontObjectsLayerRectangles():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var numChildRace:Number = this.context.getFrontObjectsLayer().numChildren;
			for (var i:int = 0; i < this.context.getFrontObjectsLayer().numChildren; i++) 
			{
				var tempPiragna:PiragnaSprite = PiragnaSprite(this.context.getFrontObjectsLayer().getChildAt(i));
				var tPoint:Point = new Point(tempPiragna.x,tempPiragna.y);
				var tp_1:Point =  mt.transformPoint(tPoint);
				//trace( "en el front",tempPiragna.getName());
				if(tempPiragna.getName() ==  "frTack_4")
				{
					//	trace("agrega uno");
					var tRectangle:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) + 271, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangle);
				}
				if(tempPiragna.getName() ==  "frTack_2")
				{
					var tRectangle:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) + 203, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangle);
				}
				if(tempPiragna.getName() ==  "frTack_1")
				{
					var tRectangle:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) + 136, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangle);
				}
				if(tempPiragna.getName() ==  "bgTack_5_5" )
				{
					var tRectangle1:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +200, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangle1);
					var tRectangle2:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) +62, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangle2);
				}
			}			
		}
		
		public function getRectangles():Array
		{
			return this.raceLayerRectangles;
		}
		
		
	}
}