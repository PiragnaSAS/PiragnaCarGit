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
		}
		
		private function moving():void{
			this.setImage("moving_taxi_image");
			this.setState(Car.EST_MOVING);
		}
		
		private function exploding():void{
			this.setImage("exploding_taxi_image");
			this.setState(Car.EST_EXPLODING);
		}		
	}
}