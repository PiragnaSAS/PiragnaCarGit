package gameStates
{
	import base.ia.AIManager;
	import base.levels.map.GestorMap;
	import base.levels.map.Level1;
	
	import car.hero.Hero;
	
	import inputHandler.InputHandler;

	public class PlayState extends GameState
	{
		private var levels:Array;
		private var currentLevel:uint = 0;
		private var level1:Level1;
		private var hero:Hero;
		private var speed:uint;
		private var hero2:Hero;
		private var aiManager:AIManager;
		private var gestorMap:GestorMap;
		
		private var levers:InputHandler;
		private var iALoaded:Boolean = false;
		//		private var xxxx:Number;
		//		private var yyyy:Number;

		public function PlayState(name:String){
			super(name);
			this.levels = [];//Hero creations
			this.hero = new Hero(100,100);
			
			//Levers creation
			this.levers=new InputHandler();
			
			//Levels
			this.level1= new Level1("1",hero, levers);
			this.levels[0] = level1;
			
			addChild(levels[currentLevel]);
		}
		
		override public function update():void{
			
			if(levels[currentLevel].update()){
				if(!this.iALoaded ){
					this.iALoaded = true;
					this.aiManager = new AIManager(this.levels[currentLevel]);
				}else{
					updateIA();
				}				
			}			
		}
		
		private function updateIA():void
		{
			this.levels[currentLevel] = this.aiManager.update();
		}
	}
}