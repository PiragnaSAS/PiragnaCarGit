package base.levels.map
{
	import starling.display.Sprite;
	import flash.display.BitmapData;
	
	public class TileSet extends Sprite
	{
		private var firstgid:uint;
		private var lastgid:uint;
		private var name:String;
		private var tileWidth:uint;
		private var source:String;
		private var tileHeight:uint;
		private var imageWidth:uint;
		private var imageHeight:uint;
		private var bitmapData:BitmapData;
		private var tileAmountWidth:uint;
		
		public function TileSet(firstgid, name, tileWidth, tileHeight, source, imageWidth, imageHeight)
		{
			super();
			this.firstgid = firstgid;
			this.name = name;
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			this.source = source;
			this.imageWidth = imageWidth;
			this.imageHeight = imageHeight;
			tileAmountWidth = Math.floor(imageWidth / tileWidth);
			lastgid = tileAmountWidth * Math.floor(imageHeight / tileHeight) + firstgid - 1;
		}
		
		public function setBitmapData(bitmapData:BitmapData):void
		{
			this.bitmapData=bitmapData;
			
		}
	}
}
