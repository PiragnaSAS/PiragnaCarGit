package core
{
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	import escenas.Game;

	public final class General
	{
		public static const ESCENA_JUEGO:String = getQualifiedClassName(Game);
		//public static const ESCENA_PRESENTACION:String = getQualifiedClassName(Presentacion);
		//public static const ESCENA_INTRODUCCION:String = getQualifiedClassName(Introduccion);
		//public static const ESCENA_JUEGO_SAPO:String = getQualifiedClassName(JuegoSapo);
		//public static const ESCENA_REGISTRO:String = getQualifiedClassName(Registro);
		//public static const ESCENA_ALBUM:String = getQualifiedClassName(Album);
		
		public static var pantallaAncho:uint;
		public static var pantallaAlto:uint;
		public static var pantallaAspectRatio:Number;
		
		public static var viewPortBaseAncho:int;
		public static var viewPortBaseAlto:int;
		public static var viewPortBaseAspectRatio:Number;
		
		public static var viewPortBaseLimiteAncho:int;
		public static var viewPortBaseLimiteAlto:int;
		
		public static var viewPort:Rectangle = new Rectangle();
		public static var viewPortJuego:Rectangle = new Rectangle();
		public static var viewPortAspectRatio:Number;
		
		trace(">>> captura de tiempoInicial");
		public static const TIEMPO_INICIAL:uint = (new Date().getTime()) - getTimer();
		public static function get fecha():uint { return TIEMPO_INICIAL + getTimer(); }
		
		public function General() {}
		
		public static function calcularAspectRatioPantalla():void
		{
			pantallaAspectRatio = pantallaAlto/pantallaAncho;
		}
		
		public static function calcularAspectRatioBase():void
		{
			viewPortBaseAspectRatio = viewPortBaseAncho/viewPortBaseAlto;
		}
		
		public static function calcularViewPort(metodo:uint):void
		{
			var masAlto:Boolean = viewPortBaseAspectRatio < pantallaAspectRatio;
			
			switch(metodo)
			{
				case 0:
					if (masAlto)
					{
						viewPort.width = pantallaAncho; 
						viewPort.height = int(pantallaAncho * viewPortBaseAspectRatio);
						viewPort.y = int((pantallaAlto - viewPort.height) / 2);
					}
					else
					{
						viewPort.width  = int(pantallaAlto / viewPortBaseAspectRatio);
						viewPort.height = pantallaAlto;
						viewPort.x = int((pantallaAncho - viewPort.width) / 2);
					}
					break;
				
				case 1:
					viewPort.width = pantallaAncho;
					viewPort.height = pantallaAlto;
					viewPort.x = 0;
					viewPort.y = 0;
					break;
				
				case 2:
					//con limite
					break;
			}
			viewPortAspectRatio = viewPort.height/viewPort.width;
		}
		
		public static function calcularViewPortJuego():void
		{
			var masAlto:Boolean = viewPortBaseAspectRatio < viewPortAspectRatio;
			if (masAlto)
			{
				viewPortJuego.width = viewPortBaseAncho; 
				viewPortJuego.height = int(viewPortBaseAncho * viewPortAspectRatio);
				viewPortJuego.y = 0;
			}
			else
			{
				viewPortJuego.width  = int(viewPortBaseAlto / viewPortAspectRatio);
				viewPortJuego.height = viewPortBaseAlto;
				viewPort.x = 0;
			}
		}
	}
}