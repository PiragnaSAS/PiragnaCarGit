package layers
{
	import base.levels.map.parts.PiragnaSprite;
	
	import resources.Resources;
	
	import starling.display.DisplayObject;
	
	public class GroundLayer extends Layer
	{
		private var _x:Number;
		private var _y:Number;
		
		public function GroundLayer(layer:Object){
			super(layer);			
			_x = 50;
			_y = 222;
		}		
		
		
		override public function loadAssetsByLayer():void{
			
			for (var i:int=0; i<4; i++){
				addChild(new PiragnaSprite(_x, _y, "ground"));
				
				if(Resources.scaleContentFactor == 1){
					_x += 609.5;
					_y -= 351; 
				}else{
					_x += 914.5;
					_y -= 521.5; 	
				}
				
			}
			
		}
		
		override public function update():void{
			
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed();
				this.getChildAt(j).y += this.getSpeed()*Math.tan(Math.PI/6 - .0021);										
			}
			
			var child:DisplayObject;
			
			if(getChildAt(0).x < -500 && getChildAt(0).y > 500){		
				child = getChildAt(0);
				
				if(Resources.scaleContentFactor == 1){
					child.x = getChildAt(this.numChildren - 1).x + 609.5;
					child.y = getChildAt(this.numChildren - 1).y - 351;
				}else{
					child.x = getChildAt(this.numChildren - 1).x + 914.5;
					child.y = getChildAt(this.numChildren - 1).y - 521.5; 	
				}
				
				removeChildAt(0);
				addChild(child);					
			}						
		
		}
		
    }
}