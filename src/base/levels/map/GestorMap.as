package base.levels.map
{
	
	
	
	import starling.display.Sprite;
	
	public class GestorMap extends Sprite
	{
		private var map:Map;
		public function GestorMap()
		{
			super();
		}
		public function crearMapa(scene:String="../assets/images/Scene/scene01.json"):Map{
			map = new Map(scene);
			return map;
		}
		
	}
}