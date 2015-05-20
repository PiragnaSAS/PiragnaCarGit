package layers
{
	
	import flash.utils.Dictionary;
	
	import base.levels.map.parts.PiragnaSprite;
	import base.levels.map.parts.Tiles;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

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
				
				
		public function Layer(layer:Object)
		{
			if(layer != null){
			    this.layer=layer;
				dataS=layer["data"] as String;
			    data = layer["data"];			
			    height=layer["height"];
				name=layer["name"];
				opacity=layer["opacity"];
				type=layer["type"];
				visible=layer["visible"];
				width=layer["width"];
				_x=50;
		    	_y=200;
			}
			trace(name);
			
			initialpointx=_x;
			initialpointy=_y;
			dict = new Dictionary();
			tiles= [];
		}
		
		public function loadAssetsByLayer():void{
				for (var i:int=0; i<this.height; i++){
						var piragnaSprite:PiragnaSprite = new PiragnaSprite(_x, _y, Tiles.dict[data[data.length-i - 1]]);
						
						addChild(piragnaSprite);
						_x += 101;
						_y -= 58; 
				}
				
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
			
			for(var j:uint=0; j<this.numChildren; j++){ 
				this.getChildAt(j).x -= this.getSpeed();
				this.getChildAt(j).y += this.getSpeed()*Math.tan(Math.PI/6 - .0021);										
			}
			
			var child:DisplayObject;
			
			if(getChildAt(0).x < -500 && getChildAt(0).y > 500){		
					child = getChildAt(0);
					child.x = getChildAt(this.numChildren - 1).x + 101;
					child.y = getChildAt(this.numChildren - 1).y - 58;
					removeChildAt(0);
					addChild(child);					
				}			
		}				
	}

}