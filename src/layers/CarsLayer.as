package layers
{
	import assets.Assets;
	
	import car.Car;
	import car.enemyCar.AgresiveBlueCar;
	import car.enemyCar.AgresiveRedCar;
	import car.enemyCar.BlueCar;
	import car.enemyCar.BonusCar;
	import car.enemyCar.RedCar;
	import car.enemyCar.Taxi;
	import car.enemyCar.Truck;
	
	import collitionableObjects.Padrino;
	import collitionableObjects.groundCollitionableObjects.Obstacle;
	
	import core.General;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class CarsLayer extends Layer{
		private var _x:Number, _y:Number;
		private var x1:Number, y1:Number; 
		private var carsArray:Array;
		private var objectCarsArray:Array;
		private var lastIndex:uint;
		//private var ap:uint;
		private var numberOfCarsPainted:uint = 0;
		private var actualDistance:uint;
		
		public function CarsLayer(layer:Array){
			super(layer);
			this.atlasName = "Cars";
			
			x1=x0+(anchoCarretera*(5/12)*factorx)-(anchoCarretera*(1/3)*factorx);
			y1=y0-(anchoCarretera*(5/12)*factory)-(anchoCarretera*(1/3)*factory);
			
//			x1=x0;
//			y1=y0;
			
			lastIndex=0;
			actualDistance=8;
			carsArray=new Array();
			objectCarsArray=new Array();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage():void{}
		
		public function createcars(carImage:String,posx:Number,posy:Number):void{
			var currentCar:Car;
			var currentObstacle:Obstacle;
			
			switch(carImage){
				case("car_blue_a"):
					currentCar=new BlueCar(posx,posy);
//					trace("creando carroa zul");
					break;
				case("car_blue_b"):
					currentCar=new AgresiveBlueCar(posx,posy);
//					trace("creando carro azul agesivo");
					break;				
				case("car_red_a"):
					currentCar=new RedCar(posx,posy);
//					trace("creando carro rojo");
					break;				
				case("car_red_b"):
					currentCar = new AgresiveRedCar(posx,posy);
//					trace("creando carro rojo agresivo");
					break;				
				case("truck"):
					currentCar= new Truck(posx,posy);
//					trace("creando camion");
					break;				
				case("car_yellow_a"):
					currentCar=new Taxi(posx,posy);
//					trace("creando carro amarillo)");
					break;				
				case("car_bonus"):
					currentCar=new BonusCar(posx,posy);
//					trace("creando carro bonus");
					break;
				case("hole"):
					currentObstacle=new Obstacle(new Image(Assets.getAtlasTexture("Cars","hole")),posx,posy,0);
//					trace("creando hueco");
					break;
				case("oil"):
					currentObstacle=new Obstacle(new Image(Assets.getAtlasTexture("Cars","oil")),posx,posy,1);
//					trace("creando aceite");
					break;
			}	
			
			if(currentCar!=null){
				
				addChild(currentCar);
			}
			
			if(currentObstacle!=null){
				addChildAt(currentObstacle,0);
				
				
			}
			
		}
		
		override public function loadAssetsByLayer(currentDistance:Number):void{
						
			var dx:Number=anchoCarretera*factorx;
			var dy:Number=-anchoCarretera*factory;
			var dx1:Number=dx/3;
			var dy1:Number=-dy/3;
			var dx2:Number=-dx/6;
			var dy2:Number=-dy/6;
					
			var l:uint =(Math.floor(currentDistance/anchoCarretera)+4);
			
			if(lastIndex < l){
				lastIndex = l;
				
				for(var i:uint = 0; i<3; i++){
					var i_:uint=2-i;
					for(var j:uint = 0; j<6;j++){
					var j_:uint=5-j;
						var l2:uint=data.length-1-(numberOfCarsPainted+5-2*j);
						
						//trace(l2);
						numberOfCarsPainted++;
//						trace(data[l2]);		
						
						if(l2>=0 && data[l2]!="transparency"){
							_x = x1 + dx1*i_ + dx2*j_+ lastIndex*anchoCarretera*factorx - currentDistance*factorx;
							_y = y1 + dy1*i_ + dy2*j_+ lastIndex*anchoCarretera*factory - currentDistance*factory;
		
//							trace(_x, _y);
							createcars(data[l2], _x, _y);		
						}	
						
					}
				}				
			}
			
			for( j=0; j<this.numChildren; j++){		
//				trace(this.getChildAt(j).x,General.screenWidth,"y",getChildAt(j).y);
				if(this.getChildAt(j).y>= (-5) && this.getChildAt(j) is Car){
					(this.getChildAt(j) as Car).setInside(1);
				}
				if(this.getChildAt(j).x < -25 ||(((( this.getChildAt(j).y<-10) && (this.getChildAt(j) is Car))&&(this.getChildAt(j) as Car).getInside()==1)&&(this.getChildAt(j).x>General.screenWidth/2)) ){
					trace("borrando");
					
					this.removeChildAt(j);	
				}
				
				
			}	
			
		}
		
		override public function loadFirstAssetsByLayer():void{
			lastIndex = 4;
			numberOfCarsPainted = 90;
		}
			
		
		
		
		override public function update():void{
			
			if(numChildren>0){
				
//				trace(numChildren);
				for(var j:uint=0; j<this.numChildren; j++){ 
//					this.getChildAt(j).x -= (this.getSpeed())*factorx;
//					this.getChildAt(j).y -= (this.getSpeed())*factory;
					
					this.getChildAt(j).x -= (this.getSpeed()-this.getChildAt(j)["speed"])*factorx;
					this.getChildAt(j).y -= (this.getSpeed()-this.getChildAt(j)["speed"])*factory;
					
					if(this.getChildAt(j).x < General.viewPortGame.width){
							if(!this.getChildAt(j)["saw"]){
								this.getChildAt(j)["saw"] = true;					
							}
					}
					
					}				
				}
			}
		
		}
}