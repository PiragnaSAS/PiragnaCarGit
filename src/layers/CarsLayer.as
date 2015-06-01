package layers
{
	
	import assets.Assets;
	
	import base.levels.map.parts.PiragnaSprite;
	
	import car.Car;
	import car.enemyCar.AgresiveBlueCar;
	import car.enemyCar.AgresiveRedCar;
	import car.enemyCar.BlueCar;
	import car.enemyCar.BonusCar;
	import car.enemyCar.RedCar;
	import car.enemyCar.Taxi;
	import car.enemyCar.Truck;
	
	import core.General;
	
	import starling.display.Image;
	import starling.events.Event;

	//car_1_1_2
	
	public class CarsLayer extends Layer
	{
		private var _x:Number;
		private var _y:Number;
		private var carsArray:Array;
		private var objectCarsArray:Array;
		public function CarsLayer(layer:Array)
		{
			this.atlasName = "Cars";
			super(layer);
			carsArray=new Array();
			objectCarsArray=new Array();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage():void{}
		public function createcars(carImage:String,posx:uint,posy:uint):void{
			switch(carImage){
				
				case("car_blue"):
					var currentCar:Car=new BlueCar();
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_blue")));
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando carroa zul");
					break;
				case("car_blue_a"):
					var currentCar:Car=new AgresiveBlueCar();
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_blue")));
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando carro azul agesivo");
					break;
				
				case("car_red"):
					var currentCar:Car=new RedCar();
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_red")));
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando carro rojo");
					break;
				
				case("car_red_a"):
					var currentCar:Car = new AgresiveRedCar();
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_red")));
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando carro rojo agresivo");
					break;
				
				case("truck"):
					var currentCar:Car= new Truck();
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","truck")));
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando camion");
					break;
				
				case("car_yellow"):
					var currentCar:Car=new Taxi();
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_yellow")));
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando carro amarillo)");
					break;
				
				case("car_bonus"):
					var currentCar:Car=new BonusCar();
					currentCar.x=posx;
					currentCar.y=posy;
					currentCar.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_bonus")));
					currentCar.alignPivot();
					objectCarsArray.push(currentCar);
					trace("creando carro bonus");
					break;
				
			}
		}
		
		override public function loadFirstAssetsByLayer():void{
			var m:uint;
			var j:uint;
			var k:uint;
			var ap:uint;
			var x1:Number=x0-(anchoCarretera*(5/12)*factorx)-(anchoCarretera*(2/6)*factorx);
			var y1:Number=y0+(anchoCarretera*(5/12)*factory)-(anchoCarretera*(2/6)*factory);
			var dx:Number=anchoCarretera*factorx;
			var dy:Number=-anchoCarretera*factory;
			var dx1:Number=dx/3;
			var dy1:Number=-dy/3;
			var dx2:Number=dx/6;
			var dy2:Number=dy/6;
			k=0;
			ap=0;
			for (m = 0; m < (8*3*data.length); m++) 
			{
				for (j = 0; j < (6); j++) 
				{
					if(k<data.length && data[k]!="transparency"){
						_x=x1+dx1*m+dx2*j;
						_y=y1+dy1*m+dy2*j;
						createcars(data[k],_x,_y);
						if(data[k]=="car_blue_a"){
							data[k]="car_blue";
						}
						if(data[k]=="car_red_a"){
							data[k]="car_red";
						}
						
						/*var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,new Image(Assets.getAtlasTexture("Cars",this.data[k])));
						piragnaSprite.x=_x;
						piragnaSprite.y=_y;
						piragnaSprite.visible=false;
						carsArray.push(piragnaSprite);
						*/
						
						trace(this.data[k]);
						trace(carsArray[ap]);
						//trace(objectCarsArray[ap]);
						//trace(j);
						//piragnaSprite.x=_x;
						//piragnaSprite.y=_y;
						//piragnaSprite.visible= false;
						//addChildAt(piragnaSprite,0);
						//addChildAt(carsArray[ap],0);
						addChildAt(objectCarsArray[ap],0);
						ap++
					}
					k++;
				}
			
		}
			
		/*override public function loadAssetsByLayer(currentDistance:Number):void
		{
			var m:uint;
			var j:uint;
			var k:uint;
			var ap:uint;
			var x1:Number=x0-(anchoCarretera*(5/12)*factorx)-(anchoCarretera*(2/6)*factorx);
			var y1:Number=y0+(anchoCarretera*(5/12)*factory)-(anchoCarretera*(2/6)*factory);
			var dx:Number=anchoCarretera*factorx;
			var dy:Number=-anchoCarretera*factory;
			var dx1:Number=dx/3;
			var dy1:Number=-dy/3;
			var dx2:Number=dx/6;
			var dy2:Number=dy/6;
			k=0;
			ap=0;
			for (m = 0; m < (8*3*data.length); m++) 
			{
				for (j = 0; j < (6); j++) 
				{
					if(k<data.length && data[k]!="transparency"){
						if(data[k]=="car_blue_a"){
							data[k]="car_blue";
						}
						if(data[k]=="car_red_a"){
							data[k]="car_red";
						}
						_x=x1+dx1*m+dx2*j;
						_y=y1+dy1*m+dy2*j;
						var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,new Image(Assets.getAtlasTexture("Cars",this.data[k])));
						piragnaSprite.x=_x;
						piragnaSprite.y=_y;
						piragnaSprite.visible=false;
						carsArray.push(piragnaSprite);
						trace(ap);
						trace(this.data[k]);
						trace(carsArray[ap]);
						//trace(j);
						//piragnaSprite.x=_x;
						//piragnaSprite.y=_y;
						//piragnaSprite.visible= false;
						//addChildAt(piragnaSprite,0);
						addChildAt(carsArray[ap],0);
						ap++
					}
					k++;
				}
				//trace(m);
			}
			*/
			
			
			
			
			
/*			trace("aguita de coco");
			for (var i:int=0; i<this.data.length; i++){	
				for(var j:uint=0; j<5;j++){
					
					trace("holi: "+data[i]);
					if (data[i]!="transparency"){
						var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,this.data[i]);
						addChild(piragnaSprite);
					}
					_x += 101/5;
					_y += 58/5; 

				}
				_x-=101/5*j-101/3;
				_y-=58/5*j+58/3;
				
			}*/
		}
			
		
		
		override public function update():void{
			if(numChildren>0){
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed()*factorx;
				this.getChildAt(j).y -= this.getSpeed()*factory;
				
				if(this.getChildAt(j).x <= General.viewPortBaseWidth+100){
					this.getChildAt(j).visible = true;
				}
				
				if(this.getChildAt(j).x < -100){
					this.removeChildAt(j);
				}
				
			}
		
//			var child:DisplayObject;
//			
//			if(this.getChildAt(0).x < -100 && this.getChildAt(0).y > General.screenHeight+200){		
//				child = getChildAt(0);
//				var randomNumber:Number= Math.random()*200+80;
//				
//				child.x = getChildAt(this.numChildren - 1).x + randomNumber/3;
//				child.y = getChildAt(this.numChildren - 1).y - (randomNumber*Math.tan(Math.PI/6)/3);
//				this.removeChildAt(0);
//				this.addChild(child);					
//			}
		  }
		}
	}
}