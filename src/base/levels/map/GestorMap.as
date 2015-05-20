package base.levels.map
{
	
    import starling.display.Sprite;
	
	public class GestorMap extends Sprite
	{
		private var map:Map;
		public function GestorMap(map:Map)
		{
			super();
			this.map=map;
		}
		
		
		public function getMapWidth():uint
		{
			return map.getMapWidth();
		}
		
		public function setMapWidth(newMapWidth:uint):void  
		{
			map.setMapWidth(newMapWidth);
		}
		
		public function getMapHeigth():uint
		{
			return map.getMapHeigth();
		}
		
		public function setMapHeith(newMapHeith:uint):void
		{
			map.setMapHeith(newMapHeith);
			
		}
		
		public function getTileWidth():uint{
			return map.getTileWidth();
		}
		
		public function setTileWidth(newTileWidth:uint):void{
			map.setTileWidth(newTileWidth);
		}
		public function getTileHeith():uint{
			return map.getTileHeith();
		}
		
		public function setTileHeith(newTileHeith:uint):void{
			map.setTileHeith(newTileHeith);
		}
		public function getTileSets():Array{
			return map.getTileSets();
		}
		public function setTileSets(newTileSets:Array):void{
			map.setTileSets(newTileSets);
		}
		public function getTotalTileSets():uint{
			return map.getTotalTileSets();
		}
		public function setTotalTileSets(newTotalTileSets:uint):void{
			map.setTotalTileSets(newTotalTileSets);
		}
	}
}