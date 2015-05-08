package layers
{
	import starling.display.Sprite;
	
	public class CollitionLayer extends Sprite
	{
	 private var layer:Object;
		public function CollitionLayer(newLayer:Object)
		{
			
			this.layer=newLayer;
			
			super();
		}
	}
}