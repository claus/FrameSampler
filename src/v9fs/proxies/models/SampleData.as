package v9fs.proxies.models
{
	import flash.display.BitmapData;

	public class SampleData
	{
		public var frame:Number;
		public var bitmapData:BitmapData;
		
		public function SampleData(frame:Number, bitmapData:BitmapData)
		{
			this.frame = frame;
			this.bitmapData = bitmapData;
		}
	}
}