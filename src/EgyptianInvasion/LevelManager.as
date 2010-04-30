package EgyptianInvasion
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	public class LevelManager
	{
		private var currLevel:Number;
		private var currGold:Number;
		private var main:Main;
		private var enMan:EnemyManager;
		private var noMan:NodeManager;
		private var ui:UI;
		private var canvas:Stage;
		private var interest:Number;
		private var loader:URLLoader;
		private var s_x:String;
		private var goldTextField:TextField;
		private var format:TextFormat;
		
		public const fireRoomCost:Number = 100;
		public const pitRoomCost:Number = 20;
		public const snakeRoomCost:Number = 50;
		public const quickSoundCost:Number = 80;
		
		public function LevelManager(m:Main, em:EnemyManager, nm:NodeManager, can:Stage,ui:UI)
		{
			/*nm = new NodeManager(m);
			m.addChild(nm);
			
			ui = new UI(50,0,can,m);
			m.addChild(ui);
			
			
			em = new EnemyManager(m,nm);*/
			this.main = m;
			this.enMan = em;
			this.noMan = nm;
			this.ui = ui;
			this.canvas =can;
			currLevel = 1;
			currGold = 100;
			interest = 0.3;
			setStartEndNode();
			displayGold(currGold);
			deductGold(20);
			
		}
		
		public function setStartEndNode():void{
			loader = new URLLoader();
			
			//telling the loader that we are dealing with variables here.
			//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(Event.COMPLETE, nodeLoading);
			
			//Here we tell our loading which file to extract from.
			loader.load(new URLRequest("../assets/level1content.txt"));
			//if (loader.
			
			/*var s_y:Number = loader.data.start_y;
			var e_x:Number = loader.data.final_x;
			var e_y:Number = loader.data.final_y;
			*/
			s_x = "data?"+loader.data;
		}
		
		private function nodeLoading (e:Event):void {
			//content_1.text = loader.data.var_1
			//content_2.text = loader.data.var_2
			//goldTextField.text = "data?"+loader.data;
		}
		private function calculateGold(gold:Number):void{
			currGold = gold*(1+interest);
		}
		
		public function nextLevel(gold:Number):void{
			currLevel++;
			calculateGold(gold);
			reInitialize();//initialize nodemanger and enemymanager
			setStartEndNode();
			displayGold(currGold);
		}
		
		private function reInitialize():void{
			
		}
		
		public function displayGold(gold:Number):void{
			format = new TextFormat();
			format.color = 0xFFFF32; 
			format.size = 10; 	
			goldTextField = new TextField();
			//myTextField_txt.wordWrap=true;
			goldTextField.autoSize=TextFieldAutoSize.LEFT;
			goldTextField.text = "GOLD LEFT: "+ gold;
			goldTextField.setTextFormat(format);
			//myTextField_txt.text.
			goldTextField.x = 400;
			goldTextField.y = 10;
			main.addChild(goldTextField);
			
		}
		
		public function deductGold(amount:Number):void{
			currGold -=amount;
			
			goldTextField.text = "GOLD LEFT: " + currGold;
			goldTextField.setTextFormat(format);
		}
		
		public function setInterest(amount:Number):void{
			interest = amount;
		}
	}
}