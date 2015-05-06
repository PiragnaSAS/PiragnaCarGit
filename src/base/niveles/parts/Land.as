package base.niveles.parts
{
	import starling.display.Sprite;
	import recursos.Recursos;
	import starling.display.Image;

	public class Land extends Sprite
	{
		private var image:Image;
		
		public function Land(x:uint, y:uint)
		{
			this.image =  new Image(Recursos.obtenerTextura("SepArriba"));
			this.image.pivotX = 100;
			this.image.pivotY = 100;
			this.addChild(this.image);
		}
	}
}