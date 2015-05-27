package layers
{

	import flash.utils.setInterval;	
	import base.levels.map.parts.PiragnaSprite;
	import base.levels.map.parts.Tiles;
	
	import core.General;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class CarsLayer extends Layer
	{
		private var _x:Number;
		private var _y:Number;
		
		public function CarsLayer(layer:Object)
		{
			trace(layer["data"]);
			super(layer);
			_y=265;
			_x=-10;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage():void{}
		
		override public function loadAssetsByLayer():void
		{
			trace("aguita de coco");
			for (var i:int=0; i<this.height; ){	
				for(var j:uint=0; j<5;j++){
					
					trace("holi: "+data[i]);
					var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y, Tiles.dict[data[i]]);
					addChild(piragnaSprite);
					_x += 101/5;
					_y += 58/5; 
					i++;
				}
				_x-=101/5*j-101/3;
				_y-=58/5*j+58/3;
				
			}
		}
			
		
		
		override public function update():void{
			
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed();
				this.getChildAt(j).y += this.getSpeed()*Math.tan(Math.PI/6);										
			}
			
			var child:DisplayObject;
			
			if(getChildAt(0).x < -100 && getChildAt(0).y > General.screenHeight+200){		
				child = getChildAt(0);
				var randomNumber:Number= Math.random()*200+80;
				
				child.x = getChildAt(this.numChildren - 1).x + randomNumber;
				child.y = getChildAt(this.numChildren - 1).y - randomNumber*Math.tan(Math.PI/6);
				removeChildAt(0);
				addChild(child);					
			}
			
		}
	}
}