package base.levels.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import layers.BackObjectsLayer;
	import layers.CarsLayer;
	import layers.CollitionLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	import layers.RaceLayer;
	
	import starling.display.Sprite;

	public class Map extends Sprite
	{
		private var json:Object;
		
		
		private var screenBitmap:Bitmap; // for drawing the map
		private var screenBitmapTopLayer:Bitmap; // data of an image, for drawing the map that the character will move under
		
		private var eventLoaders:Array;
		
		//--->aqui
		private var mapWidth:uint;
		private var mapHeight:uint;
		private var tileWidth:uint;
		private var tileHeight:uint;
		private var tileSets:Array;
		private var totalTileSets:uint;
		
		private var groundLayer:GroundLayer;
		private var backobjectsLayer:BackObjectsLayer;
		private var raceLayer:RaceLayer;
		private var frontObjectsLayer:FrontObjectsLayer;
		private var carsLayer:CarsLayer;
		private var collitionLayer:CollitionLayer;
		private var polyline:String;
		//<--aca
		private var tileSetsLoaded:uint=0;
		
		
		public function Map(scene:String)
		{			
//<<<<<<< HEAD
			

			eventLoaders= new Array();
/*			var p1:Point =new Point();	
			var mt:Matrix = new Matrix();
			var p2:Point = mt.transformPoint(p1);
*/			loadScene(scene);	
			
//=======
//			eventLoaders= new Array();
///*			var p1:Point =new Point();	
//			var mt:Matrix = new Matrix();
//			var p2:Point = mt.transformPoint(p1);
//*/			loadScene(scene);
//			addAllLayers();
//>>>>>>> 652f98777f6483fd8c134faf283d789a94879edf
						
		}
		
		
		
		private function loadScene(scene:String):void
		{
			trace("seraquellega");
			trace(scene);

			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url = scene;
			trace(request.url);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(request);
		}
		private function onIOError(e:IOErrorEvent):void{
			trace("error: "+e.errorID);
		}
		
		private function onLoaderComplete(e:Event):void 
		{		
					
			json = JSON.parse(e.target.data);				
			mapWidth = json["width"];
			mapHeight = json["height"];
			tileWidth = json["tilewidth"];
			tileHeight = json["tileheight"];
			
			
		
			
			trace("---");
			createLayers();
			
			
		}	
		
			
		private function createLayers():void {
			// load each layer
			
			
			for each (var layer:Object in json["layers"]) 
			{	
				trace("holaquehace");
				
				var layerName:String =layer["name"];
				
				// decide where we're going to put the layer
				
				switch(layerName) {
					case "GroundLayer":	
						
						groundLayer = new GroundLayer(layer);						
						break;
					case "RaceLayer":
						raceLayer = new RaceLayer(layer);						
						break;
					case "FrontObjectsLayer":
						frontObjectsLayer = new FrontObjectsLayer(layer);						
						break;
					case "BackObjectsLayer":
						backobjectsLayer = new BackObjectsLayer(layer);						
						break;
					case "CarsLayer":
						carsLayer = new CarsLayer(layer);						
						break;
					case "CollitionLayer":
						collitionLayer= new CollitionLayer(layer,json);
						break;
					default:
						
				}		
				
		
			}
		}
	
		public function getMapWidth():uint
		{
			return mapWidth;
		}
		
		public function setMapWidth(newMapWidth:uint):void  
		{
			this.mapWidth=newMapWidth;
		}
		
		public function getMapHeigth():uint
		{
			return mapHeight;
		}
		
		public function setMapHeith(newMapHeith:uint):void
		{
			this.mapHeight=newMapHeith;
		}
		
		public function getTileWidth():uint{
			return tileWidth;
		}
		
		public function setTileWidth(newTileWidth:uint):void{
			this.tileWidth=newTileWidth;
		}
		public function getTileHeith():uint{
			return tileHeight;
		}
		
		public function setTileHeith(newTileHeith:uint):void{
			this.tileHeight=newTileHeith;
		}
		public function getTileSets():Array{
			return tileSets;
		}
		public function setTileSets(newTileSets:Array):void{
			this.tileSets=newTileSets;
		}
		public function getTotalTileSets():uint{
			return totalTileSets;
		}
		public function setTotalTileSets(newTotalTileSets:uint):void{
			this.totalTileSets=newTotalTileSets;
		}
		public function getGroundLayer():GroundLayer{
			return groundLayer;
		}
		public function setGroundLayer(newGroundLayer:GroundLayer):void{
			this.groundLayer=newGroundLayer;
		}
		public function getBackObjectsLayer():BackObjectsLayer{
			return backobjectsLayer;
		}
		public function setBackObjectsLayer(newBackObjectsLayer:BackObjectsLayer):void{
			this.backobjectsLayer=newBackObjectsLayer;
		}
		public function getRaceLayer():RaceLayer{
			return raceLayer;
		}
		public function setRaceLayer(newRaceLayer:RaceLayer):void{
			this.raceLayer=newRaceLayer;
		}
		public function getFrontObjectsLayer():FrontObjectsLayer{
			return frontObjectsLayer;
		}
		public function setFrontObjectsLayer(newFrontObjectsLayer:FrontObjectsLayer):void{
			this.frontObjectsLayer=newFrontObjectsLayer;
		}
		public function getCarsLayer():CarsLayer{
			return carsLayer;
		}
		public function setCarsLayer(newCarsLayer:CarsLayer):void{
			this.carsLayer=newCarsLayer;
		}
		
	
	
	}
}