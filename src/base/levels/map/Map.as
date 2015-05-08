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
		//<--aca
		private var tileSetsLoaded:uint=0;
		
		
		public function Map(scene:String)
		{			
			eventLoaders= new Array();
/*			var p1:Point =new Point();	
			var mt:Matrix = new Matrix();
			var p2:Point = mt.transformPoint(p1);
*/			loadScene(scene);
			addAllLayers();
						
		}
		
		private function addAllLayers():void
		{
			addChild(groundLayer);
			addChild(backobjectsLayer);
			addChild(raceLayer);
			addChild(frontObjectsLayer);
			addChild(carsLayer);
		}
		
		private function loadScene(scene:String):void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url = scene;
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
			mapWidth = json.attribute("width");
			mapHeight = json.attribute("height");
			tileWidth = json.attribute("tilewidth");
			tileHeight = json.attribute("tileheight");
			
			tilset();
			
			trace(json+"---");
			
			
		}
		
		private function tilset():void
		{
			var jsonCounter:uint=0;
			for each (var tileset:JSON in json.tileset) {
				var imageWidth:uint = json.tileset.attribute("imagewidth")[jsonCounter];
				var imageHeight:uint = json.tileset.attribute("imageheight")[jsonCounter];
				var firstGid:uint = json.tileset.attribute("firstgid")[jsonCounter];
				var tilesetName:String = json.tileset.attribute("name")[jsonCounter];
				var tilesetTileWidth:uint = json.tileset.attribute("tilewidth")[jsonCounter];
				var tilesetTileHeight:uint = json.tileset.attribute("tileheight")[jsonCounter];
				var tilesetImagePath:String = json.tileset.attribute("image")[jsonCounter];
				
				
				tileSets.push(new TileSet(firstGid, tilesetName, tilesetTileWidth, tilesetTileHeight, tilesetImagePath, imageWidth, imageHeight));
				jsonCounter++;
			}
			totalTileSets = jsonCounter;
			
			for (var i:int = 0; i < totalTileSets; i++) {
				trace("load tilset at " + tileSets[i].source);
				var loader:TileCodeEventLoader = new TileCodeEventLoader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, tilesLoadComplete);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loader.setTileSet(tileSets[i]);
				loader.load(new URLRequest(tileSets[i].source));
				eventLoaders.push(loader);
			}
			screenBitmap = new Bitmap(new BitmapData(mapWidth * tileWidth, mapHeight * tileHeight, false, 0x22ffff));
			screenBitmapTopLayer = new Bitmap(new BitmapData(mapWidth*tileWidth,mapHeight*tileHeight,true,0));
			
		}
		
	
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		private function tilesLoadComplete (e:Event):void {
			var currentTileset:TileSet = e.target.loader.tileSet;
			currentTileset.setBitmapData( Bitmap(e.target.content).bitmapData);
			tileSetsLoaded++;
			// wait until all the tileset images are loaded before we combine them layer by layer into one bitmap
			if (tileSetsLoaded == totalTileSets)
			{
				addTileBitmapData();
			}
		}
		
		private function addTileBitmapData():void {
			// load each layer
			for each (var layer:JSON in json.layer) 
			{				
				var layerName:String =layer["name"];			
				// decide where we're going to put the layer
				
				switch(layerName) {
					case "GroundLayer":												
						groundLayer = new GroundLayer(layer);	
						groundLayer.loadLayer(mapWidth, mapHeight, tileSets, tileWidth,screenBitmap);
						break;
					case "RaceLayer":
						raceLayer = new RaceLayer(layer);
						raceLayer.loadLayer(mapWidth, mapHeight, tileSets, tileWidth,screenBitmap);
						break;
					case "FrontObjectsLayer":
						frontObjectsLayer = new FrontObjectsLayer(layer);
						frontObjectsLayer.loadLayer(mapWidth, mapHeight, tileSets, tileWidth,screenBitmap);
						break;
					case "BackObjectsLayer":
						backobjectsLayer = new BackObjectsLayer(layer);
						backobjectsLayer.loadLayer(mapWidth, mapHeight, tileSets, tileWidth,screenBitmap);
						break;
					case "CarsLayer":
						carsLayer = new CarsLayer(layer);
						carsLayer.loadLayer(mapWidth, mapHeight, tileSets, tileWidth,screenBitmap);
						break;
					
					default:
						
				}
				
				
			
			/*for each (var objectgroup:JSON in JSON.objectgroup) {
				var objectGroup:String = objectgroup.attribute("name");
				switch(objectGroup) {
					case "Collision":
						for each (var object:XML in objectgroup.object) {
						var rectangle:Shape = new Shape();
						rectangle.graphics.beginFill(0x0099CC, 1);
						rectangle.graphics.drawRect(0, 0, object.attribute("width"), object.attribute("height") );
						rectangle.graphics.endFill();
						rectangle.x = object.attribute("x");
						rectangle.y = object.attribute("y");
						collisionTiles.push(rectangle);
						addChild(rectangle);
					}
						break;
					default:
						trace("unrecognized object type:", objectgroup.attribute("name"));
				}
			}
			// load background layer
			addChild(screenBitmap);
			// load player, enemies, powerups, etc
			
			
			
			// load top layer
			addChild(screenBitmapTopLayer);*/
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
		
		public function setTileHeith(newTileHeith:uint){
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