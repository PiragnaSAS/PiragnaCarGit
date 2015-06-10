package base.levels.map.parts
{

	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class PiragnaSprite extends Sprite
	{
		public function PiragnaSprite(x:Number, y:Number, displayObject:DisplayObject){
			this.x = x;
			this.y = y;
			displayObject.alignPivot();	
			this.addChild(displayObject);
		}
		
		public function getName():String
		{
			return this.name;
		}
	}
}