package v9fs
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import v9fs.commands.SWFLoadCommand;
	import v9fs.commands.SamplerAddSampleCommand;
	import v9fs.commands.SamplerStartCommand;
	import v9fs.commands.SamplerStopCommand;
	import v9fs.events.SWFEvent;
	import v9fs.events.SamplerEvent;
	import v9fs.proxies.SWFProxy;
	import v9fs.proxies.SamplerProxy;
	import v9fs.proxies.SettingsProxy;
	import v9fs.views.Footer;
	import v9fs.views.FooterMediator;
	import v9fs.views.Header;
	import v9fs.views.HeaderMediator;
	import v9fs.views.Main;
	import v9fs.views.MainMediator;
	import v9fs.views.SettingsView;
	import v9fs.views.SettingsViewMediator;
	
	public class V9Context extends Context
	{
		public function V9Context(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			commandMap.mapEvent(SWFEvent.LOAD, SWFLoadCommand, SWFEvent);
			commandMap.mapEvent(SamplerEvent.START, SamplerStartCommand, SamplerEvent);
			commandMap.mapEvent(SamplerEvent.ADD_SAMPLE, SamplerAddSampleCommand, SamplerEvent);
			commandMap.mapEvent(SamplerEvent.STOP, SamplerStopCommand, SamplerEvent);
			
			injector.mapSingleton(SWFProxy);
			injector.mapSingleton(SettingsProxy);
			injector.mapSingleton(SamplerProxy);
			
			mediatorMap.mapView(Main, MainMediator);
			mediatorMap.mapView(Header, HeaderMediator);
			mediatorMap.mapView(Footer, FooterMediator);
			mediatorMap.mapView(SettingsView, SettingsViewMediator);
			
			// Startup complete
			super.startup();
		}
	}
}
