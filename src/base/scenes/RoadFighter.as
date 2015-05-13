package base.scenes
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import base.ia.AIManager;
	import base.levels.map.GestorMap;
	import base.levels.map.Level1;
	import base.levels.map.Map;
	
	import car.hero.Hero;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class RoadFighter extends Sprite
	{
		private var iAManager:AIManager;
		private var gestorMap:GestorMap;
		private var level:Map;
		private var hero:Hero;
		private var speed:uint;
		private var hero2:Hero;
		
		public function RoadFighter()
		{
			this.level = new Level1("lvl1example.json");
			this.iAManager = new AIManager(this.level);
			this.hero = new Hero(458,458);
		//	this.hero.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
			
			this.hero2 = new Hero(435,435);
			//this.hero2.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
			
			//this.addChild(this.level);
			this.addChild(hero2);
			this.addChild(hero);
			
			
			var rectangle:Rectangle = new Rectangle(hero.x, hero.y,126.5,20.1);
			var rectangle2:Rectangle = new Rectangle(hero2.x, hero2.y,126.5, 20.1);
			var ff:Quad = new Quad(126.5, 20.1);
			//ff.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
			
			ff.x = hero.x;
			ff.y = hero.y;
			
			var ff2:Quad = new Quad(126.5, 20.1 );
			//ff2.alignPivot(HAlign.LEFT, VAlign.BOTTOM);
			ff2.x = hero2.x;
			ff2.y = hero2.y;
			
			this.addChildAt(ff,0 );
			this.addChildAt(ff2, 0);
			if(rectangle.intersects(rectangle2))
			{
				trace("si si colombia, si si caribe");
			}
			else
			{
				trace("te hablo desde la prisión");
			}
			
						
			
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
			var p:Point;
			var mt:Matrix = new Matrix();//faltan parametros
		//	this.level.update();
			var p_:Point = mt.transformPoint(p);
			
			//x = p_.x
			//y = p_.y
			
			var r:Rectangle = new Rectangle();
		
		}
		
		private function updateIA():void
		{
			this.level = this.iAManager.update();
		}
	}
}