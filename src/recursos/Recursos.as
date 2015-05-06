package recursos
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
	

	public class Recursos
	{
		private static var _factorDeEscalaDelContenido:int = 1;
		private static var sTextures:Dictionary = new Dictionary();
		private static var sSounds:Dictionary = new Dictionary();
		private static var sTextureAtlas:Dictionary = new Dictionary();
		private static var sXML:Dictionary = new Dictionary();
		private static var sBitmapFontsLoaded:Boolean;
		
		public function Recursos(){}
		
		
		public static function obtenerTextura(nombre:String):Texture
		{
			if (sTextures[nombre] == undefined)
			{
				var data:Object = crearObjeto(nombre);
				
				if (data is Bitmap)
					sTextures[nombre] = Texture.fromBitmap(data as Bitmap, true, true, _factorDeEscalaDelContenido);
				else if (data is ByteArray)
					sTextures[nombre] = Texture.fromAtfData(data as ByteArray, _factorDeEscalaDelContenido);
			}
			
			return sTextures[nombre];
		}
		
		public static function obtenerTexturaDeAtlas(nombreAtlas:String, nombre:String):Texture
		{
			prepararAtlas(nombreAtlas);
			return sTextureAtlas[nombreAtlas].getTexture(nombre);
		}
		
		public static function obtenerTexturasDeAtlas(nombreAtlas:String, prefijo:String):Vector.<Texture>
		{
			prepararAtlas(nombreAtlas);
			return sTextureAtlas[nombreAtlas].getTextures(prefijo);
		}
		
		public static function obtenerSonido(nombre:String):Sound
		{
			prepararSonido(nombre)
			var sound:Sound = sSounds[nombre];
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + nombre);
		}
		
		public static function obtenerXml(nombre:String):XML
		{
			prepararXML(nombre)
			var xml:XML = sXML[nombre];
			if (xml) return xml;
			else throw new ArgumentError("XML not found: " + nombre);
		}
		
		private static function prepararAtlas(name:String):void
		{
			if (sTextureAtlas[name] == undefined)
			{
				var texture:Texture = obtenerTextura(name + "_Texture");
				var xml:XML = XML(crearObjeto(name + "_Xml"));
				sTextureAtlas[name] = new TextureAtlas(texture, xml);
			}
		}
		
		private static function prepararSonido(name:String):void
		{
			if (sSounds[name] == undefined)
			{
				sSounds[name] = new RecursosEncrustados[name]() as Sound;
			}   
		}
		
		private static function prepararXML(nombre:String):void
		{
			if (sXML[nombre] == undefined)
			{
				sXML[nombre] = XML(new RecursosEncrustados[nombre + "_Xml"]());
			}   
		}
		
		public static function prepararBitmapFonts(nombre:String):void
		{
			var texture:Texture = obtenerTextura(nombre + "_Texture");
			var xml:XML = XML(crearObjeto(nombre + "_Xml"));
			TextField.registerBitmapFont(new BitmapFont(texture, xml));
		}
		
		public static function prepararFonts(nombre:String):void
		{
			Font.registerFont(RecursosEncrustados[nombre]);
		}
		
		private static function crearObjeto(nombre:String):Object
		{
			var textureClass:Class = _factorDeEscalaDelContenido == 1 ? RecursosEncrustados_1x : RecursosEncrustados_2x;
			return new textureClass[nombre];
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
		
		public static function get factorDeEscalaDelContenido():Number { return _factorDeEscalaDelContenido; }
		public static function set factorDeEscalaDelContenido(value:Number):void 
		{
			_factorDeEscalaDelContenido = value < 1.5 ? 1 : 2;
		}
	}
}