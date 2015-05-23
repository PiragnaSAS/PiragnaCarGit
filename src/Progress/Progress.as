package Progress
{
	import starling.display.Sprite;

	public class Progress extends Sprite
	{
		private var car:CarProgress;
		private var highway:HighwayProgress;
		
		public function Progress()
		{
			highway=new HighwayProgress();
			addChild(highway);
			car = new CarProgress();
			addChild(car);
			
		}
		
		public function upDateProgress(advance:Number):void{
			x=229*advance;
			y=-x*Math.sin((3*Math.PI)/2);
			car.mov(x,y);
		}
	}
}