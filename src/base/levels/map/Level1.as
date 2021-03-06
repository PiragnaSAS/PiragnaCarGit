﻿package base.levels.map
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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

	public class Level1 extends Map
	{
		private var myArray:Array = new Array();
		private var iniLandX:int = -200;
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
		private var endTimer:Number = 0;

		//private var hero:Hero;
		private var movementX:Number, movementY:Number;
		private var timer:Timer;
		
		private var iniSepUpX:int = iniLandX 
		private var iniSepUpY:int = iniLandY
		private var distanceSepUpX:Number= 36;
		private var distanceSepUpY:Number = 16;
		
		private var totalDistance:Number =94*Math.sqrt(3)*((45*8)+3);
		private var currentDistance:Number;
		
		private var iniSepDownX:Number = iniLandX+ 120;
		private var iniSepDownY:Number = iniLandY + 156;
		
		private var Layer:Object;
		
		private var winer:Winer;
		
		private var ended:Boolean = false;
		private var over:Boolean = false;
		private var outOfGas:Boolean = false;
		
		private var timerSetEnd:Timer;
	
		private var lifes:Number  = 3; 
				
		public function Level1(mapAdress:String,_hero:Hero, levers:InputHandler){	
			
			setLength(16);
			super(mapAdress, _hero, levers,General.modulesLvl1);
			timer=new Timer(500,1);
			winer=new Winer();
			//this.addEventListener(Event.ENTER_FRAME,onEnterFrame); 
			this.currentDistance = 0;
		}
		
		private function onAddedToStage(e:Event):void{}
				
		override public function createLayers():void{
			groundLayer = new GroundLayer(this.getAdmin().getFinalCarsLayer());	
			groundLayer.setSpeed(0);
			groundLayer.loadAssetsByLayer(currentDistance);
			addChild(groundLayer);
			
		/*	randomObjectsLayer = new RandomObjectsLayerInGround(this.getAdmin().getFinalCarsLayer());
			randomObjectsLayer.loadAssetsByLayer();
			randomObjectsLayer.setSpeed(0);
			addChild(randomObjectsLayer);
			*/
			
			raceLayer = new RaceLayer(this.getAdmin().getFinalRaceLayer());
			raceLayer.setSpeed(0);						
			raceLayer.loadFirstAssetsByLayer();
			addChild(raceLayer);
		

			carsLayer = new CarsLayer(this.getAdmin().getFinalCarsLayer(),this.getHero(),this);
			carsLayer.setSpeed(0);
			carsLayer.loadFirstAssetsByLayer();
			addChild(carsLayer);
			addChild(hero);
			//raceLayer.cargarCarros();*/
			
			frontObjectsLayer = new FrontObjectsLayer(this.getAdmin().getFinalFronObjectsLayer());
			frontObjectsLayer.setSpeed(0);
			frontObjectsLayer.loadFirstAssetsByLayer();
			addChild(frontObjectsLayer);
			//trace(this.getAdmin().getFinalCarsLayer().length,this.getAdmin().getFinalRaceLayer().length);
//			hulk=new Hulk(400, -80);
//			hulk.setSpeed(0);
//			superHero=new SuperHero("SuperMan", -50,410);
//			addChild(hulk);
//			addChild(superHero);
//			
			//collitionLayer= new CollitionLayer(layer);
	
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

		override public function update():Boolean{
			
			
			if(currentDistance > 21300){
				this.setCurrentSpeed(0);
				
				if(carsLayer != null){
					carsLayer.update();
					carsLayer.loadAssetsByLayer(currentDistance);
					carsLayer.setSpeed(this.getCurrentSpeed());
				}
				

				this.getHero().finalMove();
				
				if(this.getHero().x > General.viewPortGame.width+100){
						addChild(winer);
				}
				this.timerSetEnd =new Timer(5000,1);
				this.timerSetEnd.start();
				this.timerSetEnd.addEventListener(TimerEvent.TIMER, function(){this.ended = true;});
				
			}else{
				
				if(raceLayer == null)
					return false;
				
				if(this.getTargetSpeed()>this.getCurrentSpeed()){
					this.setCurrentSpeed(this.getCurrentSpeed()+0.1);
					
				if(this.getCurrentSpeed() > this.getAbsoluteMaximumSpeed())
					this.setCurrentSpeed(this.getAbsoluteMaximumSpeed());
			}		
			
			if(randomObjectsLayer != null){
				randomObjectsLayer.update();
				randomObjectsLayer.setSpeed(this.getCurrentSpeed());
			}
		
			if(groundLayer != null){
				if(currentDistance/totalDistance>=1.01){
					groundLayer.setSpeed(0);
				}else{
					groundLayer.setSpeed(this.getCurrentSpeed());
				}
				groundLayer.update();
				
			}
			
			if(raceLayer != null){
				if(currentDistance/totalDistance>=1.01){
					raceLayer.setSpeed(0);
				}else{
					raceLayer.setSpeed(this.getCurrentSpeed());
				}
				raceLayer.update();	
				raceLayer.loadAssetsByLayer(currentDistance);
				
			}
				
			if(frontObjectsLayer != null){
				if(currentDistance/totalDistance>=1.01){
					frontObjectsLayer.setSpeed(0);	
				}else{
					frontObjectsLayer.setSpeed(this.getCurrentSpeed());	
				}
				frontObjectsLayer.update();
				frontObjectsLayer.loadAssetsByLayer(currentDistance);
						
			}
			
			if(carsLayer != null){
				if(currentDistance/totalDistance>=1.01){
					
				}else{
					
				}
				carsLayer.update();
				carsLayer.loadAssetsByLayer(currentDistance);
				carsLayer.setSpeed(this.getCurrentSpeed());
			}
			
			if(getSuperHero()!=null && getSuperHero().x>= General.viewPortGame.width+200){
				setSuperHero(null);				
			}
			
			if(getSuperHero()!=null && currentDistance/totalDistance>=0.7 && this.getHero().getDeath()==0){
				setSuperHero(new SuperHero(getSuperHeroesArray()(Math.floor(Math.random()*2)),-50,410));
				addChild(getSuperHero());
				this.getHero().raiseSpecialScore();
			}
			
				if(raceLayer == null)
					return false;
				
				if(this.getTargetSpeed()>this.getCurrentSpeed()){
					this.setCurrentSpeed(this.getCurrentSpeed()+0.1);
					
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
					raceLayer.loadAssetsByLayer(currentDistance);
					raceLayer.setSpeed(this.getCurrentSpeed());
				}
					
				if(frontObjectsLayer != null){
					frontObjectsLayer.update();
					frontObjectsLayer.loadAssetsByLayer(currentDistance);
					frontObjectsLayer.setSpeed(this.getCurrentSpeed());			
				}
				
				if(carsLayer != null){
					carsLayer.update();
					carsLayer.loadAssetsByLayer(currentDistance);
					carsLayer.setSpeed(this.getCurrentSpeed());
				}
				
				if(getSuperHero()!=null && getSuperHero().x>= General.viewPortGame.width+200){
					setSuperHero(null);				
				}
				
				if(getSuperHero()!=null && currentDistance/totalDistance>=0.7 && this.getHero().getDeath()==0){
					setSuperHero(new SuperHero(getSuperHeroesArray()(Math.floor(Math.random()*2)),-50,410));
					addChild(getSuperHero());
					this.getHero().raiseSpecialScore();
				}
				
				if(getSuperHero()!=null){
					getSuperHero().update();
				}
				
				if(hulk!=null){
					hulk.update();
					hulk.setSpeed(this.getCurrentSpeed());
				}
				
				this.getHero().update();
				this.currentDistance += this.getCurrentSpeed();
				
				this.getProgress().upDateProgress(currentDistance/totalDistance);	
				this.getTrain().updateTrain(getHero().getFuel(),getHero().getScore(),this.getCurrentSpeed());
			}

			this.getHero().update();

			this.currentDistance += this.getCurrentSpeed();
			this.getProgress().upDateProgress(currentDistance/totalDistance);	
			this.getTrain().updateTrain(getHero().getFuel(),getHero().getScore(),this.getCurrentSpeed());
			return true;
		}
		
		public function isEnded():Boolean
		{
			return this.ended;
		}
		
		public function reduceLife():void
		{
			this.lifes = this.lifes -1;
		}
		
		public function getLifes():Number
		{
			return this.lifes;
		}
		
		public function isOutOfGas():Boolean
		{
			return this.outOfGas;
		}
		
		public function setOutOfGas(outGas:Boolean):void
		{
			this.outOfGas = outGas;
		}
	}
}