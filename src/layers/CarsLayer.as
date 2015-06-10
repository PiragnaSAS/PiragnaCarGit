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
	
	import collitionableObjects.groundCollitionableObjects.Obstacle;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class CarsLayer extends Layer
	{
		private var _x:Number, _y:Number;
		private var x1:Number, y1:Number; 
		private var carsArray:Array;
		private var objectCarsArray:Array;
		private var lastIndex:uint;
		//private var ap:uint;
		private var k:uint;
		private var actualDistance:uint;
		//15 por que son los primeros 5 objetos de raceLayer y cada uno de esos objetos debe estar dividido en 3 (5*3)
		private var t=15;
		private var ap;
		
		public function CarsLayer(layer:Array){
			super(layer);
			this.atlasName = "Cars";
			ap=0;
			x1=x0-(anchoCarretera*(5/12)*factorx)-(anchoCarretera*(2/6)*factorx);
			y1=y0+(anchoCarretera*(5/12)*factory)-(anchoCarretera*(2/6)*factory);
			lastIndex=0;
			actualDistance=0;
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
				objectCarsArray.push(currentCar);		
			}
			
			if(currentObstacle!=null){
				objectCarsArray.push(currentObstacle);
			}
			
		}
		
		override public function loadAssetsByLayer(currentDistance:Number):void{
						
//			var l:uint =((Math.floor(currentDistance/anchoCarretera*3)+15));
//			var totalNum:uint = numChildren;
			
			/*var i:uint;
			var j:uint;
			*/
			
			var dx:Number=anchoCarretera*factorx;
			var dy:Number=-anchoCarretera*factory;
			var dx1:Number=dx/3;
			var dy1:Number=-dy/3;
			var dx2:Number=dx/6;
			var dy2:Number=dy/6;
			
			if(actualDistance==0){
				actualDistance=6;
			}
//			trace(actualDistance,currentDistance);
			
			
			if(actualDistance==currentDistance){
//				trace("dibujando nuevos carros");
				
				for(var z:uint=t;z<t+6;z++){
//					trace(z,t+3);
					for(var j:uint=0;j<6;j++){						
						if(k<data.length && data[k]!="transparency"){
							
//							trace(data[k],k);
							//AQUI FALTA CALCULAR BIEN LOS PUNTOS 
							//_x=(x1+dx1*z+dx2*j)-currentDistance*factorx;
							//_y=(y1+dy1*z+dy2*j)-currentDistance*factory;								
							//INTENTE INVIRTIENDO LA MATRIZ DATA[DATA.LENGTH-K-1]
							
							_x=x1+dx1*z+dx2*j;
							_y=y1+dy1*z+dy2*j;	
							
							createcars(data[k],_x,_y);							
							addChild(objectCarsArray[ap]);
							
							ap++;
						}	
						
						k++;
					}
					
				}
				t=t+6;
				if(actualDistance<8){
					actualDistance+=2;
				}
				
			}
			
			
			
			
			
			
			/*	if(lastIndex < l){
			lastIndex = l;
			var l2:int=data.length-lastIndex-4;
			if(l2>=0 && data[l2]!="transparency" && data.length-lastIndex-4>=0)
			{
			trace("z<<<<",lastIndex)
			i=Math.floor(lastIndex/6);
			j =lastIndex%6;
			_x=-(x1+dx1*i+dx2*j)+ factorx*currentDistance;
			_y=-(y1+dy1*i+dy2*j)+ factory*currentDistance;	
			trace("puntos",_x,_y);
			//_x = factorx*lastIndex*anchoCarretera + x0 - factorx*currentDistance;
			//_y = factory*lastIndex*anchoCarretera + y0 - factory*currentDistance;
			createcars(data[l2],_x,_y);
			addChildAt(objectCarsArray[ap],0);
			ap++;
			//var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,new Image(Assets.getAtlasTexture(atlasName,data[l2])));
			//piragnaSprite.rotation = 15;
			//addChild(piragnaSprite);		
			}
			
			}
			*/
			
			
			var totalNum:uint = numChildren;
			for(var i:uint=0; i<totalNum; i++){
				//trace(getChildAt(i).x);
				//AQUI FALTA PONER EL LIMITE SUPERIOR
				if(getChildAt(i).x < -100){
//					trace("borrando",getChildAt(i).x);
					removeChildAt(i);
					totalNum--;
				}
			}
			
			
			
			/*	for (var i:uint = 0; i < 3*8*2; i++){
			for (var j:uint = 0; j < 6; j++){				
			trace(data[k]);
			if(k<data.length && data[k]!="transparency"){
			_x=x1+dx1*i+dx2*j;
			_y=y1+dy1*i+dy2*j;		
			trace("<<<",_y);
			createcars(data[k],_x,_y);
			addChildAt(objectCarsArray[objectCarsArray.length - 1],0);
			k++;
			}					
			}			
			}*/
			
		}
		
		override public function loadFirstAssetsByLayer():void{
			
			var i:uint;
			var j:uint;
			
			var dx:Number=anchoCarretera*factorx;
			var dy:Number=-anchoCarretera*factory;
			var dx1:Number=dx/3;
			var dy1:Number=-dy/3;
			var dx2:Number=dx/6;
			var dy2:Number=dy/6;
			k=0;
			for (i = 0; i < 15; i++)
			{
				for (j = 0; j < 6; j++)
				{
					//	trace(data[k]);
					if(k<data.length && data[k]!="transparency")
					{
//						trace(data[k]);
						//	trace(k,data[k],"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
						_x=x1+dx1*i+dx2*j;
						_y=y1+dy1*i+dy2*j;	
						createcars(data[k],_x,_y);
						
						addChild(objectCarsArray[ap]);
						
						//trace("cantidad de carros actual"+ap,_x,_y);
						
						
						ap++;
					}		
					k++;
				}			
			}
			
			
			
			/*for (var z:int=0; z<5; z++){
			_x =factorx*z*anchoCarretera+x0;
			_y =factory*z*anchoCarretera+y0;				
			
			if(data[z]!="transparency"){
			lastIndex = z;
			var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,new Image(Assets.getAtlasTexture(atlasName,data[data.length-i-1])));
			addChild(piragnaSprite);						
			}			
			}
			*/
			
			
		}
		
		
		
		override public function update():void{
			
			if(numChildren>0){
				
//				trace(numChildren);
				for(var j:uint=0; j<this.numChildren; j++){ 
					this.getChildAt(j).x -= this.getSpeed()*factorx;
					this.getChildAt(j).y -= this.getSpeed()*factory;
					}				
				}
			}
		}
	
}