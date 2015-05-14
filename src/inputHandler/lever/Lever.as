package inputHandler.lever
{
	import flash.geom.Point;
	
	import events.LeverEvent;
	
	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Lever extends Sprite{
		
		private var coordinatePoint:Point;
		private var height:uint, width:uint;
		private var radius:uint;
		private var baseImage:Image, leverImage:Image;
		private var xx:int;
		
		public function Lever(leverTexture:Texture, radius:uint){			
			
			this.radius = radius;
			
			baseImage = new Image(Resources.getTexture("ControlBase"));
			baseImage.width = radius*2;
			baseImage.height = radius*2;			
			baseImage.alpha = 0.5;
					
			leverImage = new Image(leverTexture);
			leverImage.width = radius*4/3;
			leverImage.height = radius*4/3;
			leverImage.alpha = 0.5;
			leverImage.rotation=Math.PI/4;
			
			this.visible = false;
			
			addChild(baseImage);
			baseImage.alignPivot("center","center");

			addChild(leverImage);
			leverImage.alignPivot("center","center");
			
			xx=0;
		}
		
		public function setCoordinatePosition(position:Point):void{
			this.coordinatePoint = position;
			this.leverImage.x = position.x;
			this.leverImage.y = position.y;
			baseImage.x = position.x;
			baseImage.y = position.y;
		}
		
		public function setMovingPoint(movementPoint:Point):void{	
			var dist:Number =Math.sqrt(Math.pow((movementPoint.x - this.coordinatePoint.x),2) + Math.pow((movementPoint.y - coordinatePoint.y),2)) 
			if(dist < radius){
					this.leverImage.x = movementPoint.x;
					this.leverImage.y = movementPoint.y;
					
					if((coordinatePoint.y-movementPoint.y)*Math.abs(coordinatePoint.x-movementPoint.x)>0){
						dispatchEvent(new LeverEvent(LeverEvent.ROTATE,true,{rotationValue:-dist/radius}));
					}else{
						dispatchEvent(new LeverEvent(LeverEvent.ROTATE,true,{rotationValue:dist/radius}));
					}
			}else{
					var theta:Number = Math.atan2(movementPoint.y-coordinatePoint.y,movementPoint.x - coordinatePoint.x);
					this.leverImage.x = coordinatePoint.x + Math.cos(theta)*radius;
					this.leverImage.y = coordinatePoint.y + Math.sin(theta)*radius;
					if((coordinatePoint.y-movementPoint.y)*Math.abs(coordinatePoint.x-movementPoint.x)>0){
						dispatchEvent(new LeverEvent(LeverEvent.ROTATE,true,{rotationValue:-dist/radius}));
					}else{
						dispatchEvent(new LeverEvent(LeverEvent.ROTATE,true,{rotationValue:dist/radius}));
					}
			}
			
		}
		
		public function setMovingPointAcelerator(movementPoint:Point):void{	
			
			var distance:Number = Math.sqrt(Math.pow((movementPoint.x - this.coordinatePoint.x),2) + Math.pow((movementPoint.y - coordinatePoint.y),2));
			var dist:Number = Math.sqrt(Math.pow((leverImage.x - this.coordinatePoint.x),2) + Math.pow((leverImage.y - coordinatePoint.y),2));
			if(distance < radius*3){
				if((movementPoint.y > coordinatePoint.y) && (movementPoint.x < coordinatePoint.x)){
					this.leverImage.x = coordinatePoint.x;
					this.leverImage.y = coordinatePoint.y;
					dispatchEvent(new LeverEvent(LeverEvent.ACCELERATE,true,{rotationValue:dist/radius}));
				}else{
					this.leverImage.x = coordinatePoint.x + Math.cos(-Math.PI/4)*distance;
					this.leverImage.y = coordinatePoint.y + Math.sin(-Math.PI/4)*distance;
					dispatchEvent(new LeverEvent(LeverEvent.ACCELERATE,true,{rotationValue:dist/radius}));
				}
			}else{
				if((movementPoint.y > coordinatePoint.y) && (movementPoint.x < coordinatePoint.x)){
					this.leverImage.x = coordinatePoint.x;
					this.leverImage.y = coordinatePoint.y;
					dispatchEvent(new LeverEvent(LeverEvent.ACCELERATE,true,{rotationValue:dist/radius}));
				}else{
					this.leverImage.x = coordinatePoint.x + Math.cos(-Math.PI/4)*radius*3;
					this.leverImage.y = coordinatePoint.y + Math.sin(-Math.PI/4)*radius*3;
					dispatchEvent(new LeverEvent(LeverEvent.ACCELERATE,true,{rotationValue:dist/radius}));
				}
			}
			
			}
		
	
	}
	
	}
			

	
	
