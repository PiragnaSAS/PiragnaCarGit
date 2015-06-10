package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class Truck extends Car
	{
		public function Truck(posx:Number,posy:Number){
			super(posx,posy, new Image(Assets.getAtlasTexture("Cars","truck")));
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
					/*default:
					{
					break;
					}*/
			}
		}
		
		private function moving():void{
			this.setImage("moving_truck_image");
			this.setState(Car.EST_MOVING);
		}
		
		
		
		
	}
}