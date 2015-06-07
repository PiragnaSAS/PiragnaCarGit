package base.ia
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import base.levels.map.Level1;
	import base.levels.map.parts.PiragnaSprite;
	
	import car.Car;
	
	public class AIManager
	{
		private var context:Level1;
		private var  raceLayerRectangles:Array;
		private var  frontLayerRectangles:Array;
		
		private var tamBorderX:Number = 200;
		private var tamBorderY:Number = 15;
		
		public function AIManager(context:Level1)
		{
			this.context = context;
			this.raceLayerRectangles = new Array();
			this.frontLayerRectangles = new Array();
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
			var hPoint:Point = new Point(hr.x +156, hr.y +95);
			var tPoimt:Point = mt.transformPoint(hPoint);
			
			var tRectangle:Rectangle = new Rectangle(tPoimt.x,tPoimt.y, 31,18);	
			
			for each (var i:Rectangle in this.raceLayerRectangles) 
			{
				if(tRectangle.intersects(i))
				{
						trace("choca");
				}		
				else
				{
//					trace ("no", i.x ,i.y , "carro" ,tPoimt.x, tPoimt.y);
				}
			}
			
			for each (var j:Rectangle in this.frontLayerRectangles) 
			{
				if(tRectangle.intersects(j))
				{
					trace("choca");
				}		
				else
				{
					//trace ("no", j.x ,j.y , "carro" ,tPoimt.x, tPoimt.y);
				}
			}
			
			
			
			return this.context;
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