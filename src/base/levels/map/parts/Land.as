package base.levels.map.parts
{

	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class Land extends Sprite
	{
		private var image:Image;
		
		public function Land(x:Number, y:Number)
		{
			this.image =  new Image(Resources.getTexture("Ground"));
			this.x = x;
			this.y =y;
			this.addChild(this.image);
		}
	}
}