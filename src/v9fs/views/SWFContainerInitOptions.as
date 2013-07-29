package v9fs.views
{
	import flash.display.NativeWindowInitOptions;
	import flash.utils.ByteArray;
	
	public class SWFContainerInitOptions extends NativeWindowInitOptions
	{
		public var swfBytes:ByteArray;
		public var swfFrameRate:Number;
		public var swfWidth:Number;
		public var swfHeight:Number;
		public var sampleInterval:int;
		public var sampleIntervalStart:int;
		public var maxSamples:int;

		public function SWFContainerInitOptions()
		{
			super();
		}
	}
}