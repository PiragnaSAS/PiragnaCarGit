package base.scenes
{
	import base.ia.IAManager;
	import base.levels.map.Map;
	import car.hero.Hero;
	import resources.Resources;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class RoadFighter extends Sprite
	{
		private var iAManager:IAManager;
		private var level:Map;
		private var hero:Hero;
		
		private var speed:uint;
		
		public function RoadFighter()
		{
			//this.level = new Level1();
			this.iAManager = new IAManager(this.level);
			this.hero = new Hero();
			
			this.addChild(this.level);
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
		
		private function update()
		{
		
		}
		
		private function updateIA()
		{
			this.level = this.iAManager.update();
		}
	}
}