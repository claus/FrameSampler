package v9fs.events
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class FrameEvent extends Event
	{
		public static const CAPTURED:String = "FrameEvent_CAPTURED";
		
		public var frame:uint;
		public var bmd:BitmapData;
		public var path:String;
		
		public function FrameEvent(type:String, frame:uint, bmd:BitmapData, path:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.frame = frame;
			this.bmd = bmd;
			this.path = path;
		}
	}
}