package inputHandler
{
	import flash.geom.Point;
	
	import core.General;
	
	import events.LeverEvent;
	
	import inputHandler.lever.Lever;
	
	import assets.Assets;
	
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
		private var leverOne:Lever, leverTwo:Lever;
		
		public function InputHandler(){
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);		
		}
		
		private function onAdded():void{
			inputQuad = new Quad(General.viewPortGame.width, General.viewPortGame.height, 0xffffff);
			inputQuad.alpha = 0;
			inputQuad.addEventListener(TouchEvent.TOUCH, onTouch);
			
			leverOne=new Lever(Assets.getAtlasTexture("Gui", "handler_1_1"), Assets.getAtlasTexture("Gui", "handler_1_0"), General.viewPortGame.width/25);
			leverTwo=new Lever(Assets.getAtlasTexture("Gui", "handler_0_1"), Assets.getAtlasTexture("Gui", "handler_0_0"), General.viewPortGame.width/25);		
			
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
				var midQuadY:uint= -coordinate.x * General.screenAspectRatio + inputQuad.height;
				if(touch.phase == TouchPhase.BEGAN){
					if(coordinate.y < midQuadY){
						leverOne.visible=true;
						leverOne.setCoordinatePosition(new Point(40,40));
					}else{
						leverTwo.visible = true;
						leverTwo.setCoordinatePosition(new Point(General.viewPortGame.width-60,General.viewPortGame.height-20));
					}					
				}
				if(touch.phase == TouchPhase.MOVED){
					if(leverOne.visible==true){	
						leverOne.setMovingPoint(touch.getLocation(this));	
					}else{						
						leverTwo.setMovingPointAcelerator(touch.getLocation(this));	
					}
				}
				
				if(touch.phase == TouchPhase.ENDED){	
					if(leverOne.visible==true){
						leverOne.visible=false;
						leverOne.setMovingPoint(leverOne.getCoordinatePoint());
						dispatchEvent(new LeverEvent(LeverEvent.BREAK_ROTATION,true));						
					}else{
						leverTwo.visible=false;
						dispatchEvent(new LeverEvent(LeverEvent.BREAK,true));						
					}
				}
				
			}else if(touches.length >= 2){
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
							leverOne.setCoordinatePosition(new Point(40,40));						
						}
				}
				
				if(touchB.phase == TouchPhase.BEGAN){		
						if(coordinateB.y > midQuadB){
							leverTwo.visible=true;
							leverTwo.setCoordinatePosition(new Point(General.viewPortGame.width-60,General.viewPortGame.height-20));
						}
				}
				
				if(touchA.phase == TouchPhase.MOVED){
					if(leverOne.visible==true){
						leverOne.setMovingPoint(touchA.getLocation(this));  	
					}
				}
				
				if(touchB.phase == TouchPhase.MOVED){
					if(leverTwo.visible==true){
						leverTwo.setMovingPointAcelerator(touchB.getLocation(this));					
				}
				}
				if(touchA.phase == TouchPhase.ENDED) {
						leverOne.visible=false;
						dispatchEvent(new LeverEvent(LeverEvent.BREAK_ROTATION,true));						
				}
				
				if(touchB.phase == TouchPhase.ENDED){
						leverTwo.visible=false;
						dispatchEvent(new LeverEvent(LeverEvent.BREAK,true));						
					}
				}
		
			}
			
		}
	}
