package car
{
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;

	public class Carro extends Sprite
	{
		public static const EST_ANDANDO:uint = 0;
		public static const EST_DERRAMANDO:uint = EST_ANDANDO + 1 ;
		public static const EST_INCONTROLABLE:uint =EST_DERRAMANDO + 1 ;
		public static const EST_EXPLOTANDO:uint = EST_INCONTROLABLE + 1;
		public static const EST_REVIVIENDO:uint = EST_EXPLOTANDO + 1;
		
		public function Carro()
		{
		}
		
		public function reaccionar(...arg):void{
			throw new AbstractMethodError();	
		}
		
	}
}