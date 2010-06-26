package net.jerome.ui {
	
	import flash.display.*;
	
	import net.jerome.events.*;
	
	public class TabbedScrollPane extends MovieClip {
		/**
		 * An array containing all of the TabbedScrollPaneTab objects.
		 * */
		public static var tabList:Array =  new Array();		
		/**
		 * The currently active tab
		 * */
		private var activeTab:TabbedScrollPaneTab;		
		/**
		 * The content that is currently being displayed in the ScrollPane component.
		 * */
		public var content:DisplayObject;		
		/**
		 * Create a TabbedScrollPane object. It has all of the functionality of the
		 * standard ScrollPane component, but has tabs to control the content.
		 * */
		public function TabbedScrollPane($width:Number, $height:Number) {
			
			scrollpane_mc.setSize($width, $height);
			separator_mc.width = scrollpane_mc.width;
			
			TabbedScrollPaneTab.dimensions.width = $width;
			TabbedScrollPaneTab.dimensions.height = $height;
		}
		
		/**
		 *Add a new TabbedScrollPaneTab to the component. 
		 * @param data An object containing tab initialization information. {label:String, active:Boolean, content:DisplayObject}
		 * 
		 */		
		public function addTab(data:Object):void {
			//# Insert the new tab into the tabList array
			var index:int = tabList.push( new TabbedScrollPaneTab(data) ) - 1;
			var newTab:TabbedScrollPaneTab = tabList[index];
			
			//# Edit some tab properties.
			newTab.x = index * newTab.width;
			newTab._index = index;
			
			addChild(newTab);
			newTab._content.dispatchEvent( new TabbedScrollPaneEvent(TabbedScrollPaneEvent.ADDED) );
			
			redrawAllTabs();
		}
		
		/**
		 *Redraws all of the tabs in this component. 
		 * 
		 */		
		private function redrawAllTabs():void {
			for (var i in tabList) {
				var tab:TabbedScrollPaneTab = tabList[i];
				tab._index = i;
				tab.redraw();
			}
		}
		
		/**
		 *Removes a tab with the given index 
		 * @param index The integer index of the tab to close.
		 * 
		 */		
		public function removeTab(index:int):void {
			//# First we determine which one of the tabs in the list to activate after this tab is removed.
			var nextActiveTab:TabbedScrollPaneTab;
			var target:TabbedScrollPaneTab = getTabByIndex(index);
			
			//# We need to check to see if this tab was active when it was closed. If so then we need to activate
			//# another one, if available.
			if(target._state == "active") {
			
				//# We try the one if front of this tab first.
				try {
					nextActiveTab = getTabByIndex(index+1);
					nextActiveTab.setActive(null, true);
				}catch(e:Error) {				
					try {
						nextActiveTab = getTabByIndex(index-1);
						nextActiveTab.setActive(null, true);
					}catch(e:Error) {
						trace("There are no tabs left.");
						//# Just erase whatever is in the content with a blank mc
						setContent(new MovieClip());
					}				
				}
			}
			
			//# Go ahead and remove this tab from the TabbedScrollPane
			target._content.dispatchEvent( new TabbedScrollPaneEvent(TabbedScrollPaneEvent.REMOVED) );
			removeChild(target);
			
			//# Remove this tab from our aray
			tabList.splice(index, 1);
			
			redrawAllTabs();	
		}
		
		/**
		 *Activates the selected tab, displaying its content in the ScrollPane 
		 * @param target The TabbedScrollPaneTab object to activate.
		 * 
		 */		
		public function setActiveTab(target:TabbedScrollPaneTab):void {
			//# Deactivate the currently selected tab if it isn't the tab being activate (eg the last tab).
			if(activeTab && target != activeTab) {
				activeTab.setActive(null, false);
				content.dispatchEvent( new TabbedScrollPaneEvent(TabbedScrollPaneEvent.DEACTIVATE) );
			}
			
			//# Reference the new tab as the new hotness.
			activeTab = target;
			
			setContent(activeTab._content);
			content.dispatchEvent( new TabbedScrollPaneEvent(TabbedScrollPaneEvent.ACTIVATE) );
		}
		
		/**
		 *Updates the ScrollPane with the content property from a tab. 
		 * @param src The DisplayObject held in the content property of a tab.
		 * 
		 */		
		private function setContent(src:DisplayObject):void {
			scrollpane_mc.source = src;
			scrollpane_mc.content.x += 10;
			scrollpane_mc.content.y += 10;
			
			content = scrollpane_mc.content;
		}
		
		/**
		 *Get a TabbedScrollPaneTab object according to its index in the tabList array.
		 * @param index
		 * @return The TabbedScrollPaneTab at the index position in the tabList array
		 * 
		 */		
		public function getTabByIndex(index:int):TabbedScrollPaneTab {
			return tabList[index];
		}
		
		/**
		 * Get a TabbedScrollPaneTab object according to its label.
		 * @param label The label of the desired tab.
		 * @return The first TabbedScrollPaneTab object with the specified label.
		 * 
		 */		
		public function getTabByLabel(label:String):TabbedScrollPaneTab {
			
			for(var i in tabList) {
				var tab:TabbedScrollPaneTab = tabList[i];
				
				if(_data.label == label) {
					return tab;
				}
			}
			
		}
		
	}
}