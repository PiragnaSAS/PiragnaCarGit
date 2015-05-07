package base.levels.map
{
	import flash.display.Loader;

	public class TileCodeEventLoader extends Loader
	{
		private  var tileSet:TileSet;
		public function TileCodeEventLoader()
		{
				super();	
		}
		
		public function setTileSet(tileSet:TileSet):void
		{
			this.tileSet=tileSet;			
		}
	}
}