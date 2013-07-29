package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.Label;
	import fl.managers.StyleManager;
	
	import v9fs.V9Context;
	import v9fs.views.Main;
	
	public class FrameSampler extends Sprite
	{
		public static var fontInconsolata:Inconsolata = new Inconsolata();
		
		private var view:Main;
		private var context:V9Context;
		
		public function FrameSampler()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var buttonDummy:Button = new Button();
			
			StyleManager.setComponentStyle(Button, "textFormat", new TextFormat("_sans", 12, 0x333333));
			StyleManager.setComponentStyle(Button, "disabledTextFormat", new TextFormat("_sans", 12, 0xaaaaaa));
			StyleManager.setComponentStyle(CheckBox, "textFormat", new TextFormat("_sans", 12, 0x333333));
			StyleManager.setComponentStyle(CheckBox, "disabledTextFormat", new TextFormat("_sans", 12, 0xaaaaaa));
			StyleManager.setComponentStyle(Label, "textFormat", new TextFormat("_sans", 12, 0x000000));
			
			context = new V9Context(this);
			
			view = new Main();
			addChild(view);
			
			if(stage) {
				stage.addEventListener(Event.RESIZE, resizeHandler);
				resize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, resizeHandler);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			resize();
		}
		
		protected function resizeHandler(event:Event):void
		{
			resize();
		}
		
		protected function resize():void
		{
			view.setSize(stage.stageWidth, stage.stageHeight);
		}
	}
}

/*
package
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.events.SWFProgressEvent;
	
	import flash.display.BitmapData;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import v9fg.FrameGrabberWindow;
	import v9fg.events.FrameEvent;
	
	public class FrameGrabber extends Sprite
	{
		private var screenshotQueue:Vector.<Screenshot>;
		private var screenshotQueueBusy:Boolean = false;
		
		public function FrameGrabber()
		{
			PNGEncoder2.level = CompressionLevel.FAST;
			screenshotQueue = new Vector.<Screenshot>();
			//sample("/Users/claus/Projects/Mozilla/shumway/examples/_tests/timeline_simple_counter.swf");
			sample("/Users/claus/Projects/Mozilla/shumway/examples/_tests/timeline_simple_counter_with_errors.swf");
			//sample("/Users/claus/Library/Preferences/SWFscraper/Local Store/archive/db405b41d86a517972c60639750999d5.swf");
		}
		
		private function sample(path:String):void
		{
			var ba:ByteArray = new ByteArray();
			var file:File = new File(path);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			fileStream.readBytes(ba);
			fileStream.close();
			
			var swf:SWF = new SWF();
			swf.addEventListener(SWFProgressEvent.PROGRESS, function(event:SWFProgressEvent):void {
				var swf:SWF = event.target as SWF;
				if (swf.tags.length > 0) {
					event.preventDefault();
					sampleStart(path, swf);
				}
			});
			swf.loadBytesAsync(ba);
		}
		
		private function sampleStart(path:String, swf:SWF):void
		{
			var opt:NativeWindowInitOptions = new NativeWindowInitOptions();
			opt.systemChrome = NativeWindowSystemChrome.NONE;
			var win:FrameGrabberWindow = new FrameGrabberWindow(path, opt);
			win.addEventListener(FrameEvent.CAPTURED, frameCapturedHandler);
			win.addEventListener(Event.CLOSE, windowCloseHandler);
			win.stage.align = StageAlign.TOP_LEFT;
			win.stage.scaleMode = StageScaleMode.NO_SCALE;
			win.stage.quality = StageQuality.HIGH;
			win.stage.frameRate = swf.frameRate;
			win.width = Math.round((swf.frameSize.xmax - swf.frameSize.xmin) / 20);
			win.height = Math.round((swf.frameSize.ymax - swf.frameSize.ymin) / 20);
			win.activate();
		}
		
		protected function windowCloseHandler(event:Event):void
		{
			trace("window closed");
			var win:FrameGrabberWindow = event.target as FrameGrabberWindow;
			win.removeEventListener(FrameEvent.CAPTURED, frameCapturedHandler);
			win.removeEventListener(Event.CLOSE, windowCloseHandler);
			stage.frameRate = 30;
		}
		
		protected function frameCapturedHandler(event:FrameEvent):void
		{
			screenshotQueue.push(new Screenshot(event.bmd, event.frame));
			if (!screenshotQueueBusy) {
				screenshotQueueBusy = true;
				saveAsPNG(event.path);
			}
		}
		
		protected function saveAsPNG(path:String):void
		{
			var screenshot:Screenshot = screenshotQueue.shift();
			var encoder:PNGEncoder2 = PNGEncoder2.encodeAsync(screenshot.bmd);
			encoder.targetFPS = 30;
			encoder.addEventListener(Event.COMPLETE, function(e:Event):void {
				var png:ByteArray = encoder.png;
				var swfFile:File = new File(path);
				var name:String = swfFile.name.substring(0, swfFile.name.indexOf(swfFile.extension) - 1);
				var pngFile:File = swfFile.parent.resolvePath(name + File.separator + name  + "_" + screenshot.frame + ".png");
				var fileStream:FileStream = new FileStream();
				fileStream.addEventListener(Event.CLOSE, function(e:Event):void {
					screenshot.bmd.dispose();
					screenshot.bmd = null;
					if (screenshotQueue.length > 0) {
						saveAsPNG(path);
					} else {
						screenshotQueueBusy = false;
					}
					trace(pngFile.nativePath, "saved");
				});
				fileStream.openAsync(pngFile, FileMode.WRITE);
				fileStream.writeBytes(png);
				fileStream.close();
			});
		}
	}
}

import flash.display.BitmapData;

class Screenshot
{
	public var bmd:BitmapData;
	public var frame:uint;
	
	public function Screenshot(bmd:BitmapData, frame:uint) {
		this.bmd = bmd;
		this.frame = frame;
	}
}
*/
