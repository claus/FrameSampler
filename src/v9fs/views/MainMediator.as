package v9fs.views
{
	import flash.display.NativeWindowType;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import v9fs.events.SWFEvent;
	import v9fs.events.SamplerEvent;
	import v9fs.proxies.SWFProxy;
	import v9fs.proxies.SettingsProxy;
	import v9fs.views.events.SWFContainerViewEvent;

	public class MainMediator extends Mediator
	{
		[Inject]
		public var view:Main;

		[Inject]
		public var swfProxy:SWFProxy;
		[Inject]
		public var settingsProxy:SettingsProxy;

		private var swfContainer:SWFContainer;
		
		public function MainMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addContextListener(SWFEvent.LOADED, swfLoadedHandler);
			addContextListener(SWFEvent.RUN, swfRunHandler);
		}
		
		override public function onRemove():void
		{
			removeContextListener(SWFEvent.LOADED, swfLoadedHandler);
			removeContextListener(SWFEvent.RUN, swfRunHandler);
		}
		
		protected function swfLoadedHandler(event:SWFEvent):void
		{
			view.settings.visible = true;
			view.footer.visible = true;
		}
		
		protected function swfRunHandler(event:SWFEvent):void
		{
			// TODO: disable header/settings, show stop button
			
			swfContainer = new SWFContainer(createInitOptions());
			swfContainer.addEventListener(SWFContainerViewEvent.SAMPLE, swfContainerSampleHandler);
			swfContainer.addEventListener(Event.CLOSE, swfContainerCloseHandler);
			swfContainer.activate();

			dispatch(new SamplerEvent(SamplerEvent.START));
		}
		
		protected function swfContainerSampleHandler(event:SWFContainerViewEvent):void
		{
			dispatch(new SamplerEvent(SamplerEvent.ADD_SAMPLE, event.frame, event.bitmapData));
		}
		
		protected function swfContainerCloseHandler(event:Event):void
		{
			swfContainer.removeEventListener(SWFContainerViewEvent.SAMPLE, swfContainerSampleHandler);
			swfContainer.removeEventListener(Event.CLOSE, swfContainerCloseHandler);

			dispatch(new SamplerEvent(SamplerEvent.STOP));
		}
		
		protected function createInitOptions():SWFContainerInitOptions
		{
			var initOptions:SWFContainerInitOptions = new SWFContainerInitOptions();
			initOptions.swfBytes = swfProxy.swfBytes;
			initOptions.swfFrameRate = swfProxy.swf.frameRate;
			initOptions.swfWidth = swfProxy.width;
			initOptions.swfHeight = swfProxy.height;
			initOptions.sampleInterval = (settingsProxy.interval < 0) ? swfProxy.swf.frameRate : settingsProxy.interval;
			initOptions.sampleIntervalStart = settingsProxy.intervalStart;
			initOptions.maxSamples = settingsProxy.maxSamples;
			//initOptions.owner = view.stage.nativeWindow;
			initOptions.maximizable = false;
			initOptions.resizable = false;
			initOptions.type = NativeWindowType.UTILITY;
			return initOptions;
		}
	}
}
