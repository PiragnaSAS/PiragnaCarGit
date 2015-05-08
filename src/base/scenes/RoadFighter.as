package base.scenes
{
	import base.ia.AIManager;
	import base.levels.map.GestorMap;
	import base.levels.map.Level1;
	import base.levels.map.Map;
	
	import car.hero.Hero;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class RoadFighter extends Sprite
	{
		private var iAManager:AIManager;
		private var gestorMap:GestorMap;
		private var level:Map;
		private var hero:Hero;
		private var speed:uint;
		
		public function RoadFighter()
		{
			this.level = new Level1("lvl1example.json");
			this.iAManager = new AIManager(this.level);
			this.hero = new Hero();
			this.addChild(this.level);
		}
		
		public function cargarLevel():void{
			
			
		}
		private function onEnterFrame(e:Event):void
		{
			//hilo principal
			
			updateControls();
			update();
			updateIA();
		}
		
		private function updateControls():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function update():void
		{
		
		}
		
		private function updateIA():void
		{
			this.level = this.iAManager.update();
		}
	}
}