package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	
	import core.General;
	import core.Juego;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	public class ProyectoCarro extends Sprite
	{
		private var starling:Starling;
		
		public function ProyectoCarro()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			General.pantallaAncho = stage.fullScreenWidth;
			General.pantallaAlto = stage.fullScreenHeight;
			General.calcularAspectRatioPantalla();
			
			General.viewPortBaseAncho = 480;
			General.viewPortBaseAlto = 320;
			//General.viewPortBaseLimiteAncho = 512+30;
			//General.viewPortBaseLimiteAlto = 384+30;
			General.calcularAspectRatioBase();
			
			General.calcularViewPort(1);
			General.calcularViewPortJuego();
			
			var imagenDeArranque:Sprite = crearImagenDeArranque(General.viewPort, General.pantallaAncho > General.viewPortBaseAncho);
			addChild(imagenDeArranque);
			
			starling = new Starling(Juego, stage, General.viewPort);
			
			starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, function(e:Event):void
			{
				removeChild(imagenDeArranque);
				imagenDeArranque = null;
				starling.start();
				
				starling.simulateMultitouch = true;
				//starling.showStats = true;
			});
			
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, 
				function (e:Event):void { 
					starling.start();
					SoundMixer.soundTransform.volume=1;
				});
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, 
				function (e:Event):void {
					starling.stop();
					SoundMixer.soundTransform.volume=0;
				});
		}
		
		private function crearImagenDeArranque(viewPort:Rectangle, isHD:Boolean):Sprite
		{
			var sprite:Sprite = new Sprite();
			/*
			var fondo:Bitmap = isHD ?
				new AssetEmbeds_2x.Fondo1() : new RecursosEncrustados_1x.Fondo1();
			
			fondo.smoothing = true;
			sprite.addChild(fondo);
			
			var cargando:Bitmap = isHD ?
				new RecursosEncrustados_2x.Cargando() : new RecursosEncrustados_1x.Cargando();
			
			cargando.smoothing = true;
			cargando.x = fondo.width - cargando.width-64;
			cargando.y = fondo.height - cargando.height-64;
			sprite.addChild(cargando);
			
			sprite.x = viewPort.x;
			sprite.y = viewPort.y;
			sprite.width  = viewPort.width;
			sprite.height = viewPort.height;
			*/
			return sprite;
		}
	}
}