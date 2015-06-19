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
		
		private function moving():void{
			this.setImage("moving_red_image");
			this.setState(Car.EST_MOVING);
		}
		
		private function exploding():void{
			this.setImage("exploding_red_image");
			this.setState(Car.EST_EXPLODING);
		}
	}
}