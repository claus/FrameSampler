package v9fs.commands
{
	import org.robotlegs.mvcs.Command;
	
	import v9fs.events.SamplerEvent;
	import v9fs.proxies.SamplerProxy;
	
	public class SamplerAddSampleCommand extends Command
	{
		[Inject]
		public var event:SamplerEvent;
		
		[Inject]
		public var proxy:SamplerProxy;
		
		public override function execute():void
		{
			proxy.addSample(event.frame, event.bitmapData);
		}
	}
}
