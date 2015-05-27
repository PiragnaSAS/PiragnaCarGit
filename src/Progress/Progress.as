package Progress
{
	import starling.display.Sprite;

	public class Progress extends Sprite
	{
		private var car:CarProgress;
		private var highway:HighwayProgress;
		public function Progress(){
			highway=new HighwayProgress();
			addChild(highway);
			car = new CarProgress();
			addChild(car);			
		}
		
		public function upDateProgress(advance:Number):void{
			car.x=229*Math.cos((Math.PI)/6)*advance;
			car.y=-229*Math.sin((Math.PI)/6)*advance;			
		}
	}
}