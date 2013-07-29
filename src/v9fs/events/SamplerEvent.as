package v9fs.events
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class SamplerEvent extends Event
	{
		public static const PROCESSED_SAMPLE:String = "SampleEvent_PROCESSED_SAMPLE";
		public static const PROCESSED_ALL_SAMPLES:String = "SampleEvent_PROCESSED_ALL_SAMPLES";
		public static const ADD_SAMPLE:String = "SampleEvent_ADD_SAMPLE";
		public static const START:String = "SampleEvent_START";
		public static const STOP:String = "SampleEvent_STOP";
		
		public var frame:Number;
		public var bitmapData:BitmapData;
		
		public function SamplerEvent(type:String, frame:Number = 0, bitmapData:BitmapData = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.frame = frame;
			this.bitmapData = bitmapData;
		}
	}
}