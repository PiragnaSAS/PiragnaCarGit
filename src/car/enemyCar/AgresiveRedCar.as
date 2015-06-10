package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class AgresiveRedCar extends RedCar
	{
		public function AgresiveRedCar(pox:Number,poy:Number)
		{
			super(pox,poy);
			/*this.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_red")));
			this.x=pox;
			this.y=poy;
			addChildAt(this.getCarImage(),0);
			this.react(Car.EST_MOVING);*/
		}
	}
}