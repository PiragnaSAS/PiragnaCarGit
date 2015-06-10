package layers
{
	import assets.Assets;
	
	import base.levels.map.parts.PiragnaSprite;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	public class GroundLayer extends Layer
	{
		private var _x:Number;
		private var _y:Number;
		private var numberOfGrounds:uint = 4;
		public function GroundLayer(layer:Array){
			super(layer);			
		}		
		
		
		override public function loadAssetsByLayer(currentDistance:Number):void{			
			for (var i:int=0; i<numberOfGrounds; i++){
					_x=x0+2*i*anchoCarretera*factorx-anchoCarretera*factorx;
					_y=y0+2*i*anchoCarretera*factory+anchoCarretera*factory;
					addChild(new PiragnaSprite(_x, _y, new Image(Assets.getAtlasTexture("Environment_0","bg_"+Math.floor(Math.random()*2)))));
					_x=x0+2*i*anchoCarretera*factorx+anchoCarretera*factorx;
					_y=y0+2*i*anchoCarretera*factory-anchoCarretera*factory;
					addChild(new PiragnaSprite(_x, _y, new Image(Assets.getAtlasTexture("Environment_0","fr_0"))));
			}				
		}
		
		override public function update():void{
			
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed()*factorx;
				this.getChildAt(j).y -= this.getSpeed()*factory;									
			}
			
			var child:DisplayObject;
			
			if(getChildAt(0).x < -300){		
				child = getChildAt(0);
				
				child.x += 2*anchoCarretera*factorx*numberOfGrounds;
				child.y += 2*anchoCarretera*factory*numberOfGrounds; 	
				
				this.removeChildAt(0);
				this.addChild(child);	
			}						
		
		}		
		
		
    }
}