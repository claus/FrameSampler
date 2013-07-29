package v9fs.proxies
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import org.robotlegs.mvcs.Actor;
	
	import v9fs.events.SamplerEvent;
	import v9fs.proxies.models.SampleData;
	
	public class SamplerProxy extends Actor
	{
		private var queue:Vector.<SampleData>;
		private var queueBusy:Boolean = false;
		private var currentSample:SampleData;
		private var json:Object;
		
		private var _active:Boolean = false;
		
		[Inject]
		public var swfProxy:SWFProxy;
		[Inject]
		public var settingsProxy:SettingsProxy;
		
		public function SamplerProxy()
		{
			super();
		}
		
		public function get active():Boolean {
			return _active;
		}

		public function startSession():void
		{
			queue = new Vector.<SampleData>();
			json = {
				swf: {
					path: swfProxy.path,
					width: swfProxy.width,
					height: swfProxy.height
				},
				frames: [
				]
			};
			_active = true;
		}

		public function addSample(frame:Number, bitmapData:BitmapData):void
		{
			queue.push(new SampleData(frame, bitmapData));
			if (!queueBusy) {
				queueBusy = true;
				processSample();
			}
		}
		
		public function stopSession():void
		{
			_active = false;
			if (!queueBusy) {
				finalize();
			}
		}

		protected function processSample():void
		{
			currentSample = queue.shift();
			
			extractColors();
			
			if (settingsProxy.savePNG) {
				savePNG(function():void {
					dispatch(new SamplerEvent(SamplerEvent.PROCESSED_SAMPLE));
					if (queue.length > 0) {
						processSample();
					} else {
						queueBusy = false;
						finalize();
					}
				});
			} else {
				dispatch(new SamplerEvent(SamplerEvent.PROCESSED_SAMPLE));
				queueBusy = false;
				finalize();
			}
		}
		
		protected function extractColors():void
		{
			var t:int = getTimer();
			var samples:Array = [];
			var bmd:BitmapData = currentSample.bitmapData;
			var scale:int = Math.round(bmd.width / swfProxy.width);
			var xStart:int = settingsProxy.gridStartH * scale;
			var xGrid:int = settingsProxy.gridSizeH * scale;
			var yStart:int = settingsProxy.gridStartV * scale;
			var yGrid:int = settingsProxy.gridSizeV * scale;
			var xMax:int = bmd.width;
			var yMax:int = bmd.height;
			bmd.lock();
			for (var y:int = yStart; y < yMax; y += yGrid) {
				for (var x:int = xStart; x < xMax; x += xGrid) {
					samples.push({
						x: x,
						y: y,
						c: bmd.getPixel(x, y)
					});
				}
			}
			bmd.unlock();
			json.frames.push({
				nr: currentSample.frame,
				samples: samples
			});
		}
		
		protected function savePNG(onComplete:Function):void
		{
			var encoder:PNGEncoder2 = PNGEncoder2.encodeAsync(currentSample.bitmapData);
			encoder.targetFPS = 60;
			encoder.addEventListener(Event.COMPLETE, function(e:Event):void {
				var png:ByteArray = encoder.png;
				var swfFile:File = new File(swfProxy.path);
				var pngFile:File = swfFile.parent.resolvePath(swfProxy.name + File.separator + swfProxy.name  + "_" + currentSample.frame + ".png");
				var fileStream:FileStream = new FileStream();
				fileStream.addEventListener(Event.CLOSE, function(e:Event):void {
					currentSample.bitmapData.dispose();
					currentSample.bitmapData = null;
					onComplete();
				});
				fileStream.openAsync(pngFile, FileMode.WRITE);
				fileStream.writeBytes(png);
				fileStream.close();
			});
		}
		
		protected function finalize():void
		{
			if (!active) {
				var swfFile:File = new File(swfProxy.path);
				var jsonFile:File = swfFile.parent.resolvePath(swfProxy.name + File.separator + swfProxy.name  + ".json");
				var fileStream:FileStream = new FileStream();
				fileStream.open(jsonFile, FileMode.WRITE);
				fileStream.writeUTFBytes(JSON.stringify(json, null, 2));
				fileStream.close();
				dispatch(new SamplerEvent(SamplerEvent.PROCESSED_ALL_SAMPLES));
			}
		}
	}
}
