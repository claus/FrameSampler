package v9fs.views
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import fl.controls.CheckBox;
	import fl.controls.Label;
	
	import v9fs.views.components.V9Container;
	import v9fs.views.components.V9LabelInput;
	import v9fs.views.events.SettingsViewEvent;
	
	public class SettingsView extends V9Container
	{
		public var lblFileName:Label;
		public var lblInfo:Label;
		
		protected var liFileName:V9LabelInput;
		protected var liWidth:V9LabelInput;
		protected var liHeight:V9LabelInput;
		protected var liVM:V9LabelInput;
		protected var liFrameRate:V9LabelInput;
		protected var liInterval:V9LabelInput;
		protected var liIntervalStart:V9LabelInput;
		protected var liGridSizeH:V9LabelInput;
		protected var liGridStartH:V9LabelInput;
		protected var liGridSizeV:V9LabelInput;
		protected var liGridStartV:V9LabelInput;
		protected var liMaxSamples:V9LabelInput;
		protected var chkSavePNG:CheckBox;
		protected var chkLogTraces:CheckBox;
		
		public function SettingsView()
		{
			super({ borderTopColor: 0xe1e1e1 });
		}

		public function set fileName(value:String):void {
			liFileName.input.text = value;
		}
		public function set swfWidth(value:Number):void {
			liWidth.input.text = value + " px";
		}
		public function set swfHeight(value:Number):void {
			liHeight.input.text = value + " px";
		}
		public function set swfVM(value:uint):void {
			liVM.input.text = "AVM " + value;
		}
		public function set frameRate(value:Number):void {
			liFrameRate.input.text = value.toString();
			liInterval.input.text = value.toString();
		}

		public function get interval():int { return parseInt(liInterval.input.text); }
		public function set interval(value:int):void { liInterval.input.text = (value < 0) ? liFrameRate.input.text : value.toString(); }

		public function get intervalStart():int { return parseInt(liIntervalStart.input.text); }
		public function set intervalStart(value:int):void { liIntervalStart.input.text = value.toString(); }

		public function get gridSizeH():int { return parseInt(liGridSizeH.input.text); }
		public function set gridSizeH(value:int):void { liGridSizeH.input.text = value.toString(); }
		public function get gridStartH():int { return parseInt(liGridStartH.input.text); }
		public function set gridStartH(value:int):void { liGridStartH.input.text = value.toString(); }
		
		public function get gridSizeV():int { return parseInt(liGridSizeV.input.text); }
		public function set gridSizeV(value:int):void { liGridSizeV.input.text = value.toString(); }
		public function get gridStartV():int { return parseInt(liGridStartV.input.text); }
		public function set gridStartV(value:int):void { liGridStartV.input.text = value.toString(); }

		public function get maxSamples():int { return parseInt(liMaxSamples.input.text); }
		public function set maxSamples(value:int):void { liMaxSamples.input.text = value.toString(); }

		public function get savePNG():Boolean { return chkSavePNG.selected; }
		public function set savePNG(value:Boolean):void { chkSavePNG.selected = value; }

		public function get logTraces():Boolean { return chkLogTraces.selected; }
		public function set logTraces(value:Boolean):void { chkLogTraces.selected = value; }

		override public function setSize(width:Number, height:Number):void
		{
			super.setSize(width, height);

			liFileName.move(0, 1);
			liFileName.setSize(width, 28);

			liWidth.move(0, 29);
			liWidth.setSize(width, 28);

			liHeight.move(0, 57);
			liHeight.setSize(width, 28);

			liVM.move(0, 85);
			liVM.setSize(width, 28);

			liFrameRate.move(0, 113);
			liFrameRate.setSize(width, 28);
			
			liInterval.move(0, 141);
			liInterval.setSize(width - 100, 28);
			liIntervalStart.move(width - 100, 141);
			liIntervalStart.setSize(100, 28);
			
			liGridSizeH.move(0, 169);
			liGridSizeH.setSize(width - 100, 28);
			liGridStartH.move(width - 100, 169);
			liGridStartH.setSize(100, 28);
			
			liGridSizeV.move(0, 197);
			liGridSizeV.setSize(width, 28);
			liGridStartV.move(width - 100, 197);
			liGridStartV.setSize(100, 28);
			
			liMaxSamples.move(0, 225);
			liMaxSamples.setSize(width, 28);

			chkSavePNG.move(0, 253);
			chkSavePNG.setSize(150, 28);
			
			chkLogTraces.move(150, 253);
			chkLogTraces.setSize(width - 150, 28);
		}
		
		override protected function init():void
		{
			var stylesMain:Object = { borderBottomColor: 0xe1e1e1, backgroundColor: 0xe6f6ff };
			var stylesDisabled:Object = { borderBottomColor: 0xe1e1e1, backgroundColor: 0xf8f8f8 };
			var stylesSecondary:Object = { borderBottomColor: 0xe1e1e1, borderLeftColor: 0xe1e1e1, backgroundColor: 0xe6f6ff };
			
			liFileName = new V9LabelInput("Name", 90, true, stylesDisabled);
			addChild(liFileName);
			
			liWidth = new V9LabelInput("Width", 90, true, stylesDisabled);
			addChild(liWidth);
			
			liHeight = new V9LabelInput("Height", 90, true, stylesDisabled);
			addChild(liHeight);
			
			liVM = new V9LabelInput("VM", 90, true, stylesDisabled);
			addChild(liVM);
			
			liFrameRate = new V9LabelInput("Frame Rate", 90, true, stylesDisabled);
			addChild(liFrameRate);
			
			liInterval = new V9LabelInput("Interval", 90, false, stylesMain);
			liInterval.addEventListener(Event.CHANGE, intervalChangeHandler);
			liInterval.input.restrict = "0123456789";
			addChild(liInterval);
			liIntervalStart = new V9LabelInput("Start", 45, false, stylesSecondary);
			liIntervalStart.addEventListener(Event.CHANGE, intervalStartChangeHandler);
			liIntervalStart.input.restrict = "0123456789";
			addChild(liIntervalStart);
			
			liGridSizeH = new V9LabelInput("Grid Horiz.", 90, false, stylesMain);
			liGridSizeH.addEventListener(Event.CHANGE, gridSizeHChangeHandler);
			liGridSizeH.input.restrict = "0123456789";
			addChild(liGridSizeH);
			liGridStartH = new V9LabelInput("Start", 45, false, stylesSecondary);
			liGridStartH.addEventListener(Event.CHANGE, gridStartHChangeHandler);
			liGridStartH.input.restrict = "0123456789";
			addChild(liGridStartH);
			
			liGridSizeV = new V9LabelInput("Grid Vert.", 90, false, stylesMain);
			liGridSizeV.addEventListener(Event.CHANGE, gridSizeVChangeHandler);
			liGridSizeV.input.restrict = "0123456789";
			addChild(liGridSizeV);
			liGridStartV = new V9LabelInput("Start", 45, false, stylesSecondary);
			liGridStartV.addEventListener(Event.CHANGE, gridStartVChangeHandler);
			liGridStartV.input.restrict = "0123456789";
			addChild(liGridStartV);
			
			liMaxSamples = new V9LabelInput("Max Samples", 90, false, stylesMain);
			liMaxSamples.addEventListener(Event.CHANGE, maxSamplesChangeHandler);
			liMaxSamples.input.restrict = "0123456789";
			addChild(liMaxSamples);

			chkSavePNG = new CheckBox();
			chkSavePNG.addEventListener(Event.CHANGE, savePNGChangeHandler, false, 0, true);
			setCheckboxStyles(chkSavePNG);
			chkSavePNG.label = "Take Screenshots";
			chkSavePNG.drawNow();
			addChild(chkSavePNG);
			
			chkLogTraces = new CheckBox();
			chkLogTraces.addEventListener(Event.CHANGE, logTracesChangeHandler, false, 0, true);
			setCheckboxStyles(chkLogTraces);
			chkLogTraces.label = "Log Traces";
			chkLogTraces.drawNow();
			addChild(chkLogTraces);
		}
		
		protected function intervalChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_INTERVAL));
		}
		protected function intervalStartChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_INTERVAL_START));
		}
		protected function gridSizeHChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_GRID_SIZE_H));
		}
		protected function gridStartHChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_GRID_START_H));
		}
		protected function gridSizeVChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_GRID_SIZE_V));
		}
		protected function gridStartVChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_GRID_START_V));
		}
		protected function maxSamplesChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_MAX_SAMPLES));
		}
		protected function savePNGChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_SAVE_PNG));
		}
		protected function logTracesChangeHandler(event:Event):void {
			dispatchEvent(new SettingsViewEvent(SettingsViewEvent.CHANGE, SettingsViewEvent.VT_LOG_TRACES));
		}

		protected function setCheckboxStyles(btn:CheckBox):void
		{
			btn.setStyle("upIcon", ToggleButton_icon);
			btn.setStyle("overIcon", ToggleButton_icon);
			btn.setStyle("downIcon", ToggleButton_icon);
			btn.setStyle("disabledIcon", ToggleButton_disabledIcon);
			btn.setStyle("selectedUpIcon", ToggleButton_grayIcon);
			btn.setStyle("selectedOverIcon", ToggleButton_grayIcon);
			btn.setStyle("selectedDownIcon", ToggleButton_grayIcon);
			btn.setStyle("selectedDisabledIcon", ToggleButton_grayIcon);
			btn.setStyle("upSkin", Button_leftBorder_upSkin);
			btn.setStyle("overSkin", Button_leftBorder_overSkin);
			btn.setStyle("downSkin", Button_leftBorder_downSkin);
			btn.setStyle("disabledSkin", Button_leftBorder_disabledSkin);
			btn.setStyle("selectedUpSkin", Button_leftBorder_upSkin);
			btn.setStyle("selectedOverSkin", Button_leftBorder_overSkin);
			btn.setStyle("selectedDownSkin", Button_leftBorder_downSkin);
			btn.setStyle("selectedDisabledSkin", Button_leftBorder_disabledSkin);
			btn.setStyle("textFormat", new TextFormat("_sans", 12, 0x777777));
			btn.setStyle("disabledTextFormat", new TextFormat("_sans", 12, 0xaaaaaa));
		}
	}
}