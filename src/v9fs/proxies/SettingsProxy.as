package v9fs.proxies
{
	import org.robotlegs.mvcs.Actor;
	
	public class SettingsProxy extends Actor
	{
		public var interval:int = -1;
		public var intervalStart:int = 1;
		public var gridSizeH:int = 20;
		public var gridStartH:int = 10;
		public var gridSizeV:int = 20;
		public var gridStartV:int = 10;
		public var maxSamples:int = 100;
		public var savePNG:Boolean = true;
		public var logTraces:Boolean = false;
		
		public function SettingsProxy()
		{
			super();
		}
	}
}