package car
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;

	public class Car extends Sprite
	{
		private var actualImage:String;
		private var actualState:uint;
		private var position:Point;
		public static const EST_MOVING:uint = 0;
		public static const EST_DRIFTING:uint = EST_MOVING + 1 ;
		public static const EST_UNCONTROLLABLE:uint =EST_DRIFTING + 1 ;
		public static const EST_EXPLODING:uint = EST_UNCONTROLLABLE + 1;
		public static const EST_REVIVING:uint = EST_EXPLODING + 1;
		public static const EST_DEFAULT:uint= EST_REVIVING +1;
		
		
		public function Car(...arg)
		{
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
		public function getImage():String{
			return actualImage;
		}
		public function setImage(newImage:String):void{
			actualImage=newImage;
		}
	}
}