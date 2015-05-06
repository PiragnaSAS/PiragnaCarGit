package base.levels.map.parts
{
	import starling.display.Sprite;
	
	import recursos.Recursos;
	
	import starling.display.Image;

	public class UpSeparator extends Sprite
	{
		private var image:Image;
		
		public function UpSeparator(x:Number, y:Number)
		{
			this.image =  new Image(Recursos.obtenerTextura("SepArriba"));
			this.x = x;
			this.y =y;
			this.addChild(this.image);
		}
	}
}