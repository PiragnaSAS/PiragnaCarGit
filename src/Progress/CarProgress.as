package Progress
{
	import core.General;
	
	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class CarProgress extends Sprite
	{
		private var carImage:Image;
		public function CarProgress()
		{
		carImage = new Image(Resources.getTexture("carProgress"));
		carImage.alignPivot("center","center");
		carImage.width=General.viewPortGame.width/25;
		carImage.height=General.viewPortGame.width/25;
		carImage.x=6;
		carImage.y=91;
		addChild(carImage);
		}
		
		public function mov(x:Number,y:Number):void{
			this.carImage.x+=x;
			this.carImage.y+=y;
		}
	}
}