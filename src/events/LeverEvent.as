package events
{
	import starling.events.Event;
	
	public class LeverEvent extends Event
	{
		public static const ACCELERATE:String = "ACCELERATE";
		public static const ROTATE:String = "ROTATE";
		
		public function LeverEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}