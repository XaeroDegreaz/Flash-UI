package net.jerome.xmlmenu
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class XMLMenuItem extends MovieClip
	{
		public var subMenu:MovieClip = new MovieClip();
		public var menuItem:MenuItem;
		public var action:Object = [];
		private var menuParent;
		
		public function XMLMenuItem(itm:XML, mp)
		{
			menuParent = mp;
			
			this["label"].text = itm["@label"];
			
			action.func = String(itm["@func"]);
			action.params = itm["@params"];
			
			subMenu.x = this.x + this.width;
			subMenu.y = this.y;
			
			subMenu.visible = false;
			addChild(subMenu);
			
			for(var i in itm.children()) {
				
				var topLevel:XML = itm.children()[i];
				
				menuItem = new XMLMenuItem(topLevel, mp);
				menuItem.y = menuItem.bg.height * i;
				
				subMenu.addChild(menuItem);
			}
			
			if(subMenu.numChildren == 0) {
				this["subMenuIcon"].visible = false;
			}
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function showChildren(e:MouseEvent) {
			
			if(subMenu.numChildren > 0) {
				subMenu.visible = true;
			}
			
			e.currentTarget.gotoAndStop("over");
			
		}
		
		public function hideChildren(e:MouseEvent) {
			
			if(subMenu.numChildren > 0 || e.type == "mouseUp") {
				subMenu.visible = false;
			}
			
			e.currentTarget.gotoAndStop("up")
			
		}
		
		public function onMouseOver(e:MouseEvent) {
			if(subMenu.numChildren > 0) {
				subMenu.visible = true;
			}
			
			e.currentTarget.gotoAndStop("over");
		}
		
		public function onMouseOut(e:MouseEvent) {
			if(subMenu.numChildren > 0) {
				subMenu.visible = false;
			}
			
			e.currentTarget.gotoAndStop("up");
		}
		
		public function onMouseDown(e:MouseEvent) {
			if(subMenu.numChildren == 0) {
				e.currentTarget.gotoAndStop("down");
			}
		}
		
		public function onMouseUp(e:MouseEvent) {
			
			if(subMenu.numChildren == 0) {
				trace(action.params.pasda);
				e.currentTarget.gotoAndStop("up");
			}
			
			
		}
	}
}