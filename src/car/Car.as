package car
{
	import flash.geom.Point;
	
	import collitionableObjects.Padrino;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;

	public class Car extends Sprite implements Padrino
	{
		private var actualImage:String;
		private var actualState:uint;
		private var position:Point;
		private var carImage:DisplayObject;
		
		public static const EST_MOVING:uint = 0;
		public static const EST_DRIFTING:uint = EST_MOVING + 1 ;
		public static const EST_UNCONTROLLABLE:uint =EST_DRIFTING + 1 ;
		public static const EST_EXPLODING:uint = EST_UNCONTROLLABLE + 1;
		public static const EST_REVIVING:uint = EST_EXPLODING + 1;
		public static const EST_DEFAULT:uint= EST_REVIVING +1;
		
		private var _speed:Number = 4;
		private var _saw:Boolean = false;
		private var _inside:Number=0;
		public function Car(posx:Number, posy:Number, image:DisplayObject){
			this.setCarImage(image);
			this.x=posx;
			this.y=posy;
			carImage.alignPivot();
			addChildAt(this.getCarImage(),0);
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
			_speed = value;
		}

		public function react(...args):void{
			throw new AbstractMethodError();	
		}
		public function getState():uint{
			return actualState;
		}
		public function setState(newState:uint):void{
			actualState=newState;
		}
		public function getCarImage():DisplayObject{
			return carImage;
		}
		public function setCarImage(newImage:DisplayObject):void{
			this.carImage=newImage;
		}
		
		public function getImage():String{
			return actualImage;
		}
		
		public function setImage(newImage:String):void{
			actualImage=newImage;
		}

		public function update():void{
			throw new AbstractMethodError();
		}
	}
}