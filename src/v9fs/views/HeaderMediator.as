package v9fs.views
{
	import org.robotlegs.mvcs.Mediator;
	
	import v9fs.events.SWFEvent;
	import v9fs.views.events.HeaderViewEvent;

	public class HeaderMediator extends Mediator
	{
		[Inject]
		public var view:Header;
		
		public function HeaderMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addViewListener(HeaderViewEvent.LOAD_BTN_CLICK, loadBtnClickHandler, HeaderViewEvent);
		}
		
		override public function onRemove():void
		{
			removeViewListener(HeaderViewEvent.LOAD_BTN_CLICK, loadBtnClickHandler, HeaderViewEvent);
		}
		
		protected function loadBtnClickHandler(event:HeaderViewEvent):void
		{
			dispatch(new SWFEvent(SWFEvent.LOAD));
		}
	}
}
