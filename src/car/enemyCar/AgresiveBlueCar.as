package car.enemyCar
{
	import flash.geom.Point;
	
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;
	public class AgresiveBlueCar extends BlueCar
	{
		
		public function AgresiveBlueCar(pox:Number,poy:Number)
		{
			super(pox,poy);
		}
		
		private function moving(heroPos:Point):void{
			this.setImage("moving_agresive_blue_image");
			this.setState(Car.EST_MOVING);
			
		}
		
		private function exploding():void{
			this.setImage("exploding_agresive_blue_image");
			this.setState(Car.EST_EXPLODING);
		}
	}
}