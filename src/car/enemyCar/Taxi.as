package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class Taxi extends Car
	{
		
		
	  	public function Taxi(posx:Number,posy:Number)
		{
			super(posx,posy, new Image(Assets.getAtlasTexture("Cars","car_yellow")));
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
			this.setImage("moving_taxi_image");
			this.setState(Car.EST_MOVING);
		}
		
		private function exploding():void{
			this.setImage("exploding_taxi_image");
			this.setState(Car.EST_EXPLODING);
		}
		
		private function drifting(direction:String):void
		{
			switch(direction)
			{
				case "left":
				{
					this.setImage("drafting_left_taxi_image")
				}
				case "rigth":
				{
					this.setImage("drafting_rigth_taxi_image")
				}
			}
			this.setState(Car.EST_DRIFTING);
		}
		
	}
}