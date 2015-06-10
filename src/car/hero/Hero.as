package car.hero
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import base.levels.map.Map;
	
	import car.Car;
	
	import resources.Resources;
	
	import starling.display.Image;

	public class Hero extends Car{
		
		private var score:Number;
		private var fuel:Number;
		private var movementX:Number, movementY:Number;
		private var auxMovementX:Number, auxMovementY:Number;
		private var timerFuel:Timer;
		private var level:Map;
		private var numberDeaths:Number;
		private var outOfGas:Boolean;
		
		public function Hero(x=435, y=335){			
			this.level = level;
			this.fuel = 100;
			this.score = 0;
			this.numberDeaths = 0;
			this.setCarImage( new Image(Resources.getTexture("CHero")));
			this.x = x;
			this.y = y;
			this.auxMovementX = this.movementX = 0;
			this.auxMovementY = this.movementY = 0;
			this.timerFuel = new Timer(500);
			timerFuel.start();
			timerFuel.addEventListener(TimerEvent.TIMER, decreaseFuel);
			this.outOfGas = false;
			
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
		
	}
}