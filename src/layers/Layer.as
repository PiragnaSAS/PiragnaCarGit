package layers
{
	
	import flash.utils.Dictionary;
	
	import assets.Assets;
	
	import base.levels.map.parts.PiragnaSprite;
	
	import core.General;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class Layer extends Sprite
	{	protected var data:Array;
		protected var dataS:String;
		protected var height:Number;
		protected var name:String;
		protected var opacity:Number;
		protected var type:String;
		protected var visible:Boolean;
		protected var width:Number;
		protected var layer:Object;
		private var dict:Dictionary;
		private var tiles:Array;
		private var initialpointx:uint;
		private var initialpointy:uint;
		private var speed:Number;
		private var _x:Number;
		private var _y:Number;
		public static var factorx:Number=Math.cos(Math.PI/6);
		public static var factory:Number=-Math.sin(Math.PI/6);
		public static var anchoCarretera:Number=96*Math.sqrt(3);
		public static var x0:Number;
		public static var y0:Number;
		public static var progress:Number = 0;
		public var atlasName:String = "TackCombinate";
		private var lastIndex:uint;
		
		public function Layer(layer:Array){		
			var c:Number= anchoCarretera;
			x0=General.viewPortGame.width/2-c*factorx;
			y0=General.viewPortGame.height/2-c*factory;
			
			lastIndex = 0;
			this.touchable=false;
			this.alpha = 0.5;
			
			if(layer != null){
			    data = layer;
			}
		
			dict = new Dictionary();
			tiles= [];		
		}
		
		public function loadFirstAssetsByLayer():void{
			
			for (var i:int=0; i<5; i++){
				_x =factorx*i*anchoCarretera+x0;
				_y =factory*i*anchoCarretera+y0;				
				
				if(data[i]!="transparency"){
					lastIndex = i;
					var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,new Image(Assets.getAtlasTexture(atlasName,data[data.length-i-1])),data[data.length-i-1]);
					addChild(piragnaSprite);						
				}			
			}
		}
		
		public function loadAssetsByLayer(currentDistance:Number):void{
			
			var l:uint =(Math.floor(currentDistance/anchoCarretera)+5);
			
			if(lastIndex < l){
				lastIndex = l;
				var l2:int=data.length-lastIndex-4;
	 			if(l2>=0 && data[l2]!="transparency" && data.length-lastIndex-4>=0)
				{
//					trace("z<<<<",lastIndex)
						_x = factorx*lastIndex*anchoCarretera + x0 - factorx*currentDistance;
						_y = factory*lastIndex*anchoCarretera + y0 - factory*currentDistance;
						var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y,new Image(Assets.getAtlasTexture(atlasName,data[l2])),data[l2]);
						//piragnaSprite.rotation = 15;
						addChild(piragnaSprite);		
				}
				
			}
			
			for(var j:uint=0; j<this.numChildren; j++){				
				if(this.getChildAt(j).x < -200){
					this.removeChildAt(j);										
				}else
					break;
			}	
				
		}
		
		public function getNumChildren():uint{
			return this.numChildren;
		}
		
		public function getTile(string:String):Object{
			return dict[string];
		}
		
		public function getSpeed():Number{
			return this.speed;
		}
		
		public function setSpeed(value:Number):void{
			this.speed = value;
		}
		
		public function update():void{
			
			if(numChildren>0){
				for(var j:uint=0; j<this.numChildren; j++){ 
					this.getChildAt(j).x -= this.getSpeed()*factorx;
					this.getChildAt(j).y -= this.getSpeed()*factory;				
				}
				
		/*		var child:DisplayObject;
				
				
				if(this.getChildAt(0).x < -500 && this.getChildAt(0).y > 500){
					child = this.getChildAt(0);
					
					child.x = this.getChildAt(this.numChildren - 1).x + 101;
					child.y = this.getChildAt(this.numChildren - 1).y - 58;
					this.removeChildAt(0);
					this.addChild(child);	
						
				}	*/
			}
		}				
	}

}
