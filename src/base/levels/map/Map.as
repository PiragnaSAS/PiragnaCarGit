package base.levels.map
{
	import flash.display.Bitmap;
	import flash.events.IOErrorEvent;
	
	import Progress.Progress;
	
	import assets.Assets;
	
	import base.levels.map.parts.Administrador;
	import base.levels.map.parts.Tiles;
	
	import car.hero.Hero;
	
	import collitionableObjects.superHeroes.SuperHero;
	
	import events.LeverEvent;
	
	import inputHandler.InputHandler;
	
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;
	
	import trainInformation.Train;
	
	
	public class Map extends Sprite
	{
		private var jsonLayers:Object;
		private var jsonObstacles:Object;
		protected var hero:Hero;
		private var levers:InputHandler;
		
		private var screenBitmap:Bitmap; // for drawing the map
		private var screenBitmapTopLayer:Bitmap; // data of an image, for drawing the map that the character will move under
		
		private var eventLoaders:Array;

		private var length:uint;
		
		//--->aqui
		private var mapWidth:uint;
		private var mapHeight:uint;
		private var tileWidth:uint;
		private var tileHeight:uint;
		private var tileSets:Array;
		private var totalTileSets:uint;		
		private var admin:Administrador;
		private var absoluteMaximumSpeed:Number;
		private var currentSpeed:Number;
		private var targetSpeed:Number;
		private var polyline:String;
		private var acelerating:Boolean = false;
			
		private var tilesLayers:Tiles;
		private var tilesObstacles:Tiles;
		
		private var progressBar:Progress;
		private var train:Train;
		private var superHero:SuperHero;
		private var superHerosArray:Array;
		
		private var numberOfModules:uint;
		
		public function Map(scene:String, hero:Hero, levers:InputHandler, numberOfModules:uint){	
			
			this.hero = hero;
			trace(this.hero,hero);
			this.numberOfModules = numberOfModules;
			this.absoluteMaximumSpeed = 10;
			this.currentSpeed = 0;
			this.targetSpeed = 0;

			//Levers settings
			this.levers = levers;
			this.levers.addEventListener(LeverEvent.ROTATE, onRotate);		
			this.levers.addEventListener(LeverEvent.ACCELERATE, onAcelerate);
			this.levers.addEventListener(LeverEvent.BREAK, onBreak);	
			this.levers.addEventListener(LeverEvent.BREAK_ROTATION, onBreakRotation);	
			
			this.progressBar = new Progress();
			this.train =new Train();
			this.loadScene(scene);
		}	
		
		private function loadScene(scene:String):void{
			admin=new Administrador();
			for (var i:int = 0; i < length; i++){
				var r:uint=Math.floor(Math.random()*numberOfModules);
				var r1:uint=Math.floor((Math.random()*3));
				//cargar mapa de esta forma "RedCarGame_Lvl_0"+scene+"_"+r
				
				jsonLayers=Assets.getJSON("RedCarGame_Lvl_0"+scene+"_0"+r);
				jsonObstacles=Assets.getJSON("RedCarGame_Lvl_0"+scene+"_0"+r+"_0"+r1);
				admin.addJson(jsonLayers,jsonObstacles);
			}

			admin.createFinalMap();

			createLayers();
			
			//this.addChild(hero);

			this.addChild(progressBar);
			this.addChild(train);
			this.addChild(levers);			
		}	
		
		private function onIOError(e:IOErrorEvent):void{
			trace("error: "+e.errorID);
		}
		
/*		private function onLoaderCompleteScene(e:Event):void{
			
			trace("here is here");
			jsonLayers = JSON.parse(e.target.data);
			trace("json layer"+jsonLayers);
	/*		mapWidth = jsonLayers["width"];
			mapHeight = jsonLayers["height"];
			tileWidth = jsonLayers["tilewidth"];
			tileHeight = jsonLayers["tileheight"];
			//tilesLayers = new Tiles(jsonLayers["tilesets"]);
			trace("---");
		//	admin.loadJson();
			//admin.addJson(jsonLayers);
			admin.createFinalMap();
			createLayers();
			this.addChild(hero);
			this.addChild(progressBar);
			this.addChild(levers);
		}	
		*/
			
		public function getAdmin():Administrador{
			return this.admin;
		}
		
		public function onRotate(e:LeverEvent):void{
			if(this.getCurrentSpeed() != 0)
					hero.move(e.data.rotationValue*this.getCurrentSpeed());
		}
		
		public function onBreakRotation(e:LeverEvent):void{
			hero.stopHero();
		}
		
		public function onAcelerate(e:LeverEvent):void{	
			var targetSpeed:Number = e.data.rotationValue*6;
			
			this.setTargetSpeed(targetSpeed);
		}
				
		public function onBreak():void
		{
			this.setTargetSpeed(0);	
		}	
		
		public function getLength():uint{
			return length;
		}
		
		public function setLength(length:uint):void{
			this.length = length;	
		}
		
		public function getMapWidth():uint
		{
			return mapWidth;
		}
		
		public function setMapWidth(newMapWidth:uint):void  
		{
			this.mapWidth=newMapWidth;
		}
		
		public function getMapHeigth():uint
		{
			return mapHeight;
		}
		
		public function setMapHeith(newMapHeith:uint):void
		{
			this.mapHeight=newMapHeith;
		}
		
		public function getTileWidth():uint{
			return tileWidth;
		}		
		
		public function setTileWidth(newTileWidth:uint):void{
			this.tileWidth=newTileWidth;
		}
		public function getTileHeith():uint{
			return tileHeight;
		}
		
		
		public function setTileHeith(newTileHeith:uint):void{
			this.tileHeight=newTileHeith;
		}
		
		public function getTileSets():Array{
			return tileSets;
		}
		
		public function setTileSets(newTileSets:Array):void{
			this.tileSets=newTileSets;
		}
		
		public function getTotalTileSets():uint{
			return totalTileSets;
		}
		
		public function setTotalTileSets(newTotalTileSets:uint):void{
			this.totalTileSets=newTotalTileSets;
		}
				
		public function getJSONLayer():Object{
			return jsonLayers;
		}	
						
		public function getCurrentSpeed():Number{
			return this.currentSpeed;
		}
		
		public function setCurrentSpeed(currentSpeed:Number):void{
			this.currentSpeed = currentSpeed;
		}
		
		public function getAbsoluteMaximumSpeed():Number{
			return this.absoluteMaximumSpeed;
		}		
		
		public function setAbsoluteMaximumSpeed(absoluteMaximumSpeed:Number):void{
			this.absoluteMaximumSpeed = absoluteMaximumSpeed;	
		}		
		
		public function getTargetSpeed():Number{
			return this.targetSpeed;
		}		
		
		public function setTargetSpeed(targetSpeed:Number):void{
			this.targetSpeed = targetSpeed;	
		}	
		
		public function getHero():Hero{
			return hero;
		}
		
		public function setHero(hero:Hero):void{
			this.hero=hero;
		}
		
		public function update():Boolean{				
			throw new AbstractMethodError();			
		}
		
		public function createLayers():void {
			throw new AbstractMethodError();			
		}	
		
		public function getProgress():Progress{
			return this.progressBar;
		}
		
		public function getTrain():Train{
			return this.train;
		}
		
		public function setSuperHero(superHero:SuperHero):void{
			this.superHero=superHero;
		}
		
		public function getSuperHero():SuperHero{
			return superHero;
		}
		
		public function setSuperHeroesArray(superHerosArray:Array):void{
			this.superHerosArray=superHerosArray;
		}
		
		public function getSuperHeroesArray():Array{
			return this.superHerosArray;
		}
		
	}		
}