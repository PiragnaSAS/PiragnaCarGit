package events
{
	import starling.events.Event;
	
	public class EventScene extends Event
	{
		public static const SCENE_CHANGE:String = "scene change";
		
		public var targetSceneClassName:String;
		public var params:Object;
		
		
		public function EventScene(type:String, targetSceneClassName:String = null, params:Object = null, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
			
			this.params = params;
			if (targetSceneClassName) this.targetSceneClassName = targetSceneClassName;
		}
	}
}