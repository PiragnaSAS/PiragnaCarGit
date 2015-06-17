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
		
		public function getCar():CarProgress{
			return car;
		}
		
		public function upDateProgress(advance:Number):void{
			car.x=165*Math.cos((Math.PI)/6)*advance;
			car.y=-165*Math.sin((Math.PI)/6)*advance;			
		}
	
	
	}
	
	
}