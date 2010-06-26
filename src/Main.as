package {
	
	import flash.display.*;
	import flash.events.*;
	
	import net.jerome.ui.*;
	
	public class Main extends Sprite{
		
		public var pane_mc:TabbedScrollPane;
		
		public function Main()
		{
			pane_mc = new TabbedScrollPane(550, 300);
			
			pane_mc.addTab({
				label: "Test Tab",
				content: new TestTextField(),
				active: true
			});
			
			pane_mc.addTab({
				label: "Another Tab",
				content: new test2()
			});			
			
			addChild(pane_mc);
			
			tstbtn.addEventListener(MouseEvent.CLICK, nt);
		}
		
		public function nt(e:MouseEvent):void {
			pane_mc.addTab({
				label: "Scooby dooby boo",
				active: true,
				content: new test2()
			});
		}
		
	}
}