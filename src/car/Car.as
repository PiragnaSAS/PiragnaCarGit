package car
{
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;

	public class Car extends Sprite
	{
		public static const EST_MOVING:uint = 0;
		public static const EST_SKIDDING:uint = EST_MOVING + 1 ;
		public static const EST_UNCONTROLLABLE:uint =EST_SKIDDING + 1 ;
		public static const EST_EXPLODING:uint = EST_UNCONTROLLABLE + 1;
		public static const EST_REVIVING:uint = EST_EXPLODING + 1;
		
		public function Car(...arg)
		{
		}
		
		public function react(...args):void{
			throw new AbstractMethodError();	
		}
		
	}
}