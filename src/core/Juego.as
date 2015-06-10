package core
{
	import flash.system.System;
	import flash.utils.getDefinitionByName;
	
	import eventos.EscenaEvento;
	
	import recursos.Recursos;
	
	import escenas.IEscena;
	import escenas.IEscenaPricipal;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Juego extends Sprite
	{
		private var escenaActual:IEscena;
		private var escenaPricipal:IEscenaPricipal;
		private var escenaPricipalNombreClass:String;
		
		public function Juego()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(EscenaEvento.CAMBIO_DE_ESCENA, cabiarDeEscena);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// inicializar
			stage.stageWidth  = General.viewPortJuego.width;
			stage.stageHeight = General.viewPortJuego.height;
			
			Recursos.factorDeEscalaDelContenido = Starling.current.contentScaleFactor;
			
			//Recursos.prepararBitmapFonts("LuckiestGuy01");
			//Recursos.prepararBitmapFonts("FranklinGothicHeavy");
			//Recursos.prepararFonts("FranklinGothicHeavy");
			
			//Recursos.obtenerSonido("General").play(0,int.MAX_VALUE);//Sonido general
			
			
			escenaPricipalNombreClass = General.ESCENA_JUEGO;
			
			//verEscena(General.ESCENA_PRESENTACION);
			verEscenaPrincipal();
		}
		
		private function cabiarDeEscena(event:EscenaEvento):void
		{
			if (event.nombreClassDeEscenaObjetibo == null) return;
			
			if (!(event.target is IEscenaPricipal)) cerrarEscena();
			
			if (event.nombreClassDeEscenaObjetibo == escenaPricipalNombreClass) 
				verEscenaPrincipal();
			else
				verEscena(event.nombreClassDeEscenaObjetibo);
		}
		
		private function verEscena(sceneNameClass:String):void
		{
			if (escenaActual) return;
			
			var escenaClass:Class = getDefinitionByName(sceneNameClass) as Class;
			escenaActual = new escenaClass() as IEscena;
			
			addChild(escenaActual as Sprite);
		}
		
		private function verEscenaPrincipal():void
		{
			System.pauseForGCIfCollectionImminent(0);
			System.gc();
			
			if (escenaPricipal == null){
				var escenaClass:Class = getDefinitionByName(escenaPricipalNombreClass) as Class;
				escenaPricipal = new escenaClass() as IEscenaPricipal;
				addChild(escenaPricipal as Sprite);
			} else { 
				escenaPricipal.resume();
			}
		}
		
		private function cerrarEscena():void
		{
			(escenaActual as Sprite).removeFromParent(true);
			escenaActual = null;
		}
	}
}