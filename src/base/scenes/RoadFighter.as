package base.scenes
{
	import base.ia.AIManager;
	import base.levels.map.GestorMap;
	import base.levels.map.Level1;
	import base.levels.map.Map;
	
	import car.hero.Hero;
	
	import core.General;
	
	import inputHandler.InputHandler;
	
	import resources.Resources;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class RoadFighter extends Sprite
	{
		private var aiManager:AIManager;
		private var gestorMap:GestorMap;
		private var level1:Map;
		private var currentLevel:uint;
		private var levels:Array;
		private var hero:Hero;
		private var speed:uint;
		private var hero2:Hero;

		private var levers:InputHandler;
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
			
			Resources.scaleContentFactor = Starling.current.contentScaleFactor;
						
			//Hero creations
			this.hero = new Hero(353,106);
			
			//Levers creation
			this.levers=new InputHandler();
					
			//Levels
			this.level1 = new Level1("Map_lvl01-Obstacles.json",hero, levers);
			this.levels[0] = level1;
									
			this.aiManager = new AIManager(this.level1);
					
			this.addChild(this.level1);

//			var rectangle:Rectangle = new Rectangle(hero.x, hero.y,126.5,20.1);
//			var rectangle2:Rectangle = new Rectangle(hero2.x, hero2.y,126.5, 20.1);
//			var ff:Quad = new Quad(126.5, 20.1);
//			ff.x = xxxx;
//			ff.y = hero.y;
//
//			ff.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
//			
//			ff.x = hero.x +15;
//			ff.y = hero.y - 25;
//
//			
//			var ff2:Quad = new Quad(60, 20.1 );
//			ff2.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
//			ff2.x = hero2.x+15;
//			ff2.y = hero2.y - 25;
//			
//			this.addChildAt(ff,0 );
//			this.addChildAt(ff2, 0);
//			if(rectangle.intersects(rectangle2))
//			{
//				trace("si si colombia, si si caribe");
//			}
//			else
//			{
//				trace("te hablo desde la prisión");
//			}
		}	
		
		public function cargarLevel():void{			
		}

		private function onEnterFrame(e:Event):void
		{
			//hilo principal
			update();
			updateIA();
		}
	
		private function update():void
		{
			this.level1.update();
		}
		
		private function updateIA():void
		{
			this.level1 = this.aiManager.update();
		}
	}
}