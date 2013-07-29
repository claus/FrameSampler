package v9fs.views.events
{
	import flash.events.Event;
	
	public class SettingsViewEvent extends Event
	{
		public static const CHANGE:String = "SettingsViewEvent_CHANGE";
		
		public static const VT_INTERVAL:String = "VT_INTERVAL";
		public static const VT_INTERVAL_START:String = "VT_INTERVAL_START";
		public static const VT_GRID_SIZE_H:String = "VT_GRID_SIZE_H";
		public static const VT_GRID_START_H:String = "VT_GRID_START_H";
		public static const VT_GRID_SIZE_V:String = "VT_GRID_SIZE_V";
		public static const VT_GRID_START_V:String = "VT_GRID_START_V";
		public static const VT_MAX_SAMPLES:String = "VT_MAX_SAMPLES";
		public static const VT_SAVE_PNG:String = "VT_SAVE_PNG";
		public static const VT_LOG_TRACES:String = "VT_LOG_TRACES";
		
		public var valueType:String;
		
		public function SettingsViewEvent(type:String, valueType:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.valueType = valueType;
		}
	}
}