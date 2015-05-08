package layers
{
	import flash.display.BitmapData;
	
	import base.levels.map.TileSet;
	
	import starling.display.Sprite;
	import flash.display.Bitmap;
	import flash.geom.*;

	public class Layer extends Sprite
	{	protected var data:String;
		protected var height:Number;
		protected var name:String;
		protected var opacity:Number;
		protected var type:String;
		protected var visible:Boolean;
		protected var width:Number;
		protected var x:Number;
		protected var y:Number;
		protected var layer:JSON;
		
		public function Layer(layer:JSON)
		{
			this.layer=layer;
			data=layer["data"];
			height=layer["height"];
			name=layer["name"];
			opacity=layer["opacity"];
			type=layer["type"];
			visible=layer["visible"];
			width=layer["width"];
			x=layer["x"];
			y=layer["y"];
			
		}
		
		public function loadLayer(mapWidth:uint, mapHeight:uint, tileSets:Array, tileWidth:uint,screenBitmap:Bitmap):void
		{
			var tiles:Array = new Array();
			var tileLength:uint = 0;
			// assign the gid to each location in the layer
			var data:String = layer["data"];
			var dataarray:Array = data.split(",");
			var index:int=0;
			
			for (var i:int=0; i<layer["width"];i++){
				for (var j:int = 0; j<layer["hight"];j++){
					var id_key:int=data[index];
					if(id_key!=0){
						
					}
					index++;
				}
				
			}
			for each (var pos:uint in dataarray) {
				var gid:Number = dataarray[pos];
				// if gid > 0
				if (gid > 0) {
					tiles[tileLength] = gid;
				}
				tileLength++;
			}
			
			var useBitmap:BitmapData;			
			//Revizar
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
						if (tileGid >= tileset1.getFirstgid()-1 && tileGid <= tileset1.getLastgid()) {
							// we found the right tileset for this gid!
							currentTileset = tileset1;
							break;
						}
					}
					var destY:int = spriteForY * tileWidth;
					var destX:int = spriteForX * tileWidth;
					// basic math to find out where the tile is coming from on the source image
					tileGid -= currentTileset.getFirstgid() -1 ;
					var sourceY:int = Math.ceil(tileGid/currentTileset.getTileAmountWidth())-1;
					var sourceX:int = tileGid - (currentTileset.getTileAmountWidth() * sourceY) - 1;
					// copy the tile from the tileset onto our bitmap
					screenBitmap.bitmapData.copyPixels(currentTileset.getBitmapData(), new Rectangle(sourceX * currentTileset.getTileWidth(), sourceY * currentTileset.getTileWidth(), currentTileset.getTileWidth(), currentTileset.getTileHeight()), new Point(destX, destY), null, null, true);
					/*screenBitmapTopLayer.bitmapData.copyPixels(currentTileset.bitmapData, new Rectangle(sourceX * currentTileset.tileWidth, sourceY * currentTileset.tileWidth, currentTileset.tileWidth, currentTileset.tileHeight), new Point(destX, destY), null, null, true);*/
				
				}
			}
			/*addChild(screenBitmap);*/
			
		}
		
	}
}