package v9fs.views
{
	import org.robotlegs.mvcs.Mediator;
	
	import v9fs.events.SWFEvent;
	import v9fs.proxies.SWFProxy;
	import v9fs.proxies.SettingsProxy;
	import v9fs.views.events.SettingsViewEvent;
	
	public class SettingsViewMediator extends Mediator
	{
		[Inject]
		public var view:SettingsView;
		
		[Inject]
		public var settingsProxy:SettingsProxy;
		
		[Inject]
		public var swfProxy:SWFProxy;
		
		public function SettingsViewMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addContextListener(SWFEvent.LOADED, swfLoadedHandler);
			addViewListener(SettingsViewEvent.CHANGE, settingsChangeHandler);
		}
		
		override public function onRemove():void
		{
			removeContextListener(SWFEvent.LOADED, swfLoadedHandler);
			removeViewListener(SettingsViewEvent.CHANGE, settingsChangeHandler);
		}
		
		private function swfLoadedHandler(event:SWFEvent):void
		{
			view.fileName = swfProxy.fileName;
			view.swfWidth = swfProxy.width;
			view.swfHeight = swfProxy.height;
			view.swfVM = swfProxy.vm;
			view.frameRate = swfProxy.swf.frameRate;
			
			view.interval = settingsProxy.interval;
			view.intervalStart = settingsProxy.intervalStart;
			view.gridSizeH = settingsProxy.gridSizeH;
			view.gridStartH = settingsProxy.gridStartH;
			view.gridSizeV = settingsProxy.gridSizeV;
			view.gridStartV = settingsProxy.gridStartV;
			view.maxSamples = settingsProxy.maxSamples;
			view.savePNG = settingsProxy.savePNG;
			view.logTraces = settingsProxy.logTraces;
		}
		
		private function settingsChangeHandler(event:SettingsViewEvent):void
		{
			switch(event.valueType) {
				case SettingsViewEvent.VT_INTERVAL: settingsProxy.interval = view.interval; break;
				case SettingsViewEvent.VT_INTERVAL_START: settingsProxy.intervalStart = view.intervalStart; break;
				case SettingsViewEvent.VT_GRID_SIZE_H: settingsProxy.gridSizeH = view.gridSizeH; break;
				case SettingsViewEvent.VT_GRID_START_H: settingsProxy.gridStartH = view.gridStartH; break;
				case SettingsViewEvent.VT_GRID_SIZE_V: settingsProxy.gridSizeV = view.gridSizeV; break;
				case SettingsViewEvent.VT_GRID_START_V: settingsProxy.gridStartV = view.gridStartV; break;
				case SettingsViewEvent.VT_MAX_SAMPLES: settingsProxy.maxSamples = view.maxSamples; break;
				case SettingsViewEvent.VT_SAVE_PNG: settingsProxy.savePNG = view.savePNG; break;
				case SettingsViewEvent.VT_LOG_TRACES: settingsProxy.logTraces = view.logTraces; break;
			}
		}
	}
}
