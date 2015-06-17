package collitionableObjects.groundCollitionableObjects
{
	
	import core.General;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class Obstacle extends Sprite 
	{	
		private var name:String;
		private var _x:Number;
		private var _y:Number;
		private var _type:uint;
		private var obstacleImage:DisplayObject;
		public static const TYPE_HOLE:uint = 0;
		public static const TYPE_OIL:uint = 1;
		private var _inside:Number=1;
		private var _speed:Number = 0;
		private var _saw:Boolean = false;
		
		public function Obstacle(imageObject:DisplayObject,newX:Number,newY:Number, type:uint, name:String){
			this.name = name;
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
		public function getInside():Number
		{
			return _inside;
		}
		
		public function setInside(value:Number):void
		{
			_inside = value;
		}
		public function get saw():Boolean
		{
			return _saw;
		}

		public function set saw(value:Boolean):void
		{
			_saw = value;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed= value;
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