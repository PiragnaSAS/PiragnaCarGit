package car.hero
{
	import flash.utils.Timer;
	
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;
	
	public class Hero extends Car{
		
		private var score:uint = 0;
		private var fuel:uint = 100;
		private var speed:Number = 2;
		private var movementX:Number, movementY:Number;
		private var auxMovementX:Number, auxMovementY:Number;
		private var numberDeaths:Number=0;
		
		
		//vars to handle drifts
		private var driftDirection:Boolean; //0 left 1 right
		private var driftInitialXPosition:Number;
		private var driftInitialYPosition:Number;
		private var driftSpeedX:Number = 3;
		private var driftSpeedY:Number = 1;
		private var driftMaxX:Number = 50;
		private var driftMaxY:Number =  50;
		
		private var driftSpeedXRight:Number = 3;
		private var driftSpeedYRight:Number = 1;
		private var timer:Timer;
		
		
		public function Hero(x=435, y=335){

			super(x,y, new Image(Assets.getAtlasTexture("Cars","car_red")));
			
			this.removeChildAt(0);
			this.setCarImage( new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.x = x;
			this.y = y;
			this.auxMovementX = this.movementX = 0;
			this.auxMovementY = this.movementY = 0;
			this.setState(Car.EST_DEFAULT);
			this.addChild(this.getCarImage());
			
			this.setState(Car.EST_DEFAULT);
			this.timer=new Timer(500,0);
			
			timer.start();
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
		
		public function decreaseFuel():void{
			this.fuel --;
		}
		
		public function decreaseFuelBom():void{
			this.fuel -=5;
		}
		
		override public function update():void{
			
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
			if(this.getState() == Car.EST_DRIFTING)
			{
				this.handleDrift();
			}
			
			
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