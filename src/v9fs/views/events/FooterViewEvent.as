package v9fs.views.events
{
	import flash.events.Event;
	
	public class FooterViewEvent extends Event
	{
		public static const RUN_BTN_CLICK:String = "FooterViewEvent_RUN_BTN_CLICK";
		
		public function FooterViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}