package layers
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class CollitionLayer extends Sprite
	{
	 private var _layer:Object;
	 private var _name:String;
	 private var _positions:Array;
	 protected var visible:Boolean;
	 protected var width:Number;
	 protected var height:Number;
	
	 private var newpoint:Point;
		public function CollitionLayer(newLayer:Object,jsonPoints:Object)
		{
		
			this.layer=newLayer;
			this.name=newLayer["name"];
			height=newLayer["height"];
			visible=newLayer["visible"];
			width=newLayer["width"];
			jsonPoints["polyline"].length;
			positions=new Array();
			loadCollitionByLayer(jsonPoints);
		}
		
		public function loadCollitionByLayer(jsonPoints:Object):void{
			for each(var points:Object in jsonPoints["polyline"])
			{
				newpoint=new Point(points["x"],points["y"]);
				trace(newpoint);
				positions.push(newpoint);
			}
			
			}

	 public function get layer():Object
	 {
		 return _layer;
	 }

	 public function set layer(value:Object):void
	 {
		 _layer = value;
	 }



	 public function get positions():Array
	 {
		 return _positions;
	 }

	 public function set positions(value:Array):void
	 {
		 _positions = value;
	 }


	}
}