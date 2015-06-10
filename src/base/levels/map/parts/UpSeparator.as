package base.levels.map.parts
{

	
	import assets.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class UpSeparator extends Sprite
	{
		private var image:Image;
		
		public function UpSeparator(x:Number, y:Number)
		{
			this.image =  new Image(Assets.getTexture("SepArriba"));
			this.x = x;
			this.y =y;
			this.addChild(this.image);
		}
	}
}