package resources
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	

	public class Resources
	{
		private static var _scaleContentFactor:int = 1;
		private static var sTextures:Dictionary = new Dictionary();
		private static var sSounds:Dictionary = new Dictionary();
		private static var sTextureAtlas:Dictionary = new Dictionary();
		private static var sXML:Dictionary = new Dictionary();
		private static var sBitmapFontsLoaded:Boolean;
		public static var factorDeEscalaDelContenido:Number;
		
		public function Resources(){}
		
		
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object = createObject(name);
				
				if (data is Bitmap)
					sTextures[name] = Texture.fromBitmap(data as Bitmap, true, true, _scaleContentFactor);
				else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray, _scaleContentFactor);
			}
			
			return sTextures[name];
		}
		
		public static function getAtlasTexture(atlasName:String, name:String):Texture
		{
			prepareAtlas(atlasName);
			return sTextureAtlas[atlasName].getTexture(name);
		}
		
		public static function getAtlasTextures(atlasName:String, prefix:String):Vector.<Texture>
		{
			prepareAtlas(atlasName);
			return sTextureAtlas[atlasName].getTextures(prefix);
		}
		
		public static function getSound(name:String):Sound
		{
			prepareSound(name)
			var sound:Sound = sSounds[name];
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + name);
		}
		
		public static function getXml(name:String):XML
		{
			prepareXML(name)
			var xml:XML = sXML[name];
			if (xml) return xml;
			else throw new ArgumentError("XML not found: " + name);
		}
		
		private static function prepareAtlas(name:String):void
		{
			if (sTextureAtlas[name] == undefined)
			{
				var texture:Texture = getTexture(name + "_Texture");
				var xml:XML = XML(createObject(name + "_Xml"));
				sTextureAtlas[name] = new TextureAtlas(texture, xml);
			}
		}
		
		private static function prepareSound(name:String):void
		{
			if (sSounds[name] == undefined)
			{
				sSounds[name] = new EncrustedResources[name]() as Sound;
			}   
		}
		
		private static function prepareXML(name:String):void
		{
			if (sXML[name] == undefined)
			{
				sXML[name] = XML(new EncrustedResources[name + "_Xml"]());
			}   
		}
		
		public static function prepareBitmapFonts(name:String):void
		{
			var texture:Texture = getTexture(name + "_Texture");
			var xml:XML = XML(createObject(name + "_Xml"));
			TextField.registerBitmapFont(new BitmapFont(texture, xml));
		}
		
		public static function prepareFonts(name:String):void
		{
			Font.registerFont(EncrustedResources[name]);
		}
		
		private static function createObject(name:String):Object
		{
			var textureClass:Class = _scaleContentFactor == 1 ? EncrustedResources_1x : EncrustedResources_2x;
			return new textureClass[name];
		}
		
		public static function clean():void
		{
			for each (var textureA:TextureAtlas in sTextureAtlas)
			textureA.dispose();
			sTextures = new Dictionary();
			
			for each (var texture:Texture in sTextures)
			texture.dispose();
			sTextureAtlas = new Dictionary();
			
			//private static var sSounds:Dictionary = new Dictionary();
			//private static var sTextureAtlas:Dictionary = new Dictionary();
			//private static var sXML:Dictionary = new Dictionary();
		}
		
		public static function get scaleContentFactor():Number { return _scaleContentFactor; }
		public static function set scaleContentFactor(value:Number):void 
		{
			_scaleContentFactor = value < 1.5 ? 1 : 2;
		}
	}
}