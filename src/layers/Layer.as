package layers
{
	
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
		protected var x:Number;
		protected var y:Number;
		protected var layer:Object;
		
		public function Layer(layer:Object)
		{
			this.layer=layer;
			//dataS=layer["data"] as String;
			data = layer["data"];			
			height=layer["height"];
			name=layer["name"];
			opacity=layer["opacity"];
			type=layer["type"];
			visible=layer["visible"];
			width=layer["width"];
			x=layer["x"];
			y=layer["y"];
			loadAssetsByLayer();
			
		}
		
		public function loadAssetsByLayer():void{
			var index:int=0;
			for (var i:int=0; i<this.width; i++){
				for(var j:int=0 ;j<this.height; j++){
					trace(name);
					trace (data[index]);
					index++;
				}
				
			}
			
					
		}
		
		
	}
}