package v9fs.views
{
	import flash.events.MouseEvent;
	
	import fl.controls.Button;
	
	import v9fs.views.components.V9Container;
	import v9fs.views.events.FooterViewEvent;

	public class Footer extends V9Container
	{
		//public var lblFileName:Label;
		
		public var btnRun:Button;
		
		public function Footer()
		{
			super({ borderTopColor: 0xe1e1e1 });
		}

		override public function setSize(width:Number, height:Number):void
		{
			super.setSize(width, height);
			
			var btnRunWidth:Number = btnRun.textField.textWidth + 20;
			btnRun.setSize(btnRunWidth, height - 1);
			btnRun.move(width - btnRunWidth, 1);
			
			//lblFileName.move(5, 4);
			//lblFileName.setSize(width - btnLoadSWFWidth - 5, height - 4);
		}
		
		override protected function init():void
		{
			super.init();
			
			//lblFileName = new Label();
			//lblFileName.setStyle("textFormat", new TextFormat("_sans", 12, 0x333333));
			//lblFileName.htmlText = "<font size='14'><b>V9</b></font> <font color='#888888'>FrameSampler.</font>";
			//addChild(lblFileName);
			
			btnRun = new Button();
			btnRun.addEventListener(MouseEvent.CLICK, btnRunClickHandler, false, 0, true);
			setButtonStyles(btnRun);
			btnRun.label = "Run";
			btnRun.drawNow();
			addChild(btnRun);
		}
		
		protected function btnRunClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FooterViewEvent(FooterViewEvent.RUN_BTN_CLICK));
		}
		
		protected function setButtonStyles(btn:Button):void
		{
			btn.setStyle("upSkin", Button_leftBorder_upSkin);
			btn.setStyle("overSkin", Button_leftBorder_overSkin);
			btn.setStyle("downSkin", Button_leftBorder_downSkin);
			btn.setStyle("disabledSkin", Button_leftBorder_disabledSkin);
			btn.setStyle("selectedUpSkin", Button_leftBorder_selectedUpSkin);
			btn.setStyle("selectedOverSkin", Button_leftBorder_selectedOverSkin);
			btn.setStyle("selectedDownSkin", Button_leftBorder_selectedDownSkin);
			btn.setStyle("selectedDisabledSkin", Button_leftBorder_selectedDisabledSkin);
		}
		
		/*
		protected function setToggleButtonStyles(btn:Button):void
		{
			setButtonStyles(btn);
			btn.labelPlacement = ButtonLabelPlacement.LEFT;
			btn.setStyle("upIcon", ToggleButton_icon);
			btn.setStyle("overIcon", ToggleButton_icon);
			btn.setStyle("downIcon", ToggleButton_icon);
			btn.setStyle("disabledIcon", ToggleButton_disabledIcon);
			btn.setStyle("selectedUpIcon", ToggleButton_selectedIcon);
			btn.setStyle("selectedOverIcon", ToggleButton_selectedIcon);
			btn.setStyle("selectedDownIcon", ToggleButton_selectedIcon);
			btn.setStyle("selectedDisabledIcon", ToggleButton_disabledIcon);
			btn.setStyle("upSkin", Button_leftBorder_upSkin);
			btn.setStyle("overSkin", Button_leftBorder_overSkin);
			btn.setStyle("downSkin", Button_leftBorder_downSkin);
			btn.setStyle("disabledSkin", Button_leftBorder_disabledSkin);
			btn.setStyle("selectedUpSkin", Button_leftBorder_upSkin);
			btn.setStyle("selectedOverSkin", Button_leftBorder_overSkin);
			btn.setStyle("selectedDownSkin", Button_leftBorder_downSkin);
			btn.setStyle("selectedDisabledSkin", Button_leftBorder_disabledSkin);
		}
		*/
	}
}
