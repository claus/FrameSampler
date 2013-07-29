package v9fs.events
{
	import flash.events.Event;
	
	public class SWFEvent extends Event
	{
		public static const LOAD:String = "SWFEvent_LOAD";
		public static const RUN:String = "SWFEvent_RUN";
		
		public static const LOADED:String = "SWFEvent_LOADED";
		
		public function SWFEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}