package inputHandler
{
	import flash.geom.Point;
	
	import core.General;
	
	import inputHandler.lever.Lever;
	
	import resources.Resources;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	

	public class InputHandler extends Sprite
	{
		private var inputQuad:Quad;
		private var quadMid:Quad;
		private var quad1:Quad, quad2:Quad, quad3:Quad, quad4:Quad;
		private var leverOne:Lever, leverTwo:Lever;
		
		public function InputHandler(){
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);		
		}
		
		private function onAdded():void{
			inputQuad = new Quad(General.screenWidth, General.screenHeight, 0xffffff);
			inputQuad.alpha = 0;
			inputQuad.addEventListener(TouchEvent.TOUCH, onTouch);
			trace(General.screenAspectRatio);
			
			leverOne=new Lever(Resources.getTexture("ControlLever2"), General.screenWidth/25);
			leverTwo=new Lever(Resources.getTexture("ControlLever1"), General.screenWidth/25);		
			
			addChild(inputQuad);
			addChild(leverOne);
			addChild(leverTwo);
		}
		
		private function onTouch(e:TouchEvent):void{
			var touches:Vector.<Touch> = e.getTouches(this);			
			
			if(!touches)return;
			
			if(touches.length == 1){
				var touch:Touch = touches[0];
				var coordinate:Point = touch.getLocation(this);
				var midQuadY:uint= -coordinate.x * General.screenAspectRatio + inputQuad.height;;
				if(touch.phase == TouchPhase.BEGAN){
					if(coordinate.y < midQuadY){
						leverOne.visible=true;
						leverOne.setCoordinatePosition(coordinate);
					}else{
						leverTwo.visible = true;
						leverTwo.setCoordinatePosition(coordinate);
						trace("hola soy un fantasma")
					}					
				}
				if(touch.phase == TouchPhase.MOVED){
					if(coordinate.y < midQuadY){	
						leverOne.setMovingPoint(touch.getLocation(this));	
					}else{						
						leverTwo.setMovingPointAcelerator(touch.getLocation(this));	
					}
				}
				if(touch.phase == TouchPhase.ENDED){	
					if(coordinate.y < midQuadY){
						leverOne.visible=false;
					}else{
						leverTwo.visible=false;
					}
				}
			}else if(touches.length == 2){
				var touchA:Touch;
				var touchB:Touch;
				var coordinateB:Point;
				var coordinateA:Point;
				var midQuadA:uint;
				var midQuadB:uint;
				
				if(touches[0].getLocation(this).y > -touches[0].getLocation(this).x * General.screenAspectRatio + inputQuad.height){
					touchB = touches[0];
				}else{
					touchB = touches[1];		
					touchA = touches[0];
				}
				
				if(touches[0].getLocation(this).y< -touches[0].getLocation(this).x * General.screenAspectRatio + inputQuad.height)
					touchA = touches[0];
				else{
					touchB = touches[0];
					touchA = touches[1];
				}
				coordinateB =touchB.getLocation(this);
				coordinateA = touchA.getLocation(this);
				midQuadA = -coordinateA.x * General.screenAspectRatio + inputQuad.height;				
				midQuadB = -coordinateB.x * General.screenAspectRatio + inputQuad.height;
				
				if(touchA.phase == TouchPhase.BEGAN){
	 					if(coordinateA.y < midQuadA){			
							leverOne.visible=true;
							leverOne.setCoordinatePosition(coordinateA);						
						}
				}
				
				if(touchB.phase == TouchPhase.BEGAN){		
						if(coordinateB.y > midQuadB){
							leverTwo.visible=true;
							leverTwo.setCoordinatePosition(coordinateB);	
						}
				}
				
				if(touchA.phase == TouchPhase.MOVED){		
					if(coordinateA.y < midQuadA){	
						leverOne.setMovingPoint(touchA.getLocation(this));							
				   	}
				}
				
				if(touchB.phase == TouchPhase.MOVED){
					if(coordinateB.y > midQuadB){	
						leverTwo.setMovingPointAcelerator(touchB.getLocation(this));
					}					
				}
				
				if(touchA.phase == TouchPhase.ENDED) {
					if(coordinateA.y < midQuadA){
						leverOne.visible=false;
					}
				}
				
				if(touchB.phase == TouchPhase.ENDED){
					if(coordinateB.y > midQuadB){
						leverTwo.visible=false;
					}					
				}
		
			}
			
		}
		
	}
	
}