package v9fs.commands
{
	import org.robotlegs.mvcs.Command;
	
	import v9fs.events.SWFEvent;
	import v9fs.proxies.SWFProxy;
	
	public class SWFLoadCommand extends Command
	{
		[Inject]
		public var event:SWFEvent;
		
		[Inject]
		public var proxy:SWFProxy;
		
		public override function execute():void
		{
			proxy.loadSWF();
		}
	}
}