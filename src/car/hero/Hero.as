package car.hero
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import assets.Assets;
	
	import car.Car;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Hero extends Car{
		
		private var score:uint = 0;
		private var fuel:uint = 100;
		private var speed:Number = 2;
		private var numberDeaths:Number=0;
		
		private var timer:Timer;
		
		public function Hero(x=435, y=335){

			super(x,y, new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.removeChildAt(0);
			this.setCarImage( new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.getCarImage().alignPivot();
			this.x = x;
			this.y = y;
			this.setState(Car.EST_DEFAULT);
			this.addChild(this.getCarImage());
			this.setState(Car.EST_DEFAULT);
			this.timer=new Timer(350,0);
			timer.start();
		}
		
		override public function react(...args):void{
		}
		
		private function uncontrolled():void
		{
			this.setImage("default_hero_image");
			this.setState(Car.EST_UNCONTROLLABLE);
			
		}
		
		private function revive():void
		{
			this.setImage("default_hero_image");
			this.setState(Car.EST_REVIVING);
		}
		
		private function exploding():void
		{
			this.setImage("exploding_hero_image");
			this.setState(Car.EST_EXPLODING);
		}
		
		public function move(value:Number):void{
			this.movementX = value;
			this.movementY = value*Math.tan(Math.PI/6);
			
			if(this.movementX != 0){
				this.auxMovementX = this.movementX;
				this.auxMovementY = movementY;
			}			
		}		
		
		public function stopHero():void
		{
			this.movementY = this.movementX = 0;
		}
		
		public function getScore():uint{
			return score;
		}
		
		public function raiseScore():void{
			score+=50;
		}
		
		public function raiseSpecialScore():void{
			score+=1000;
		}
		
		public function getFuel():uint{
			return fuel;
		}
		
		public function raiseFuel(fuel:uint):void{
			this.fuel += fuel;
		}
		
		public function decreaseFuel(event:TimerEvent):void{
			if (fuel<=0){
				//aqii va el evento que para el juego cuando se acaba la gasolina	
			}
			this.fuel --;
		}
		
		public function decreaseFuelByOne():void{
			if (fuel<=0){
				//aqii va el evento que para el juego cuando se acaba la gasolina	
			}
			this.fuel -=1;
		}
		
		public function decreaseFuelBom():void{
			if (fuel<=0){
				//aqii va el evento que para el juego cuando se acaba la gasolina	
			}
			this.fuel -=10;
		}
		
		override public function update():void{
			timer.addEventListener(TimerEvent.TIMER,this.decreaseFuel);
			if(this.getState() == Car.EST_DEFAULT)
			{
				if(movementX == 0){
					
					if(auxMovementX < .1 && auxMovementX > -.1){
						auxMovementX = 0;
						auxMovementY = 0;
					}else{
						auxMovementX *= .9;
						auxMovementY = auxMovementX*Math.tan(Math.PI/6);
					}
					
				}
				this.x += auxMovementX;
				this.y += auxMovementY;
			}
			if(this.getState() == Car.EST_DRIFTING){
				this.handleDrift();
			}
			if(this.getState() == Car.EST_EXPLODING){
				this.handleExplode();
			}
		}
		
		private function handleExplode():void
		{
			this.setState(Car.EST_EXPLODED);
			this.removeChildAt(0);
			var crashImage:MovieClip = new MovieClip(Assets.getAtlasTextures("Cars","boom"),12);
			crashImage.alignPivot();
			crashImage.loop = false;
			Starling.juggler.add(crashImage);
			crashImage.play();
			crashImage.addEventListener(Event.COMPLETE, function(){trace("some")});
			this.addChild(crashImage);
		}		
		
		public  function getDeath():Number
		{
			return numberDeaths;
		}
		
		public function raiseDeath():void{
			this.numberDeaths+=1;
		}
		
	}
}