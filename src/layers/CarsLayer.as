package layers
{
	
	import base.levels.map.parts.PiragnaSprite;
	import base.levels.map.parts.Tiles;
	
	import core.General;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	//car_1_1_2
	
	public class CarsLayer extends Layer
	{
		private var _x:Number;
		private var _y:Number;
		
		public function CarsLayer(layer:Object)
		{
			super(layer);
			_y=265;
			_x=-10;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage():void{}
		
		override public function loadAssetsByLayer():void
		{
//			var i:uint;
//			var j:uint;
//			var k:uint;
//			var x1:Number=-10+101;
//			var y1:Number=265-58;
//			var dx:Number=101;
//			var dy:Number=58;
//			var dx1:Number=dx/3;
//			var dy1:Number=-dy/3;
//			var dx2:Number=dx/6;
//			var dy2:Number=dy/6;
//			
//			k=0;
//			for (i = 0; i < (8*3*2); i++) 
//			{
//				for (j = 0; j < (6); j++) 
//				{
//					if(k<data.length && data[k]!="transparency"){
//						_x=x1+dx1*i+dx2*j;
//						_y=y1+dy1*i+dy2*j;
//						var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,this.data[k]);
//						trace(data[k]);
//						piragnaSprite.x=_x;
//						piragnaSprite.y=_y;
//						addChild(piragnaSprite);
//					}
//					k++;
//				}
//			}
//			
//			
//			
//			
//			
//			
//			trace("aguita de coco");
//			/*for (var i:int=0; i<this.data.length; i++){	
//				for(var j:uint=0; j<5;j++){
//					
//					trace("holi: "+data[i]);
//					if (data[i]!="transparency"){
//						var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,this.data[i]);
//						addChild(piragnaSprite);
//					}
//					_x += 101/5;
//					_y += 58/5; 
//
//				}
//				_x-=101/5*j-101/3;
//				_y-=58/5*j+58/3;
//				
//			}*/
		}
			
		
		
		override public function update():void{
			if(numChildren>0){
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed();
				this.getChildAt(j).y += this.getSpeed()*Math.tan(Math.PI/6);										
			}
			
			var child:DisplayObject;
			
			if(this.getChildAt(0).x < -100 && this.getChildAt(0).y > General.screenHeight+200){		
				child = getChildAt(0);
				var randomNumber:Number= Math.random()*200+80;
				
				child.x = getChildAt(this.numChildren - 1).x + randomNumber/3;
				child.y = getChildAt(this.numChildren - 1).y - (randomNumber*Math.tan(Math.PI/6)/3);
				this.removeChildAt(0);
				this.addChild(child);					
			}
			}
		}
	}
}