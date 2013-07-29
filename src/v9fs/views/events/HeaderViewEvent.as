package v9fs.views.events
{
	import flash.events.Event;
	
	public class HeaderViewEvent extends Event
	{
		public static const LOAD_BTN_CLICK:String = "HeaderViewEvent_LOAD_BTN_CLICK";
		
		public function HeaderViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}