package net.jerome.xmlmenu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLMenu extends MovieClip
	{
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader = new URLLoader();
		private var menu:XML;
		public var menuClip:MovieClip = new MovieClip();
		private var menuItem:XMLMenuItem;
		private var file:String;
		
		public function XMLMenu(target:String) {
			file = target;			
			xmlLoader.addEventListener(Event.COMPLETE, parseMenu);
			addChild(menuClip);				
		}
		
		public function load() {
			xmlLoader.load(new URLRequest(file));
		}
		
		public function parseMenu(e:Event) {
			menu = new XML(e.target.data);
			
			for (var i in menu.children()) {
				var topLevel:XML = menu.children()[i];
				
				menuItem = new XMLMenuItem(topLevel, this.parent);
				menuItem.y = menuItem.bg.height * i;
				menuItem.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				menuClip.addChild(menuItem);
				
			}
			
		}
		
		public function onMouseUp(e) {
			if(e.currentTarget.subMenu.numChildren > 0) {
				e.currentTarget.subMenu.visible = false;
			}
		}
	}
}