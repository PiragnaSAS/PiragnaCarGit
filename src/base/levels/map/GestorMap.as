package base.levels.map
{
	
	
	
	import mx.core.mx_internal;
	
	import layers.BackObjectsLayer;
	import layers.CarsLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	import layers.RaceLayer;
	
	import starling.display.Sprite;
	
	public class GestorMap extends Sprite
	{
		private var map:Map;
		public function GestorMap()
		{
			super();
		}
		public function createMap(scene:String="../assets/images/Scene/scene01.json"):Map{
			map = new Map(scene);
			return map;
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
		
		public function setTileHeith(newTileHeith:uint){
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
		public function getGroundLayer():GroundLayer{
			return map.getGroundLayer();
		}
		public function setGroundLayer(newGroundLayer:GroundLayer):void{
			map.setGroundLayer(newGroundLayer);
		}
		public function getBackObjectsLayer():BackObjectsLayer{
			return map.getBackObjectsLayer();
		}
		public function setBackObjectsLayer(newBackObjectsLayer:BackObjectsLayer):void{
			map.setBackObjectsLayer(newBackObjectsLayer);
		}
		public function getRaceLayer():RaceLayer{
			return map.getRaceLayer();
		}
		public function setRaceLayer(newRaceLayer:RaceLayer):void{
			map.setRaceLayer(newRaceLayer);
		}
		public function getFrontObjectsLayer():FrontObjectsLayer{
			return map.getFrontObjectsLayer();
		}
		public function setFrontObjectsLayer(newFrontObjectsLayer:FrontObjectsLayer):void{
			map.setFrontObjectsLayer(newFrontObjectsLayer);
		}
		public function getCarsLayer():CarsLayer{
			return map.getCarsLayer();
		}
		public function setCarsLayer(newCarsLayer:CarsLayer):void{
			map.setCarsLayer(newCarsLayer);
		}
		
	}
}