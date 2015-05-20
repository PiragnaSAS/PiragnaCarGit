
package base.levels.map.parts
{

	
	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PlaneLand extends Sprite
	{
		private var image:Image;
		public function PlaneLand(x:Number, y:Number)
		{
			super();
			this.image =  new Image(Resources.getTexture("PlaneGround"));
			this.x = x;
			this.y =y;
			this.addChild(this.image);
		
		}
	}
}