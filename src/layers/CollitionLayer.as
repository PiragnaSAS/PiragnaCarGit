package layers
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class CollitionLayer extends Sprite
	{
	 private var _layer:Object;
	 private var _name:String;
	 private var _initialRigthPoint:Point;
	 private var _initialLeftPoint:Point;
	 private var _rigthPositions:Array;
	 private var _leftPositions:Array;
	 protected var visible:Boolean;
	 protected var width:Number;
	 protected var height:Number;
	 private var newLeftPoint:Point;
	 private var newRigthPoint:Point;
	 
	 private var newpoint:Point;
		public function CollitionLayer(newLayer:Object,jsonPoints:Object)
		{
			
			this.layer=newLayer;
			this.name=newLayer["name"];
			height=newLayer["height"];
			visible=newLayer["visible"];
			width=newLayer["width"];
			leftPositions=new Array();
			rigthPositions=new Array();
			loadCollitionByLayer(jsonPoints);
			initialRigthPoint=new Point(jsonPoints["rX"],jsonPoints["rY"]);
			initialLeftPoint=new Point(jsonPoints["lX"],jsonPoints["lY"]);
			trace(initialRigthPoint);
			trace(initialLeftPoint);
		}
		
		public function loadCollitionByLayer(jsonPoints:Object):void{
			
			for each(var leftpoints:Object in jsonPoints["leftPolyline"])
			{
				newLeftPoint=new Point(leftpoints["x"],leftpoints["y"]);
				trace(newLeftPoint);
				leftPositions.push(newLeftPoint);
			}
			
			for each(var rigthpoints:Object in jsonPoints["rightPolyline"])
			{
				newRigthPoint=new Point(rigthpoints["x"],rigthpoints["y"]);
				trace(newRigthPoint);
				rigthPositions.push(newLeftPoint);
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

	

	 public function get rigthPositions():Array
	 {
		 return _rigthPositions;
	 }

	 public function set rigthPositions(value:Array):void
	 {
		 _rigthPositions = value;
	 }

	 public function get leftPositions():Array
	 {
		 return _leftPositions;
	 }

	 public function set leftPositions(value:Array):void
	 {
		 _leftPositions = value;
	 }

	 public function get initialRigthPoint():Point
	 {
		 return _initialRigthPoint;
	 }

	 public function set initialRigthPoint(value:Point):void
	 {
		 _initialRigthPoint = value;
	 }

	 public function get initialLeftPoint():Point
	 {
		 return _initialLeftPoint;
	 }

	 public function set initialLeftPoint(value:Point):void
	 {
		 _initialLeftPoint = value;
	 }


	}
}