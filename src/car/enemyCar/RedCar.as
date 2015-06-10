package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class RedCar extends Car
		
	{
		public function RedCar(posx:Number,posy:Number)
		{
			
			super(posx,posy, new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.react(Car.EST_MOVING);	
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
				}case Car.EST_DRIFTING:
				{
					this.drifting(args[1]);
					break;
				}	
					/*default:
					{
					break;
					}*/
			}
		}
		
		private function moving():void{
			this.setImage("moving_red_image");
			this.setState(Car.EST_MOVING);
		}
		
		private function exploding():void{
			this.setImage("exploding_red_image");
			this.setState(Car.EST_EXPLODING);
		}
		
		private function drifting(direction:String):void
		{
			switch(direction)
			{
				case "left":
				{
					this.setImage("drifting_left_red_image")
				}
				case "rigth":
				{
					this.setImage("drifting_rigth_red_image")
				}
			}
			this.setState(Car.EST_DRIFTING);
		}
		
	}
}