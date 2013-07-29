package v9fs.views
{
	import org.robotlegs.mvcs.Mediator;
	
	import v9fs.events.SWFEvent;
	import v9fs.views.events.FooterViewEvent;

	public class FooterMediator extends Mediator
	{
		[Inject]
		public var view:Footer;
		
		public function FooterMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addViewListener(FooterViewEvent.RUN_BTN_CLICK, runBtnClickHandler, FooterViewEvent);
		}
		
		override public function onRemove():void
		{
			removeViewListener(FooterViewEvent.RUN_BTN_CLICK, runBtnClickHandler, FooterViewEvent);
		}
		
		protected function runBtnClickHandler(event:FooterViewEvent):void
		{
			dispatch(new SWFEvent(SWFEvent.RUN));
		}
	}
}
