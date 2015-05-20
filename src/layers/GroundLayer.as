package layers
{
	import base.levels.map.parts.PiragnaSprite;
	
	import starling.display.DisplayObject;
	
	public class GroundLayer extends Layer
	{
		private var _x:Number;
		private var _y:Number;
		
		public function GroundLayer(layer:Object){
			super(layer);			
			_x = -50;
			_y = -200;
		}		
		
		
		override public function loadAssetsByLayer():void{
			
			for (var i:int=0; i<4; i++){
				addChild(new PiragnaSprite(_x, _y, "ground"));
				_x += 609.5;
				_y -= 351; 
			}
			
		}
		
		override public function update():void{
			
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed();
				this.getChildAt(j).y += this.getSpeed()*0.5779;										
			}
			
			var child:DisplayObject;
			
			if(getChildAt(0).x < -500 && getChildAt(0).y > 500){		
				child = getChildAt(0);
				child.x = getChildAt(this.numChildren - 1).x + 609.5;
				child.y = getChildAt(this.numChildren - 1).y - 351;
				removeChildAt(0);
				addChild(child);					
			}						
		
		}
		
    }
}