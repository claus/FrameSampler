package v9fs.proxies
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.events.SWFProgressEvent;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Actor;
	
	import v9fs.events.SWFEvent;
	
	public class SWFProxy extends Actor
	{
		public var swf:SWF;
		public var swfBytes:ByteArray;
		
		protected var swfPath:String;
		protected var swfName:String;
		protected var swfExtension:String;
		protected var swfVM:uint;
		
		public function SWFProxy()
		{
			super();
		}
		
		public function get path():String {
			return swfPath;
		}
		public function get name():String {
			return swfName;
		}
		public function get extension():String {
			return swfExtension;
		}
		public function get fileName():String {
			if (swfExtension && swfExtension.length > 0) {
				return swfName + "." + swfExtension;
			} else {
				return swfName;
			}
		}
		public function get vm():uint {
			return swfVM;
		}
		public function get width():Number {
			return swf.frameSize.rect.width;
		}
		public function get height():Number {
			return swf.frameSize.rect.height;
		}

		public function loadSWF():void
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, function(event:Event):void {

				swf = new SWF();
				swfBytes = new ByteArray();

				var selectedFile:File = event.target as File;
				var fileStream:FileStream = new FileStream();
				fileStream.open(selectedFile, FileMode.READ);
				fileStream.readBytes(swfBytes);
				fileStream.close();

				swfPath = selectedFile.nativePath;
				swfName = selectedFile.name.substring(0, selectedFile.name.indexOf(selectedFile.extension) - 1);
				swfExtension = selectedFile.extension;
				
				swf.addEventListener(SWFProgressEvent.PROGRESS, function(event:SWFProgressEvent):void {
					var swf:SWF = event.target as SWF;
					if (swf.tags.length > 0) {
						event.preventDefault();
						if (swf.tags[0] is TagFileAttributes) {
							swfVM = TagFileAttributes(swf.tags[0]).actionscript3 ? 3 : 1;
						} else {
							swfVM = 1;
						}
						//sampleStart(path, swf);
						//trace("SWF loaded", swfPath, swf.frameRate, swfVM);
						dispatch(new SWFEvent(SWFEvent.LOADED));
					}
				}, false, 0, true);
				swf.loadBytesAsync(swfBytes);

			}, false, 0, true);
			file.browseForOpen("Load SWF", [ new FileFilter("SWF (*.swf)", "*.swf") ]);
		}
	}
}
