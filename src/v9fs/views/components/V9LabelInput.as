package v9fs.views.components
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import fl.controls.Label;
	import fl.controls.TextInput;

	public class V9LabelInput extends V9Container
	{
		public var label:Label;
		public var input:TextInput;
		
		protected var labelWidth:Number;
		protected var readOnly:Boolean;
		
		public function V9LabelInput(labelText:String, labelWidth:Number, readOnly:Boolean = false, options:Object = null)
		{
			this.labelWidth = labelWidth;
			this.readOnly = readOnly;

			super(options);
			
			this.label.text = labelText;
		}
		
		override public function setSize(width:Number, height:Number):void
		{
			super.setSize(width, height);

			graphics.beginFill(0xe1e1e1, 1);
			graphics.drawRect(labelWidth, 0, 1, height);
			graphics.endFill();

			label.move(6, 3);
			label.setSize(labelWidth - 10, height - 1);
			
			input.move(labelWidth + 1, 0);
			input.setSize(width - labelWidth - 1, height - 1);
		}
		
		override protected function init():void
		{
			label = new Label();
			label.setStyle("textFormat", new TextFormat("_sans", 12, 0x777777));
			label.htmlText = "";
			addChild(label);
			
			input = new TextInput();
			input.addEventListener(Event.CHANGE, changeHandler);
			input.setStyle("textFormat", new TextFormat("_sans", 12, 0x333333));
			input.setStyle("disabledTextFormat", new TextFormat("_sans", 12, 0x777777));
			input.setStyle("textPadding", 3);
			input.enabled = !readOnly;
			addChild(input);
		}
		
		protected function changeHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
	}
}
