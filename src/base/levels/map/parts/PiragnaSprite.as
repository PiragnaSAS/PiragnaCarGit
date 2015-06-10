package base.levels.map.parts
{

	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class PiragnaSprite extends Sprite
	{
		private var image:Image; 
		private var name:String;
		public function PiragnaSprite(x:Number, y:Number, name:String){
			this.x = x;
			this.y = y;
			image = new Image(Resources.getTexture(name))
			image.alignPivot();	
			this.name = name;
			this.addChild(image);
		}
		
		public function getName():String
		{
			return this.name;
		}
	}
}