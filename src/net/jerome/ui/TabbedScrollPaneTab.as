package net.jerome.ui {
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	public class TabbedScrollPaneTab extends MovieClip {
		/**
		 *The state of this tab. Either active or inactive 
		 */		
		public var _state:String;
		/**
		 *The data object used in the contructor 
		 */		
		private var _data:Object;
		/**
		 *The DisplayObject to display in the ScrollPane component when this tab's _state is active. 
		 */		
		public var _content:DisplayObject;
		/**
		 *The index of this tab in the TabbedScrollPane.tabList array 
		 */		
		public var _index:int;
		/**
		 *An object containing dimension information for the TabbedScrollPane component itself. 
		 */		
		public static var dimensions:Object = {};
		
		/**
		 *A tab clip that allows a user to change the content of a ScrollPane in a TabbedScrollPane clip. 
		 * @param $data
		 * 
		 */		
		public function TabbedScrollPaneTab($data:Object)
		{
			_data = $data;
			_content = _data.content;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			button_mc.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver);
			button_mc.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut);
			button_mc.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		/**
		 *Initialize this tab when it's added to the display list. 
		 * @param e
		 * 
		 */		
		private function init(e:Event):void {
			label_txt.autoSize = TextFieldAutoSize.CENTER;	
			label_txt.text = _data.label;			
			label_txt.mouseEnabled = false;
			
			if(_data.active) {
				setActive(null, true);
			}else {
				setActive(null, false);
			}
			
			redraw();
		}
		
		/**
		 *Redraw this tab so that its parts are properly sized according to how many
		 * other tabs there are in the TabbedScrollPane.tabList array. 
		 * 
		 */		
		public function redraw():void {
			
			//# We need to make sure that when tabs are added, that they all are properly sized
			//# And scale to the size of the ScrollPane and separator.
			var left:MovieClip = left_mc;
			var right:MovieClip = right_mc;
			var left_and_right:Number = left.width + right.width;
			//# The total tabs will factor in to our equation.
			var totalTabs:int = TabbedScrollPane.tabList.length;
			
			//# tw = ((spw / 2) / tt) + lr
			//# mw = ((spw / 2) / tt)
			
			middle_mc.width = ( (dimensions.width) / (totalTabs) ) - left_and_right;
			left.x = middle_mc.x - left.width;
			right.x = middle_mc.x + middle_mc.width;
			button_mc.x = left_and_right + middle_mc.width - button_mc.width - 1;
			label_txt.x = middle_mc.x + (middle_mc.width / 2) - (label_txt.width / 2);
			
			try {
				bottom_mc.width = (left_and_right + middle_mc.width);
			}catch(e:Error){
				//trace([e, _state]);
			}
			
			x = (left_and_right + middle_mc.width) * _index;
		}
		/**
		 * MouseOver effects
		 * @param e
		 * 
		 */		
		private function onButtonOver(e:MouseEvent):void {
			e.currentTarget.gotoAndStop("over");
		}
		
		/**
		 *MouseOut effects 
		 * @param e
		 * 
		 */		
		private function onButtonOut(e:MouseEvent):void {
			e.currentTarget.gotoAndStop(_state);			
		}
		
		/**
		 *MouseClick vent that will close this tab. 
		 * @param e
		 * 
		 */		
		private function onButtonClick(e:MouseEvent):void {
			//# Remove this from the tab list
			TabbedScrollPane(parent).removeTab(_index);			
		}
		
		/**
		 *Set the state of this tab to active or inactive. 
		 * @param e:MouseEvent If this is not null, then it is automatically assumed to activate this tab since it
		 * was clicked.
		 * @param value:Boolean If e:MouseEvent was null, then this is evaluated to see whether or not to activate
		 * this tab.
		 * @example setActive(null, true) to manually activate or setActive(e) if passing a MouseEvent.
		 * 
		 */		
		public function setActive(e:MouseEvent = null, value:Boolean = false):void {
			if(e) {
				_state = "active";
				
				gotoAndStop("active");				
				button_mc.gotoAndStop("active");
				
				middle_mc.removeEventListener(MouseEvent.CLICK, setActive);
				left_mc.removeEventListener(MouseEvent.CLICK, setActive);
				
				TabbedScrollPane(this.parent).setActiveTab(this);
				redraw();
				return;
			}
			
			
			if(value) {
				_state = "active";
				
				gotoAndStop("active");				
				button_mc.gotoAndStop("active");
				
				middle_mc.removeEventListener(MouseEvent.CLICK, setActive);
				left_mc.removeEventListener(MouseEvent.CLICK, setActive);
				
				TabbedScrollPane(this.parent).setActiveTab(this);
				redraw();
				return;
			}else {
				_state = "inactive";				
				
				gotoAndStop("inactive");
				button_mc.gotoAndStop("inactive");
				
				middle_mc.addEventListener(MouseEvent.CLICK, setActive);
				left_mc.addEventListener(MouseEvent.CLICK, setActive);
				
				redraw();
			}
			
		}
		
	}
}