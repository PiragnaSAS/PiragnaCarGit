package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	
	import base.scenes.RoadFighter;
	
	import core.General;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	public class ProyectoCarro extends Sprite
	{
		trace("holi");
		private var starling:Starling;
		
		public function ProyectoCarro()
		{
			trace("awui");
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			General.screenWidth = stage.fullScreenWidth;
			General.screenHeight = stage.fullScreenHeight;
			General.calculateAspectRatioScreen();
			
			General.viewPortBaseWidth = 480;
			General.viewPortBaseHeight = 320;
			//General.viewPortBaseLimiteAncho = 512+30;
			//General.viewPortBaseLimiteAlto = 384+30;
			General.calculateAspectRatioBase();
			
			General.calculateViewPort(1);
			General.calculateViewPortGame();
			
			var initialImage:Sprite = createInitialImage(General.viewPort, General.screenWidth > General.viewPortBaseWidth);
			addChild(initialImage);
			
			trace ("utyu",RoadFighter);
			
			starling = new Starling(RoadFighter, stage, General.viewPort);
			
			starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, function(e:Event):void
			{
				removeChild(initialImage);
				initialImage = null;
				starling.start();
				
				starling.simulateMultitouch = true;
				starling.showStats = true;
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
		
		private function createInitialImage(viewPort:Rectangle, isHD:Boolean):Sprite
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