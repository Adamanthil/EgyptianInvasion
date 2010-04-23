package EgyptianInvasion
{
	import assets.*;
	
	import flash.display.*;
	import flash.events.*;
	
	public class Main extends Sprite {

		private var buildingPhase:Boolean;	// indicates if game is in the building phase
		
		private var placeNodeButton:Button;
		private var beginInvasionButton:Button;
		
		private var ui:UI; // Our compartmentalized UI
		private var nodeMan:NodeManager;
		private var enemyMan:EnemyManager;
		
		public function Main () {
			// Start in building phase
			this.buildingPhase = true;
			
			var bg:MovieClip = new BackgroundTest();
			bg.scaleX = 0.7;
			bg.scaleY = 0.7;
			bg.x = 200;
			bg.y = 200;
			this.addChild(bg);
			
			ui = new UI(0,0,stage);
			this.addChild(ui);
			
			placeNodeButton = new Button(new assets.ToggleButton(), 50,100, "Add Node",stage);
			placeNodeButton.setMouseDown(addNodeHandler);
			this.addChild(placeNodeButton);
			
			var pyramid:Pyramid = new Pyramid(new assets.pyramid2(), 300,250,stage);
			pyramid.scaleX = 0.7;
			this.addChild(pyramid);
			
			var changeNodeButton:Button = new Button(new assets.ToggleButton(), 50,50, "Change Node",stage);
			this.addChild(changeNodeButton);
			
			beginInvasionButton = new Button(new assets.ToggleButton(), 50, 150, "Begin Invasion", stage);
			beginInvasionButton.setMouseDown(beginInvasionHandler);
			this.addChild(beginInvasionButton);
			
			nodeMan = new NodeManager(this);
			this.addChild(nodeMan);
			
			enemyMan = new EnemyManager(this,nodeMan);
			
			stage.frameRate = 100;			
			
		}
		public function getPlaceNodeButton():Button
		{
			return placeNodeButton;
		}
		
		// -- Button Event Handlers -------------------------
		
		// Event handler for adding a node on a mouseDown button click
		public var addNodeHandler:Function = function (e:MouseEvent):void {
			var button:Button = Button(e.currentTarget);
			var buttonAsset:MovieClip = MovieClip(button.getButtonAsset());
			
			if (button.isDown()){
				button.setDown(false);
				Main(button.parent).nodeMan.setToggledNode(null);
			}
			else {
				button.setDown(true);
				Main(button.parent).nodeMan.addNode(new Node(e.stageX, e.stageY, Main(button.parent).stage));
			}
		}
			
		public var beginInvasionHandler:Function = function (e:MouseEvent):void {
			var button:Button = Button(e.currentTarget);
			var buttonAsset:MovieClip = MovieClip(button.getButtonAsset());
			
			if (!button.isDown()){
				// If there is a path from start to end, begin the invasion!
				if(Main(button.parent).nodeMan.getStartNode().pathExists(Main(button.parent).nodeMan.getEndNode())) {
					button.setDown(false);
					this.buildingPhase = false;
					
					Main(button.parent).enemyMan.beginInvasion();
				}
				
			}
		}
		
	}
}