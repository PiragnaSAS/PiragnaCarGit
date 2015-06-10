package base.scenes
{
	import assets.Assets;
	
	import base.ia.AIManager;
	import base.levels.map.GestorMap;
	import base.levels.map.Level1;
	
	import car.hero.Hero;
	
	import core.General;
	
	import inputHandler.InputHandler;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class RoadFighter extends Sprite
	{
		private var aiManager:AIManager;
		private var gestorMap:GestorMap;
		private var level1:Level1;
		private var currentLevel:uint;
		private var levels:Array;
		private var hero:Hero;
		private var speed:uint;
		private var hero2:Hero;

		private var levers:InputHandler;
		private var iALoaded:Boolean = false;
//		private var xxxx:Number;
//		private var yyyy:Number;

		public function RoadFighter()
		{			
			this.levels = [];
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
				
		private function onAddedToStage():void{
			// inicializar
			stage.stageWidth  = General.viewPortGame.width;
			stage.stageHeight = General.viewPortGame.height;
			
			Assets.scaleFactorContent = Starling.current.contentScaleFactor;
			Assets.prepareBitmapFonts("Font");			
			//Hero creations
			this.hero = new Hero(100,100);
			
			//Levers creation
			this.levers=new InputHandler();
					
			//Levels
			this.level1= new Level1("1",hero, levers);
			this.levels[0] = level1;
					
			this.addChild(this.level1);
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
			if(this.level1.update() )
			{
				if(!this.iALoaded )
				{
					this.iALoaded = true;
					this.aiManager = new AIManager(this.level1);
				}else
				{
					updateIA();
				}
				
			}
		}
		
		private function updateIA():void
		{
			this.level1 = this.aiManager.update();
		}
	}
}
