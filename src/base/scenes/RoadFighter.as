package base.scenes
{
	import flash.utils.Dictionary;
	
	import assets.Assets;
	
	import base.levels.map.Level1;
	
	import core.General;
	
	import gameStates.GameState;
	import gameStates.MenuState;
	import gameStates.PlayState;
	
	import inputHandler.InputHandler;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class RoadFighter extends Sprite
	{
		
		//Game states
		private var statesDictionary:Dictionary;
		
		private var currentState:GameState;
		private var playState:GameState;
		private var playState2:GameState;
		private var menuState:GameState;
		private var levers:InputHandler;
		private var level1:Level1;
		private var levels:Array;
		private var currentLevel:uint = 1;
			
		public function RoadFighter()
		{			
			
			statesDictionary = new Dictionary();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
				
		private function onAddedToStage():void{
			// inicializar
			stage.stageWidth  = General.viewPortGame.width;
			stage.stageHeight = General.viewPortGame.height;
			
			Assets.scaleFactorContent = Starling.current.contentScaleFactor;
			Assets.prepareBitmapFonts("Font");			
			
			playState = new PlayState(currentLevel.toString());
			playState2 = new PlayState(currentLevel.toString());
			menuState = new MenuState("MenuState");
			
			currentState = playState;
			
			statesDictionary[playState.getName()] = playState;
			statesDictionary[menuState.getName()] = menuState;
			statesDictionary["2"] = playState2;
			
			addChild(currentState);
		}	
		
		public function cargarLevel():void{			
		}

		private function onEnterFrame(e:Event):void
		{
			//hilo principal
			update();
			if(currentState is PlayState)
			{
				var pState:PlayState = currentState as PlayState;
				if(pState.isEnded())
				{
					currentLevel++;
					this.setCurrentState(currentLevel.toString());
				}
			}
		}
	
		private function update():void
		{
			currentState.update();
		}
		
		private function setCurrentState(state:String):void{
			this.removeChildAt(0);
			currentState = statesDictionary[state];
			this.addChild(currentState);
		}
	}
}
