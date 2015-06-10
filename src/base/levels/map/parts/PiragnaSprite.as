package base.levels.map.parts
{

	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class PiragnaSprite extends Sprite
	{
		public function PiragnaSprite(x:Number, y:Number, displayObject:DisplayObject, name:String){
			this.x = x;
			this.y = y;
			displayObject.alignPivot();	
			this.addChild(displayObject);
			this.name = name;
		}
		
		public function getName():String
		{
			return this.name;
		}
	}
}