package car.hero
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import base.levels.map.Map;
	
	import car.Car;
	
	import assets.Assets;
	import car.Car;
	
	import starling.display.Image;

	public class Hero extends Car{
		
		private var score:Number;
		private var fuel:Number;
		private var movementX:Number, movementY:Number;
		private var auxMovementX:Number, auxMovementY:Number;
		private var numberDeaths:Number=0;
		
		//vars to handle drifts
		private var driftDirection:Boolean; //0 left 1 right
		private var driftInitialXPosition:Number;
		private var driftInitialYPosition:Number;
		private var driftSpeedX:Number = 8;
		private var driftSpeedY:Number = 6;
		private var driftMaxX:Number = 150;
		private var driftMaxY:Number =  150;
		
		private var driftSpeedXRight:Number = 10;
		private var driftSpeedYRight:Number = 3;
		
		
		public function Hero(x=435, y=335){
			this.setCarImage( new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.x = x;
			this.y = y;
			this.auxMovementX = this.movementX = 0;
			this.auxMovementY = this.movementY = 0;
			this.timerFuel = new Timer(500);
			timerFuel.start();
			timerFuel.addEventListener(TimerEvent.TIMER, decreaseFuel);
			this.outOfGas = false;
			this.setState(Car.EST_DEFAULT);
			this.addChild(this.getCarImage());
		}
		
		override public function react(...args):void{
			switch(args[0])
			{
				case Car.EST_EXPLODING:
				{
					this.exploding();
					break;
				}
				case Car.EST_DRIFTING:
				{
					this.drifting(args[1]);
					break;
				}	
				case Car.EST_REVIVING:
				{
					this.revive();
					break;
				}
				case Car.EST_UNCONTROLLABLE:
				{
					this.uncontrolled();
					break;
				}
			}
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
		
		public function drifting(direction:Boolean):void
		{
			this.setState(Car.EST_DRIFTING);
			this.driftDirection = direction;
			this.driftInitialXPosition = this.x;
			this.driftInitialYPosition = this.y;
		}
		
		private function exploding():void
		{
			this.setImage("exploding_hero_image");
			this.setState(Car.EST_EXPLODING);
		}
		
		public function move(value:Number):void
		{
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
		
		public function getScore():Number{
			return score;
		}
		
		public function raiseScore():void{
			score+=50;
		}
		
		public function raiseSpecialScore():void{
			score+=1000;
		}
			
		public function getFuel():Number{
			return fuel;
		}
		
		public function setFuel(value:Number):void{
			this.fuel=value;
		}
		
		public function raiseFuel(bonusfuel:Number=10):void{
			this.fuel += bonusfuel;
		}
		
		public function decreaseFuel(type:String):void{
			this.fuel--;
		}
		
		public function raiseDeath():void{
			this.numberDeaths+=1;
		}
		
		public function getDeaths():Number{
			return this.numberDeaths;
		}
		
		public function isOutOfGas():Boolean{
			return this.outOfGas;	
		}
		
		public function setOutOfGas(outOfGas:Boolean):void{
			this.outOfGas = outOfGas;
		}
			
<<<<<<< HEAD
		override public function update():void{
			if(movementX == 0){
				if(auxMovementX < .1 && auxMovementX > -.1){
					auxMovementX = 0;
					auxMovementY = 0;
				}else{
					auxMovementX *= .9;
					auxMovementY = auxMovementX*Math.tan(Math.PI/6);
=======
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
>>>>>>> f307ff6d02ed29fb1fb00855e86e324fb0b3b641
				}
				
				this.x += auxMovementX;
				this.y += auxMovementY;
			}
			if(this.getState() == Car.EST_DRIFTING)
			{
				this.handleDrift();
			}
			
<<<<<<< HEAD
			
			this.x += auxMovementX;
			this.y += auxMovementY;
			
=======
			
		}
		
		private function handleDrift():void
		{
			if(!this.driftDirection)
			{
				if(this.x <= (this.driftInitialXPosition + this.driftMaxX) && this.y >= (this.driftInitialYPosition - this.driftMaxY))
				{
					this.x = this.x + this.driftSpeedX;
					this.y = this.y - this.driftSpeedY;
				}
				else
				{
					this.setState(Car.EST_DEFAULT);
				}	
			}
			else
			{
				if(this.x < (this.driftInitialXPosition + this.driftMaxX) && this.y < (this.driftInitialYPosition + this.driftMaxY))
				{
					this.x = this.x + this.driftSpeedXRight;
					this.y = this.y - this.driftSpeedYRight;
				}
				else
				{
					this.setState(Car.EST_DEFAULT);
				}
			}
			
>>>>>>> f307ff6d02ed29fb1fb00855e86e324fb0b3b641
		}
		
	}
}