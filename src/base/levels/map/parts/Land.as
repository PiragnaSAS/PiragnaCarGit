package base.levels.map.parts
{
	import starling.display.Sprite;
	import recursos.Recursos;
	import starling.display.Image;

	public class Land extends Sprite
	{
		private var image:Image;
		
		public function Land(x:Number, y:Number)
		{
			this.image =  new Image(Recursos.obtenerTextura("Ground"));
			this.x = x;
			this.y =y;
			this.addChild(this.image);
		}
	}
}