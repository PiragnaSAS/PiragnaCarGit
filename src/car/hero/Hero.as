package car.hero
{
	import car.Car;
	
	import assets.Assets;
	
	import starling.display.Image;

	public class Hero extends Car{
		
		private var score:uint = 0;
		private var fuel:uint = 100;
		private var speed:Number = 2;
		private var movementX:Number, movementY:Number;
		private var auxMovementX:Number, auxMovementY:Number;
		private var numberDeaths:Number=0;
		
		
		public function Hero(x=435, y=335){
			this.setCarImage( new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.x = x;
			this.y = y;
			this.auxMovementX = this.movementX = 0;
			this.auxMovementY = this.movementY = 0;
			
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
		
		private function drifting(direction:String):void
		{
			switch(direction)
			{
				case "left":
				{
					this.setImage("hero_left_drifting")
				}
				case "rigth":
				{
					this.setImage("hero_right_drifting")
				}
			}
			this.setState(Car.EST_DRIFTING);
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
		
		public  function getDeath():Number
		{
			return numberDeaths;
		}
		
		public function raiseDeath():void{
			this.numberDeaths+=1;
		}
	}
}