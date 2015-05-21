package base.levels.map.parts
{

	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class PiragnaSprite extends Sprite
	{
		private var image:Image; 
		public function PiragnaSprite(x:Number, y:Number, name:String){
			this.x = x;
			this.y = y;
			image = new Image(Resources.getTexture(name))
			image.alignPivot();			
			this.addChild(image);

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