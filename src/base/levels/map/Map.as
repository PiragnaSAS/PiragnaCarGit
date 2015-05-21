package base.levels.map
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import base.levels.map.parts.Tiles;
	
	import car.hero.Hero;
	
	import events.LeverEvent;
	
	import inputHandler.InputHandler;
	
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;
	
	
	public class Map extends Sprite
	{
		private var json:Object;
		
		private var hero:Hero;
		private var levers:InputHandler;
		
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
		
		public function Map(scene:String, hero:Hero, levers:InputHandler)
		{	
			this.hero = hero;
			
			//Levers settings
			this.levers = levers;
			this.levers.addEventListener(LeverEvent.ROTATE, onRotate);
			
			
			this.levers.addEventListener(LeverEvent.ACCELERATE, onAcelerate);
			this.loadScene(scene);	
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
			this.addChild(hero);
			this.addChild(levers);
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
		
		
		private function onRotate(e:LeverEvent):void
		{
			//			xxxx=e.data.rotationValue;			
		}
		
		private function onAcelerate(e:LeverEvent):void
		{
			trace("+-+-+",e.data.rotationValue);
			
		}
	}
}