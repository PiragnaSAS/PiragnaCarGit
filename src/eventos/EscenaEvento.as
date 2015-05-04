package eventos
{
	import starling.events.Event;
	
	public class EscenaEvento extends Event
	{
		public static const CAMBIO_DE_ESCENA:String = "cambio de escena";
		
		public var nombreClassDeEscenaObjetibo:String;
		public var params:Object;
		
		
		public function EscenaEvento(type:String, nombreClassDeEscenaObjetibo:String = null, params:Object = null, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
			
			this.params = params;
			if (nombreClassDeEscenaObjetibo) this.nombreClassDeEscenaObjetibo = nombreClassDeEscenaObjetibo;
		}
	}
}