package collitionableObjects.groundCollitionableObjects
{
	import flash.security.X500DistinguishedName;
	
	import base.levels.map.parts.PiragnaSprite;
	
	import core.General;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class Obstacle extends Sprite
	{	
		private var name:String;
		private var _speed:Number;
		private var _x:Number;
		private var _y:Number;
		private var _type:uint;
		private var obstacleImage:DisplayObject;
		public static const TYPE_HOLE:uint = 0;
		public static const TYPE_OIL:uint = 1;
		
		public function Obstacle(imageObject:DisplayObject,newX:Number,newY:Number, type:uint){
			this._type=type;
			this.obstacleImage=imageObject;
			_x=newX;
			_y=newY;
			this.x=newX;
			this.y=newY;
			obstacleImage.alignPivot();
			trace(obstacleImage,_x,_y);
			addChildAt(obstacleImage,0);
		}
		
		public function update():void{
			this.getChildAt(0).x -= this.getSpeed();
			this.getChildAt(0).y += this.getSpeed()*Math.tan(Math.PI/6);										
			var child:DisplayObject;
			if(getChildAt(0).x < -100 && getChildAt(0).y > General.screenHeight+200){		
				child = getChildAt(0);
				var randomNumber:Number= Math.random()*200+80;
				child.x = getChildAt(0).x + randomNumber;
				child.y = getChildAt(0).y - randomNumber*Math.tan(Math.PI/6);
				removeChildAt(0);
				addChild(child);					
			}	
		}
		
		public function getName():String{
			return name;
		}
		
		public function getSpeed():Number
		{
			return _speed;
		}		
		
		public function get type():uint{
			return _type;
		}
		
		public function setSpeed(value:Number):void{
			_speed = value;
		}
		
	}
}