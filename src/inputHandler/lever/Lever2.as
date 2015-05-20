package inputHandler.lever
{
	import core.General;
	
	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Lever2 extends Sprite
	{
		
		private var area:Quad;
		private var p0:Image,p1:Image,p3:Image,p2:Image;
		public function Lever2()
		{
			
			super();
			init();
			
			
		}
		
		private function init():void{
			area=new Quad(General.viewPortGame.width,General.viewPortGame.height);
			area.addEventListener(TouchEvent.TOUCH,onTouch);
			addChild(area);
			area.alpha=0;
			p0=new Image(Resources.getTexture("p1"));
			p0.alignPivot();
			p0.alpha=0;
			addChild(p0);
			p1=new Image(Resources.getTexture("p1"));
			p1.alignPivot();
			p1.alpha=0;
			addChild(p1);
			p2=new Image(Resources.getTexture("p1"));
			p2.alignPivot();
			p2.alpha=0;
			addChild(p2);
			p3=new Image(Resources.getTexture("p1"));
			p3.alignPivot();
			p3.alpha=0;
			addChild(p3);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(this);
			
			if(!touches)return;
			trace(touches.length,touches);
			
		}
	}
}