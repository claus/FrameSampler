package v9fs.views
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.NativeWindow;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.geom.Matrix;
	import flash.system.LoaderContext;
	
	import v9fs.views.events.SWFContainerViewEvent;
	
	public class SWFContainer extends NativeWindow
	{
		private var initialized:Boolean = false;
		private var scale:Number;
		private var scaleMatrix:Matrix;
		private var frame:Number = 0;
		private var sampledFrames:int = 0;
		private var loader:Loader;
		
		private var initOptions:SWFContainerInitOptions;
		
		public function SWFContainer(initOptions:SWFContainerInitOptions)
		{
			super(initOptions);
			this.initOptions = initOptions;
			initialize();
		}
		
		public function initialize():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.HIGH;
			stage.frameRate = initOptions.swfFrameRate;

			width = initOptions.swfWidth;
			height = initOptions.swfHeight;
			// stupid hack to make the stage as big as the swf (add chrome size to width/height)
			width = initOptions.swfWidth * 2 - stage.stageWidth;
			height = initOptions.swfHeight * 2 - stage.stageHeight;

			addEventListener(Event.CLOSING, closingHandler);
			addEventListener(Event.ACTIVATE, activateHandler);
		}
		
		protected function closingHandler(event:Event):void
		{
			loader.content.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		protected function activateHandler(event:Event):void
		{
			if (initialized) {
				return;
			}

			initialized = true;
			scale = stage.contentsScaleFactor;
			scaleMatrix = new Matrix(scale, 0, 0, scale, 0, 0);
			trace("contentsScaleFactor:", scale);

			var context:LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, loaderInitHandler);
			loader.loadBytes(initOptions.swfBytes, context);
			stage.addChild(loader);
		}
		
		protected function loaderInitHandler(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.INIT, loaderInitHandler);
			loaderInfo.loader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, globalErrorHandler);
			loaderInfo.content.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			newFrame(loaderInfo.content);
		}
		
		protected function globalErrorHandler(event:UncaughtErrorEvent):void
		{
			event.preventDefault();
			trace(event);
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			newFrame(event.target as DisplayObject);
		}
		
		protected function newFrame(content:DisplayObject):void
		{
			if (++frame >= initOptions.sampleIntervalStart) {
				if (((frame - initOptions.sampleIntervalStart) % initOptions.sampleInterval) == 0) {
					draw(content);
					if (++sampledFrames >= initOptions.maxSamples) {
						loader.content.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						close();
					}
				}
			}
		}
		
		private function draw(display:DisplayObject):void {
			try {
				var bmd:BitmapData = new BitmapData(stage.stageWidth * scale, stage.stageHeight * scale, false);
				bmd.drawWithQuality(display, scaleMatrix, null, null, null, false, StageQuality.HIGH);
				dispatchEvent(new SWFContainerViewEvent(SWFContainerViewEvent.SAMPLE, frame, bmd));
			}
			catch(e:Error) {
			}
		}
	}
}
