package base.levels.map
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import base.levels.map.parts.Tiles;
		
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;
	
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
			
		private var polyline:String;
		//<--aca
		
		private var tiles:Tiles;
		
		public function Map(scene:String)
		{	
					
			this.loadScene(scene);	
			
			/*this.addChild(this.backobjectsLayer);
			this.addChild(this.raceLayer);
			this.addChild(this.carsLayer);
			this.addChild(this.frontObjectsLayer);*/
			
			
		}	
		

		private function loadScene(scene:String):void
		{
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
			trace("here is here");		
			json = JSON.parse(e.target.data);				
			mapWidth = json["width"];
			mapHeight = json["height"];
			tileWidth = json["tilewidth"];
			tileHeight = json["tileheight"];
			tiles = new Tiles(json["tilesets"]);
					
			trace("---");
			createLayers();
		}	
		
			
		public function createLayers():void {
			throw new AbstractMethodError();			
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
				
		public function getJSON():Object{
			return json;
		}
						
		public function update():void{				
			throw new AbstractMethodError();			
		}
		
	}
}