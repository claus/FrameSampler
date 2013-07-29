package v9fs.views.events
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class SWFContainerViewEvent extends Event
	{
		public static const SAMPLE:String = "SWFContainerViewEvent_SAMPLE";
		
		public var frame:Number;
		public var bitmapData:BitmapData;
		
		public function SWFContainerViewEvent(type:String, frame:Number, bitmapData:BitmapData, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.frame = frame;
			this.bitmapData = bitmapData;
		}
	}
}