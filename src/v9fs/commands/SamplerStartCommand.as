package v9fs.commands
{
	import org.robotlegs.mvcs.Command;
	
	import v9fs.proxies.SamplerProxy;
	
	public class SamplerStartCommand extends Command
	{
		[Inject]
		public var proxy:SamplerProxy;
		
		public override function execute():void
		{
			proxy.startSession();
		}
	}
}
