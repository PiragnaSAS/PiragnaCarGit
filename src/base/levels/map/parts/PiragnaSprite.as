package base.levels.map.parts
{
	import starling.display.Sprite;
	
	import resources.Resources;
	
	import starling.display.Image;

	public class PiragnaSprite extends Sprite
	{
		public function PiragnaSprite(x:Number, y:Number, name:String){
			this.x = x;
			this.y = y;
			trace(name);
			this.addChild(new Image(Resources.getTexture(name)));
		}
	}
}