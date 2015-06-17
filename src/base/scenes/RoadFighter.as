package base.scenes
{
	import flash.utils.Dictionary;
	
	import assets.Assets;
	
	import core.General;
	
	import gameStates.GameState;
	import gameStates.MenuState;
	import gameStates.PlayState;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;


	public class RoadFighter extends Sprite
	{
		
		//Game states
		private var statesDictionary:Dictionary;
		
		private var currentState:GameState;
		private var playState:GameState;
		private var menuState:GameState;
			
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
			
			playState = new PlayState("PlayState");
			menuState = new MenuState("MenuState");
			
			currentState = playState;
			
			statesDictionary[playState.getName()] = playState;
			statesDictionary[menuState.getName()] = menuState;
			
			addChild(currentState);

			//Levers creation
			this.levers=new InputHandler();
					
			//Levels
			this.level1= new Level1("1",hero, levers);
			this.levels[0] = level1;
					
			this.addChild(this.level1);
			
			
//			var q:Quad = new Quad(General.viewPortGame.width,General.viewPortGame.height);
//			q.alpha = .5;
//			scaleX = scaleY = .2;
//			addChild(q);
//			x = General.viewPortGame.width/2;
//			y = General.viewPortGame.height/2;
		}	
		
		public function cargarLevel():void{			
		}

		private function onEnterFrame(e:Event):void
		{
			//hilo principal
			update();
		}
	
		private function update():void
		{
			currentState.update();
		}
		
		private function setCurrentState(state:String):void{
			currentState.dispose();
			currentState = statesDictionary[state];
		}
	}
}
