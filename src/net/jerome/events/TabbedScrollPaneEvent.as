package net.jerome.events {
	
	import flash.events.Event;
	
	
	public class TabbedScrollPaneEvent extends Event {
		
		public static const ACTIVATE:String = "tab_activate";
		public static const DEACTIVATE:String = "tab_deactivate";
		public static const ADDED:String = "tab_added";
		public static const REMOVED:String = "tab_removed";
		
		public function TabbedScrollPaneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}