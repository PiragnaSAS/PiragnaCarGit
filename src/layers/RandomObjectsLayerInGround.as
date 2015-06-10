package layers
{
	import base.levels.map.parts.PiragnaSprite;
	
	import core.General;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class RandomObjectsLayerInGround extends Layer{
		
		private var _xCasas1:Number,_yCasas1:Number;
		private var _xCasas2:Number,_yCasas2:Number;
		
		private var _xArboles:Number,_yArboles:Number;
		
		private var arrayObjects:Array = ["casa1", "arbol1"];
				
		public function RandomObjectsLayerInGround(layer:Array){
			super(layer);
			
			_xCasas1 = 10;
			_yCasas1 = 120;
			
			_xCasas2 = 90;
			_yCasas2 = 400;
			
//			_xArboles = 80;
//			_yArboles = 400;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function generateRandomObjects():void{
						
			var randomNumber:Number;
			var aux:Number=Math.PI/2;
			for(var i:uint=0; i<=30; i++){
				if(Math.floor(Math.random())+1){
					addChild(new PiragnaSprite(_xCasas1, _yCasas1, arrayObjects[Math.floor(Math.random()*arrayObjects.length)],"randomObject"));
				}
				randomNumber= Math.random()*200+100;
				_xCasas1 += randomNumber+(randomNumber/5*Math.sin(aux));
				aux+=Math.PI;
				
				_yCasas1 -= randomNumber*Math.tan(Math.PI/6);
				
			}
			
//			for(var i:uint=0; i<=30; i++){
//				if(Math.floor(Math.random())+1){
//					addChild(new PiragnaSprite(_xCasas2, _yCasas2, arrayObjects[Math.floor(Math.random()*arrayObjects.length)]));
//				}
//				
//				randomNumber= Math.random()*100+30;
//				
//				_xCasas2 += randomNumber;
//				_yCasas2 -= randomNumber*Math.tan(Math.PI/6);
//			}
			
		}
		
		public function onAddedToStage():void{
			generateRandomObjects();
		}
		
		override public function update():void{
			
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed()*factorx;
				this.getChildAt(j).y -= this.getSpeed()*factory;										
			}
			
			var child:DisplayObject;
			
			if(getChildAt(0).x < -100 && getChildAt(0).y > General.screenHeight+200){		
				child = getChildAt(0);
				var randomNumber:Number= Math.random()*200+80;
				
				child.x = getChildAt(this.numChildren - 1).x + randomNumber;
				child.y = getChildAt(this.numChildren - 1).y - randomNumber*Math.tan(Math.PI/6);
				this.removeChildAt(0);
				this.addChild(child);					
			}			
		}				
			
	}
}