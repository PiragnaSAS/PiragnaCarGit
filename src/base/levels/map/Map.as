package base.levels.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import layers.CarsAndBorderLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	import layers.ObjectsLayer;
	import layers.RaceLayer;
	
	import starling.display.Sprite;

	public class Map extends Sprite
	{
		private var json:Object;
		private var mapWidth:uint;
		private var mapHeight:uint;
		private var tileWidth:uint;
		private var tileHeight:uint;
		private var tileSets:Array;
		private var totalTileSets:uint;
		
		private var screenBitmap:Bitmap; // for drawing the map
		private var screenBitmapTopLayer:Bitmap; // data of an image, for drawing the map that the character will move under
		
		private var eventLoaders:Array;
		
		private var groundLayer:GroundLayer;
		private var objectsLayer:ObjectsLayer;
		private var raceLayer:RaceLayer;
		private var frontObjectsLayer:FrontObjectsLayer;
		private var carsAndBorderLayer:CarsAndBorderLayer;
		private var tileSetsLoaded:uint=0;
		
		
		
		public function Map(scene:String)
		{
			eventLoaders= new Array();
			cargarScene(scene);
			groundLayer = new GroundLayer();
			objectsLayer = new ObjectsLayer();
			raceLayer = new RaceLayer();
			frontObjectsLayer = new FrontObjectsLayer();
			carsAndBorderLayer = new CarsAndBorderLayer();
			
/*			var p1:Point =new Point();	
			var mt:Matrix = new Matrix();
			var p2:Point = mt.transformPoint(p1);
*/			
			addChild(groundLayer);
			addChild(objectsLayer);
			addChild(raceLayer);
			addChild(frontObjectsLayer);
			addChild(carsAndBorderLayer);			
		}
		
		private function cargarScene(scene:String):void
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
			var jsonCounter:uint=0;
			json = JSON.parse(e.target.data);				
			mapWidth = json.attribute("width");
			mapHeight = json.attribute("height");
			tileWidth = json.attribute("tilewidth");
			tileHeight = json.attribute("tileheight");
			
			
			for each (var tileset:JSON in json.tileset) {
				var imageWidth:uint = json.tileset.image.attribute("width")[jsonCounter];
				var imageHeight:uint = json.tileset.image.attribute("height")[jsonCounter];
				var firstGid:uint = json.tileset.attribute("firstgid")[jsonCounter];
				var tilesetName:String = json.tileset.attribute("name")[jsonCounter];
				var tilesetTileWidth:uint = json.tileset.attribute("tilewidth")[jsonCounter];
				var tilesetTileHeight:uint = json.tileset.attribute("tileheight")[jsonCounter];
				var tilesetImagePath:String = json.tileset.image.attribute("source")[jsonCounter];
				
				
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
				loader.load(new URLRequest("../assets/" + tileSets[i].source));
				eventLoaders.push(loader);
			}
			screenBitmap = new Bitmap(new BitmapData(mapWidth * tileWidth, mapHeight * tileHeight, false, 0x22ffff));
			screenBitmapTopLayer = new Bitmap(new BitmapData(mapWidth*tileWidth,mapHeight*tileHeight,true,0));
			trace(json+"---");
			
			
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
			for each (var layer:JSON in json.layer) {
				var tiles:Array = new Array();
				var tileLength:uint = 0;
				// assign the gid to each location in the layer
				for each (var tile:JSON in layer.data.tile) {
					var gid:Number = tile.attribute("gid");
					// if gid > 0
					if (gid > 0) {
						tiles[tileLength] = gid;
					}
					tileLength++;
				}
				
				var useBitmap:BitmapData;
				
				var layerName:String = layer.attribute("name")[0];
				
				// decide where we're going to put the layer
				var layerMap:int = 0;
				switch(layerName) {
					case "Top":
						layerMap = 1;
						break;
					default:
						//trace("using base layer");
				}
				
				// store the gid into a 2d array
				var tileCoordinates:Array = new Array();
				for (var tileX:int = 0; tileX < mapWidth; tileX++) {
					tileCoordinates[tileX] = new Array();
					for (var tileY:int = 0; tileY < mapHeight; tileY++) {
						tileCoordinates[tileX][tileY] = tiles[(tileX+(tileY*mapWidth))];
					}
				}
				
				for (var spriteForX:int = 0; spriteForX < mapWidth; spriteForX++) {
					for (var spriteForY:int = 0; spriteForY < mapHeight; spriteForY++) {
						var tileGid:int = int(tileCoordinates[spriteForX][spriteForY]);
						var currentTileset:TileSet;
						// only use tiles from this tileset (we get the source image from here)
						for each( var tileset1:TileSet in tileSets) {
							if (tileGid >= tileset1.firstgid-1 && tileGid <= tileset1.lastgid) {
								// we found the right tileset for this gid!
								currentTileset = tileset1;
								break;
							}
						}
						var destY:int = spriteForY * tileWidth;
						var destX:int = spriteForX * tileWidth;
						// basic math to find out where the tile is coming from on the source image
						tileGid -= currentTileset.firstgid -1 ;
						var sourceY:int = Math.ceil(tileGid/currentTileset.tileAmountWidth)-1;
						var sourceX:int = tileGid - (currentTileset.tileAmountWidth * sourceY) - 1;
						// copy the tile from the tileset onto our bitmap
						if(layerMap == 0) {
							screenBitmap.bitmapData.copyPixels(currentTileset.bitmapData, new Rectangle(sourceX * currentTileset.tileWidth, sourceY * currentTileset.tileWidth, currentTileset.tileWidth, currentTileset.tileHeight), new Point(destX, destY), null, null, true);
						}
						else if (layerMap == 1) {
							screenBitmapTopLayer.bitmapData.copyPixels(currentTileset.bitmapData, new Rectangle(sourceX * currentTileset.tileWidth, sourceY * currentTileset.tileWidth, currentTileset.tileWidth, currentTileset.tileHeight), new Point(destX, destY), null, null, true);
						}
					}
				}
			}
			
			for each (var objectgroup:XML in xml.objectgroup) {
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
			addChild(screenBitmapTopLayer);
		}
	}
}