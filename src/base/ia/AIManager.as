package base.ia
{

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import base.levels.map.Level1;
	import base.levels.map.Loser;
	import base.levels.map.parts.PiragnaSprite;
	
	import car.Car;
	import car.enemyCar.AgresiveBlueCar;
	import car.enemyCar.AgresiveRedCar;
	import car.enemyCar.BlueCar;
	import car.enemyCar.BonusCar;
	import car.enemyCar.RedCar;
	import car.enemyCar.Taxi;
	import car.enemyCar.Truck;
	import car.hero.Hero;
	
	import collitionableObjects.groundCollitionableObjects.Obstacle;
	
	public class AIManager
	{
		private var context:Level1;
		private var  raceLayerRectangles:Array;
		private var  frontLayerRectangles:Array;
		private var  carsLayerRectangles:Array;
		
		private var tamBorderX:Number = 200;
		private var tamBorderY:Number = 15;
		
		private var tamCarX:Number = 38;
		private var tamCarY:Number = 25;
		
		private var tamOilX:Number = 25;
		private var tamOilY:Number = 20;
		
		private var tamHoleX:Number = 25;
		private var tamHoleY:Number = 25;
		
		private var tamCarXForWall:Number = 32;
		private var tamCarYForWall:Number = 24;
		
		private var tamCarYForWallDown:Number = 25;
		private var tamCarYForWallUp:Number = 25;
		
		private var tamTruckX:Number = 65;
		private var tamTruckY:Number = 23;
		
		private var tamCarXForReact:Number = 150;
		private var tamCarYForReact:Number = 150;
		
		public function AIManager(context:Level1)
		{
			this.context = context;
			this.raceLayerRectangles = new Array();
			this.frontLayerRectangles = new Array();
			this.carsLayerRectangles = new Array();
			this.generateRaceLayerRectangles();
			this.generateFrontObjectsLayerRectangles();
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
			
			var tRectangle:Rectangle = new Rectangle(tPoimt.x,tPoimt.y, tamCarXForWall,tamCarYForWall);	
			
			
			if(this.context.getHero().getState() != Car.EST_EXPLODED )
			{
				for each (var i:Rectangle in this.raceLayerRectangles) 
				{
					if(tRectangle.intersects(i) && !this.context.getHero().isCrashed())
					{
						this.context.getHero().explode();
						this.context.getHero().setCrashed(true);
					}
				}
				
				for each (var j:Rectangle in this.frontLayerRectangles) 
				{
					if(tRectangle.intersects(j) && !this.context.getHero().isCrashed())
					{
						this.context.getHero().explode();
						this.context.getHero().setCrashed(true);
					}		
				}
				
				//este es el mas importante, acá se mira si se estrelló contra otro carro, hueco o algo
				checkCarsLayerEvents();
				checkCarsAndWallEvents();
				checkCarsAndCarsEvents();
				checkReactCarEvents();
			}
			if(this.context.getHero().getFuel() == 60 || this.context.getHero().getFuel() == 30)
			{
				putGasCar();
				this.context.getHero().decreaseFuelByOne(); //para que en un mismo segundo no se generen mas bunos
			}
			checkHeroOver();
			return this.context;
		}
		
		private function checkHeroOver():void
		{
			if(this.context.getHero().getState() == Car.EST_EXPLODED)
			{
				trace("isExploded");
				this.reduceLifes();
				this.reCreateHero();
			}
			if(this.context.getHero().isBlockFuel() && this.context.getHero().speed == 0)
			{
				trace("isover");
				this.reduceLifes();
				this.reCreateHero();
			}
		}
		
		private function reCreateHero():void
		{
			if(this.context.getLifes()> 0)
			{
				this.context.getHero().setState(Car.EST_REVIVING);
			}else
			{
				this.context.addChild(new Loser());
			}
		}
		
		private function reduceLifes():void
		{
			if(this.context.getLifes() > 0)
			{
				this.context.reduceLife();			
			}
			else
			{
				this.context.setOutOfGas(true);
			}	
		}
		
		private function putGasCar():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var hr:Car = this.context.getHero();
			var hPointCarro:Point = new Point(hr.x  , hr.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
			var tPoimtCarro:Point = mt.transformPoint(hPointCarro);
			var tRectangleCarro:Rectangle = new Rectangle(tPoimtCarro.x,tPoimtCarro.y, this.tamCarX,this.tamCarY);	
			
			var founded:Boolean = false;
			
			var numChildRace:Number = this.context.getCarsLayer().numChildren;
			for (var i:int = 0; i < this.context.getCarsLayer().numChildren; i++) 
			{
				if(this.context.getCarsLayer().getChildAt(i) is Car)
				{
					var tempPiragna:Car =  this.context.getCarsLayer().getChildAt(i) as Car; 
					var hTempPiragna:Point = new Point(tempPiragna.x  , tempPiragna.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
					var tTempPiragna:Point = mt.transformPoint(hTempPiragna);
					var tRectangleTempPiragna:Rectangle = new Rectangle(tTempPiragna.x,tTempPiragna.y, this.tamCarX,this.tamCarY);	
					if( tempPiragna is Taxi && !founded)
					{
						if(tRectangleTempPiragna.x > (tRectangleCarro.x + 50) )
						{
							var bonusCar:BonusCar = new BonusCar(tempPiragna.x,tempPiragna.y);
							this.context.getCarsLayer().removeChildAt(i);	
							this.context.getCarsLayer().addChildAt(bonusCar,i);	
							founded = true;
						}
					}
				}
			}
			
			if(!founded)
			{
				for (var i:int = 0; i < this.context.getCarsLayer().numChildren; i++) 
				{
					if(this.context.getCarsLayer().getChildAt(i) is Car)
					{
						var tempPiragna2:Car =  this.context.getCarsLayer().getChildAt(i) as Car; 
						var hTempPiragna2:Point = new Point(tempPiragna2.x  , tempPiragna2.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
						var tTempPiragna2:Point = mt.transformPoint(hTempPiragna2);
						var tRectangleTempPiragna2:Rectangle = new Rectangle(tTempPiragna2.x,tTempPiragna2.y, this.tamCarX,this.tamCarY);	
						if( tempPiragna2 is RedCar || tempPiragna2 is BlueCar )
						{
							if(tRectangleTempPiragna2.x > (tRectangleCarro.x + 30) && !founded)
							{
								var bonusCar2:BonusCar = new BonusCar(tempPiragna2.x,tempPiragna2.y);
								this.context.getCarsLayer().removeChildAt(i);	
								this.context.getCarsLayer().addChildAt(bonusCar2,i);	
								founded = true;
							}
							
						}
					}
				}
			}
			
		}
		
		private function checkReactCarEvents():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var hr:Car = this.context.getHero();
			var hPointCarro:Point = new Point(hr.x  , hr.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
			var tPoimtCarro:Point = mt.transformPoint(hPointCarro);
			var tRectangleCarro:Rectangle = new Rectangle(tPoimtCarro.x,tPoimtCarro.y, this.tamCarX,this.tamCarY);
			for (var i:int = 0; i < this.context.getCarsLayer().numChildren; i++) 
			{
				if(this.context.getCarsLayer().getChildAt(i) is Car)
				{
					var tempPiragna:Car =  this.context.getCarsLayer().getChildAt(i) as Car; 
					if( tempPiragna is  AgresiveBlueCar 
						|| tempPiragna is AgresiveRedCar)
					{
						var tPoint:Point = new Point(tempPiragna.x,tempPiragna.y);
						var tp_1:Point =  mt.transformPoint(tPoint);
						var tRectangle:Rectangle = new Rectangle((tp_1.x -50),(tp_1.y -50) , this.tamCarXForReact,this.tamCarYForReact);	
						
						if(tRectangle.intersects(tRectangleCarro) && !tempPiragna.getReactioned() )
						{
							tempPiragna.setReactioned(true)
							if(tRectangle.y + 50 > tRectangleCarro.y)
							{
								tempPiragna.drift(tempPiragna.speed+10, false);
							}
							else
							{
								tempPiragna.drift(tempPiragna.speed+5, true);
							}
						}
						
					}
				}
			}
			
		}	
		
		private function checkCarsAndCarsEvents():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			for (var i:int = 0; i < this.context.getCarsLayer().numChildren; i++) 
			{
				if(this.context.getCarsLayer().getChildAt(i) is Car)
				{
					var tempPiragna:Car =  this.context.getCarsLayer().getChildAt(i) as Car; 
					if( tempPiragna is  AgresiveBlueCar 
						|| tempPiragna is  BlueCar 
						|| tempPiragna is AgresiveRedCar 
						|| tempPiragna is RedCar
						||tempPiragna is Taxi
						||tempPiragnaj is Truck)
					{
						var hPointCarro:Point = new Point(tempPiragna.x  , tempPiragna.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
						var tPoimtCarro:Point = mt.transformPoint(hPointCarro);
						var tRectangleCarro:Rectangle = new Rectangle(tPoimtCarro.x,tPoimtCarro.y, this.tamCarX,this.tamCarY);	
						
						for (var j:int = 0; j < this.context.getCarsLayer().numChildren; j++) 
						{
							if(this.context.getCarsLayer().getChildAt(j) is Car)
							{
								var tempPiragnaj:Car =  this.context.getCarsLayer().getChildAt(j) as Car; 
								if( tempPiragna is  AgresiveBlueCar 
									|| tempPiragnaj is  BlueCar 
									|| tempPiragnaj is AgresiveRedCar 
									|| tempPiragnaj is RedCar
									||tempPiragnaj is Taxi
									||tempPiragnaj is Truck)
								{
									if(i != j)
									{
										var hPointCarroj:Point = new Point(tempPiragnaj.x  , tempPiragnaj.y); // acá no hay desfaces por que a todos se les aplica el mismo pivote
										var tPoimtCarroj:Point = mt.transformPoint(hPointCarroj);
										var tRectangleCarroj:Rectangle = new Rectangle(tPoimtCarroj.x,tPoimtCarroj.y, this.tamCarX,this.tamCarY);	
										if(tRectangleCarro.intersects(tRectangleCarroj) && tempPiragna.getIsActive() && tempPiragnaj.getIsActive())
										{
											tempPiragna.speed = 0;
											tempPiragna.explode();	
											tempPiragna.alpha = 0;
											tempPiragna.setIsActive(false);
											
											tempPiragnaj.speed = 0;
											tempPiragnaj.explode();
											tempPiragna.alpha = 0;
											tempPiragnaj.setIsActive(false);
										}
										
									}
								}
							}
						}
						
					}
				}
			}
			
		}
		
		private function checkCarsAndWallEvents():void
		{
			// TODO Auto Generated method stub
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			for (var i:int = 0; i < this.context.getCarsLayer().numChildren; i++) 
			{
				if(this.context.getCarsLayer().getChildAt(i) is Car)
				{
					var tempPiragna:Car =  this.context.getCarsLayer().getChildAt(i) as Car; 
					if( tempPiragna is  AgresiveBlueCar 
						|| tempPiragna is  BlueCar 
						|| tempPiragna is AgresiveRedCar 
						|| tempPiragna is RedCar
						||tempPiragna is Taxi)
					{
						var hPoint:Point = new Point(tempPiragna.x+156 - 47, tempPiragna.y+95 -26  ); //la primera suma es una constante de desface, la segunda otro desface de pivote
						var tPoimt:Point = mt.transformPoint(hPoint);
						
						var tRectangle_up:Rectangle = new Rectangle(tPoimt.x, tPoimt.y, this.tamCarXForWall,this.tamCarYForWallUp);	
						var tRectangle_down:Rectangle = new Rectangle(tPoimt.x, tPoimt.y , this.tamCarXForWall,this.tamCarYForWallDown);	
						
						for each (var m:Rectangle in this.raceLayerRectangles) 
						{
							if(tRectangle_up.intersects(m)  && (m.y > (tRectangle_up.y) +1 ))
							{
								tempPiragna.explode();
								tempPiragna.setIsActive(false);
								tempPiragna.alpha = 0;
							}		
						}
						
						for each (var j:Rectangle in this.frontLayerRectangles) 
						{
							if(tRectangle_down.intersects(j) && (j.y < (tRectangle_up.y +1 )))
							{
								tempPiragna.explode();
								tempPiragna.setIsActive(false);
								tempPiragna.alpha = 0;
							}		
						}
					}	
				}
			}
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
				if(this.context.getCarsLayer().getChildAt(i) is Car)
				{
					var tempPiragna:Car =  this.context.getCarsLayer().getChildAt(i) as Car; 
					if( tempPiragna is  AgresiveBlueCar 
						|| tempPiragna is  BlueCar 
						|| tempPiragna is AgresiveRedCar 
						|| tempPiragna is RedCar
					    ||tempPiragna is Taxi)
					{
						var tPoint:Point = new Point(tempPiragna.x,tempPiragna.y);
						var tp_1:Point =  mt.transformPoint(tPoint);
						var tRectangle:Rectangle = new Rectangle((tp_1.x ),
							(tp_1.y) , this.tamCarX,this.tamCarY);	
						//					
						if(tRectangleCarro.intersects(tRectangle) && tempPiragna.getIsActive())
						{
							if(this.context.getHero().getState() != Car.EST_DRIFTING)
							{
								if(tRectangle.y >= tRectangleCarro.y ){
									this.context.getHero().drift(context.getCurrentSpeed(), false);
									tempPiragna.drift(tempPiragna.speed + 10,true);
								}else
								{
									this.context.getHero().drift(context.getCurrentSpeed(), true);
									tempPiragna.drift(tempPiragna.speed + 10 ,false);
								}
							}else if(this.context.getHero().getState() == Car.EST_DRIFTING && !this.context.getHero().isCrashed())
							{
								this.context.getHero().explode();
								this.context.getHero().setCrashed(true);
							}
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
							if(tRectangleTr.y >= tRectangleCarro.y && !this.context.getHero().isCrashed()){
								this.context.getHero().explode();
								this.context.getHero().setCrashed(true);
								this.context.setCurrentSpeed(0);
							}else{
								if (!this.context.getHero().isCrashed())
								{
									this.context.getHero().explode();
									this.context.getHero().setCrashed(true);
									this.context.setCurrentSpeed(0);
								}
							}
						}
					}
					if(tempPiragna is BonusCar)
					{
						var tCarB:BonusCar = tempPiragna as BonusCar;
						var tPointB:Point = new Point(tCarB.x,tCarB.y);
						var tp_1B:Point =  mt.transformPoint(tPointB);
						var tRectangleB:Rectangle = new Rectangle((tp_1B.x ),
							(tp_1B.y) , this.tamCarX,this.tamCarX);	
						
						if(tRectangleCarro.intersects(tRectangleB) && !tCarB.bonusTaken())
						{
							this.context.getHero().raiseFuel(tCarB.getBonusFuel());
							tCarB.takeBonus();
							tCarB.alpha=0;
						}
					}
				}else
				{
					if(this.context.getCarsLayer().getChildAt(i) is Obstacle)
					{
						var tempPiragnaO:Obstacle =  this.context.getCarsLayer().getChildAt(i) as Obstacle; 
						
						
						if(tempPiragnaO.getName() == "oil")
						{
							var tPointO:Point = new Point(tempPiragnaO.x,tempPiragnaO.y );
							var tp_1O:Point =  mt.transformPoint(tPointO);
							var tRectangleO:Rectangle = new Rectangle((tp_1O.x ),
								(tp_1O.y) , this.tamOilX,this.tamOilY);
							
							if(tRectangleO.intersects(tRectangleCarro))
							{
								trace("hace intersec con aceite");
								if(tRectangleO.y >= tRectangleCarro.y )
								{
									this.context.getHero().drift(context.getCurrentSpeed(), false);
								}
								else
								{
									this.context.getHero().drift(context.getCurrentSpeed(), true);
								}
							}
						}
						if(tempPiragnaO.getName() == "hole")
						{
							var tPointH:Point = new Point(tempPiragnaO.x,tempPiragnaO.y );
							var tp_1H:Point =  mt.transformPoint(tPointH);
							var tRectangleH:Rectangle = new Rectangle((tp_1H.x ),
								(tp_1H.y) , this.tamHoleX,this.tamHoleY);
							
							if(tRectangleH.intersects(tRectangleCarro) && !this.context.getHero().isCrashed())
							{
								this.context.getHero().explode();
								this.context.getHero().setCrashed(true);
							}
						}
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
					var tRectangleFr2:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) + 203, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangleFr2);
				}
				if(tempPiragna.getName() ==  "frTack_1")
				{
					var tRectangleFR1:Rectangle = new Rectangle((tp_1.x ) -94 ,
						(tp_1.y) + 136, this.tamBorderX,this.tamBorderY);	
					this.frontLayerRectangles.push(tRectangleFR1);
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