package Progress
{
	import starling.display.Sprite;

	public class Progress extends Sprite
	{
		private var car:CarProgress;
		private var highway:HighwayProgress;
		
<<<<<<< HEAD
		public function Progress(){
			highway=new HighwayProgress();
			addChild(highway);
			car = new CarProgress();
			addChild(car);			
		}
		
		public function upDateProgress(advance:Number):void{
			car.x=229*Math.cos((Math.PI)/6)*advance;
			car.y=-229*Math.sin((Math.PI)/6)*advance;			
=======
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
>>>>>>> 6f5875f5fd17925a1e0da9ee7d7e1b10a3b2f742
		}
	}
}