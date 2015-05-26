package base.levels.map
{
	import base.levels.map.parts.Land;
	import base.levels.map.parts.PlaneLand;
	
	import car.hero.Hero;
	
	import collitionableObjects.superHeroes.Hulk;
	import collitionableObjects.superHeroes.SuperHero;
	
	import core.General;
	
	import inputHandler.InputHandler;
	
	import layers.CarsLayer;
	import layers.CollitionLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	import layers.RaceLayer;
	import layers.RandomObjectsLayerInGround;
	
	import starling.events.Event;
	import base.levels.map.parts.Tiles;

	public class Level1 extends Map
	{
		private var myArray:Array = new Array();
		private var iniLandX:int = -200
		private var iniLandY:int = General.screenHeight - 550;
		private var distanceLandX:Number= 36;
		private var distanceLandY:Number = 16;
		private var superHero:SuperHero;
		private var hulk:Hulk;
		private var randomObjectsLayer:RandomObjectsLayerInGround;
		private var groundLayer:GroundLayer;
		private var raceLayer:RaceLayer;
		private var frontObjectsLayer:FrontObjectsLayer;
		private var carsLayer:CarsLayer;
		private var collitionLayer:CollitionLayer;
		
		private var movementX:Number, movementY:Number;
		
		private var iniSepUpX:int = iniLandX 
		private var iniSepUpY:int = iniLandY
		private var distanceSepUpX:Number= 36;
		private var distanceSepUpY:Number = 16;
		
		private var totalDistance:Number = 5000;
		
		private var iniSepDownX:Number = iniLandX+ 120;
		private var iniSepDownY:Number = iniLandY + 156;
		
		private var Layer:Object;
		
		public function Level1(mapAdress:String,hero:Hero, levers:InputHandler)
		{			
			super(mapAdress, hero, levers);
			
			
			
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
			groundLayer.setSpeed(0);
			addChild(groundLayer);
			
			randomObjectsLayer = new RandomObjectsLayerInGround(layer);
			randomObjectsLayer.loadAssetsByLayer();
			randomObjectsLayer.setSpeed(0);
			addChild(randomObjectsLayer);
			
					
			for each (var layer:Object in this.getJSONLayer()["layers"]) 
			{	
				var layerName:String=layer["name"];
				trace(layerName);
				// decide where are we going to put the layer
				switch(layerName) {
					case "RaceLayer":
						raceLayer = new RaceLayer(layer);
						raceLayer.loadAssetsByLayer();
						raceLayer.setSpeed(0);						
						addChild(raceLayer);
						break;
					case "CarsLayer":
						carsLayer = new CarsLayer(layer);
						carsLayer.loadAssetsByLayer();
						carsLayer.setSpeed(0);
						addChild(carsLayer);
						//raceLayer.cargarCarros();*/
						break;
					
					case "FrontObjectsLayer":
						frontObjectsLayer = new FrontObjectsLayer(layer);
						frontObjectsLayer.loadAssetsByLayer();
						frontObjectsLayer.setSpeed(0);
						addChild(frontObjectsLayer);
						hulk=new Hulk(400, -80);
						hulk.setSpeed(0);
						superHero=new SuperHero("SuperMan", -50,410);
						addChild(hulk);
						addChild(superHero);
						break;
					case "CollitionsLayer":
						
						collitionLayer= new CollitionLayer(layer, this.getJSONLayer());
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
			
			if(this.getTargetSpeed()>this.getCurrentSpeed()){
				this.setCurrentSpeed(this.getCurrentSpeed()+0.5);
				
				if(this.getCurrentSpeed() > this.getAbsoluteMaximumSpeed())
					this.setCurrentSpeed(this.getAbsoluteMaximumSpeed());
			
			}else if(this.getTargetSpeed()<this.getCurrentSpeed()){
				
				var number:Number = this.getCurrentSpeed()*0.98<0.1? 0: this.getCurrentSpeed()*0.98; 
				this.setCurrentSpeed(number);
				
				if(this.getCurrentSpeed() > this.getAbsoluteMaximumSpeed())
					this.setCurrentSpeed(this.getAbsoluteMaximumSpeed());
			}			
			
			if(randomObjectsLayer != null){
				randomObjectsLayer.update();
				randomObjectsLayer.setSpeed(this.getCurrentSpeed());
			}
		
			if(groundLayer != null){
				groundLayer.update();
				groundLayer.setSpeed(this.getCurrentSpeed());
			}
			
			if(raceLayer != null){
				raceLayer.update();	     		
				raceLayer.setSpeed(this.getCurrentSpeed());
			}
				
			if(frontObjectsLayer != null){
				frontObjectsLayer.update();
				frontObjectsLayer.setSpeed(this.getCurrentSpeed());			
			}
			
			if(carsLayer != null){
				carsLayer.update();
				carsLayer.setSpeed(this.getCurrentSpeed());
			}
			if(superHero!=null){
				superHero.update();
				
			}
			if(hulk!=null){
				hulk.update();
				hulk.setSpeed(this.getCurrentSpeed());
			}
			
			this.getHero().update();
		}		
	}
}