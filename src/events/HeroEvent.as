package events
{
	import starling.events.Event;
	
	public class HeroEvent extends Event
	{
		public static const DRIFTING:String = "DRIFTING";
		public static const EXPLODING:String = "EXPLODING";
		
		public function HeroEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}