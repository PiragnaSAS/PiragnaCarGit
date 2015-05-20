package base.levels.map
{
	import base.levels.map.parts.Land;
	import base.levels.map.parts.PlaneLand;
	
	import core.General;
	
	import layers.CarsLayer;
	import layers.CollitionLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	import layers.RaceLayer;
	
	import starling.events.Event;

	public class Level1 extends Map
	{
		private var myArray:Array = new Array();
		private var iniLandX:int = -200//-490;
		private var iniLandY:int = General.screenHeight - 550;
		private var distanceLandX:Number= 36;
		private var distanceLandY:Number = 16;
		
		private var groundLayer:GroundLayer;
		private var raceLayer:RaceLayer;
		private var frontObjectsLayer:FrontObjectsLayer;
		private var carsLayer:CarsLayer;
		private var collitionLayer:CollitionLayer;
		
		private var iniSepUpX:int = iniLandX 
		private var iniSepUpY:int = iniLandY
		private var distanceSepUpX:Number= 36;
		private var distanceSepUpY:Number = 16;
		
		private var iniSepDownX:Number = iniLandX+ 120;
		private var iniSepDownY:Number = iniLandY + 156;
		
		public function Level1(mapAdress:String)
		{			
			super(mapAdress);
			for(var i:uint = 0; i<250; i++){
				myArray[i] = i%2;//Math.floor(Math.random()*0);
			}
			//addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.addLand(this.iniLandX,this.iniLandY);			
		}
				
		private function addLand(x:Number, y:Number):void
		{
			this.getGroundLayer().addChild(new Land(x,y));
		}
		
		private function addPlaneLand(x:Number, y:Number):void{
			this.getGroundLayer().addChild(new PlaneLand(x,y));
		}
				
		override public function createLayers():void{
			
			groundLayer = new GroundLayer(layer);	
			groundLayer.loadAssetsByLayer();
			groundLayer.setSpeed(4);
			addChild(groundLayer);
			
			for each (var layer:Object in this.getJSON()["layers"]) 
			{	
				trace("holaquehace");
				
				var layerName:String=layer["name"];
				
				// decide where we're going to put the layer
												
				switch(layerName) {
					case "RaceLayer":
						raceLayer = new RaceLayer(layer);
						raceLayer.loadAssetsByLayer();
						raceLayer.setSpeed(10);
						addChild(raceLayer);
						break;
					case "FrontObjectsLayer":
						frontObjectsLayer = new FrontObjectsLayer(layer);
						frontObjectsLayer.loadAssetsByLayer();
						frontObjectsLayer.setSpeed(10);
						addChild(frontObjectsLayer);
						break;
					case "CollitionLayer":
						collitionLayer= new CollitionLayer(layer, this.getJSON());
						break;						
				}						
			}			
		}
		
		public function getGroundLayer():GroundLayer{
			return groundLayer;
		}
		
		public function setGroundLayer(newGroundLayer:GroundLayer):void{
			this.groundLayer=newGroundLayer;
		}
		
		public function getRaceLayer():RaceLayer{
			return raceLayer;
		}
		
		public function setRaceLayer(newRaceLayer:RaceLayer):void{
			this.raceLayer=newRaceLayer;
		}
		
		public function getFrontObjectsLayer():FrontObjectsLayer{
			return frontObjectsLayer;
		}
		
		public function setFrontObjectsLayer(newFrontObjectsLayer:FrontObjectsLayer):void{
			this.frontObjectsLayer=newFrontObjectsLayer;
		}
		
		public function getCarsLayer():CarsLayer{
			return carsLayer;
		}
		
		public function setCarsLayer(newCarsLayer:CarsLayer):void{
			this.carsLayer=newCarsLayer;
		}

		override public function update():void{				
			
			if(groundLayer != null)
				groundLayer.update();
			
			if(raceLayer != null)
				raceLayer.update();	     		
			
			if(frontObjectsLayer != null)
				frontObjectsLayer.update();
						
			if(carsLayer != null)
				carsLayer.update();
		}
		
	}
}