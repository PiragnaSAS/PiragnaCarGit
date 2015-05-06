package core
{
	import flash.system.System;
	import flash.utils.getDefinitionByName;
	
	import events.EventScene;
	
	import resources.Resources;
	
	import scene.IPrincipalScene;
	import scene.IScene;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var currentScene:IScene;
		private var principalScene:IPrincipalScene;
		private var princiaplSceneClassName:String;
		
		public function Game()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(EventScene.SCENE_CHANGE, changeScene);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// inicializar
			stage.stageWidth  = General.viewPortGame.width;
			stage.stageHeight = General.viewPortGame.height;
			
			Resources.factorDeEscalaDelContenido = Starling.current.contentScaleFactor;
			
			//Recursos.prepararBitmapFonts("LuckiestGuy01");
			//Recursos.prepararBitmapFonts("FranklinGothicHeavy");
			//Recursos.prepararFonts("FranklinGothicHeavy");
			
			//Recursos.obtenerSonido("General").play(0,int.MAX_VALUE);//Sonido general
			
			
			princiaplSceneClassName = General.SCENE_GAME;
			
			//verEscena(General.ESCENA_PRESENTACION);
			viewPrincipalScene();
		}
		
		private function changeScene(event:EventScene):void
		{
			if (event.targetSceneClassName== null) return;
			
			if (!(event.target is IPrincipalScene)) cerrarEscena();
			
			if (event.targetSceneClassName == princiaplSceneClassName) 
				viewPrincipalScene();
			else
				viewScene(event.targetSceneClassName);
		}
		
		private function viewScene(sceneNameClass:String):void
		{
			if (currentScene) return;
			
			var escenaClass:Class = getDefinitionByName(sceneNameClass) as Class;
			currentScene = new escenaClass() as IScene;
			
			addChild(currentScene as Sprite);
		}
		
		private function viewPrincipalScene():void
		{
			System.pauseForGCIfCollectionImminent(0);
			System.gc();
			
			if (principalScene == null){
				var escenaClass:Class = getDefinitionByName(princiaplSceneClassName) as Class;
				principalScene = new escenaClass() as IPrincipalScene;
				addChild(principalScene as Sprite);
			} else { 
				principalScene.resume();
			}
		}
		
		private function cerrarEscena():void
		{
			(currentScene as Sprite).removeFromParent(true);
			currentScene = null;
		}
	}
}