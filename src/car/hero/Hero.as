package car.hero
{
	import car.Car;
	
	import resources.Resources;
	
	import starling.display.Image;

	public class Hero extends Car{
		
		private var score:uint = 0;
		private var fuel:uint = 100;
		
		public function Hero(x:Number, y:Number)
		{
			this.setCarImage( new Image(Resources.getTexture("CHero")));
			this.x = x;
			this.y = y;
			this.addChild(this.getCarImage());
		}
		
		override public function react(...args):void{
			switch(args[0])
			{
				case Car.EST_MOVING:
				{
					this.moving();
					break;
				}
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
					/*default:
					
					{
					break;
					}*/
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
		
		private function moving():void
		{
			this.setImage("moving_hero_image");
			this.setState(Car.EST_MOVING);
		}		
		
		
		public function getScore():uint{
			return score;
		}
		
		public function raiseScore():void{
			score++;
		}
			
		public function getFuel():uint{
			return fuel;
		}
		
		public function raiseFuel(fuel:uint):void{
			this.fuel += fuel;
		}
		
		public function decreaseFuel(gasolina:uint):void{
			this.fuel -= gasolina;
		}
	}
}