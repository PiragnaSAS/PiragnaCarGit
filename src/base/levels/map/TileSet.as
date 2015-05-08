package base.levels.map
{
	import flash.display.BitmapData;
	
	import starling.display.Sprite;
	
	public class TileSet extends Sprite
	{
		private var firstgid:uint		
		private var name:String;
		private var tileWidth:uint;
		private var source:String;
		private var tileHeight:uint;
		private var imageWidth:uint;
		private var imageHeight:uint;
		private var bitmapData:BitmapData;
		private var tileAmountWidth:uint;
		private var lastgid:uint;
		
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
		public function setFirstgid():void{
			
		}
		public function setName():void{
			
		}
		public function setTileWidth():void{
			
		}
		public function setSource():void{
			
		}
		public function setTileHeight():void{
			
		}
		public function setImageWidth():void{
			
		}
		public function setTileAmountWidth():void{
			
		}
		public function setLastgid():void{
			
		}
		public function getBitmapData():BitmapData
		{
			return this.bitmapData;
			
		}
		public function getFirstgid():uint{
			return this.firstgid;
		}
		public function getName():String{
			return this.name;
		}
		public function getTileWidth():uint{
			return this.tileWidth;
		}
		public function getSource():String{
			return this.source;
		}
		public function getTileHeight():uint{
			return this.tileHeight;
		}
		public function getImageWidth():uint{
			return this.imageHeight;
		}
		public function getTileAmountWidth():uint{
			return this.tileAmountWidth;
		}
		public function getLastgid():uint{
			return this.lastgid;
		}
				
	}
}
