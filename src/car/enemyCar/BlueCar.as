package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class BlueCar extends Car
	{
		public function BlueCar(posx:Number,posy:Number)
		{
			super(posx,posy, new Image(Assets.getAtlasTexture("Cars","car_blue")));
			this.react(Car.EST_MOVING);	
		}
		
		private function moving():void{
			this.setImage("moving_blue_image");
			this.setState(Car.EST_MOVING);
		}
		
		private function exploding():void{
			this.setImage("exploding_blue_image");
			this.setState(Car.EST_EXPLODING);
		}
	}
}