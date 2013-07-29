package v9fs.views
{
	import v9fs.views.components.V9Container;
	
	public class Main extends V9Container
	{
		public var header:Header;
		public var settings:SettingsView;
		public var footer:Footer;
		
		public function Main()
		{
			super();
		}

		override public function setSize(width:Number, height:Number):void
		{
			header.move(0, 0);
			header.setSize(width, 28);
			
			settings.move(0, 28);
			settings.setSize(width, height - 28);
			
			footer.move(0, height - 29);
			footer.setSize(width, 29);
		}
		
		override protected function init():void
		{
			header = new Header();
			addChild(header);
			
			settings = new SettingsView();
			settings.visible = false;
			addChild(settings);
			
			footer = new Footer();
			footer.visible = false;
			addChild(footer);
		}
	}
}
