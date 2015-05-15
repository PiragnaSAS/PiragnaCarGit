package layers
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class CollitionLayer extends Sprite
	{
	 private var _layer:Object;
	 private var _name:String;
	 protected var visible:Boolean;
	 protected var width:Number;
	 protected var height:Number;
	 private var _linesArray:Array;
	 private var _initialPositions:Array;
	 private var lineObject:Object;
	 public function CollitionLayer(newLayer:Object)
		{
			this.layer=newLayer;
			this.name=newLayer["name"];
			height=newLayer["height"];
			visible=newLayer["visible"];
			width=newLayer["width"];
			this.lineObject=this.layer["objects"];
			linesArray=new Array();
			initialPositions=new Array();
			loadCollitionByLayer();
			

		}
		
	 public function loadCollitionByLayer():void{
		 trace("entrando a las lineas");
		 var counter:uint=0;
		 for each (var objects:Object in this.lineObject){
			 counter++;
			 linesArray.add= new Array();
			 for each(var points:Object in objects["polyline"]){
				 linesArray[counter-1]=new Point(points["x"],points["y"]);	
			 }
			 initialPositions[counter-1]=new Point(objects["x"],objects["y"]);
		 }
		 trace(linesArray);
		 trace(initialPositions);
	 }
	 
	 
	 public function get initialPositions():Array
	 {
		 return _initialPositions;
	 }

	 public function set initialPositions(value:Array):void
	 {
		 _initialPositions = value;
	 }

	 public function get linesArray():Array
	 {
		 return _linesArray;
	 }

	 public function set linesArray(value:Array):void
	 {
		 _linesArray = value;
	 }

		

	 public function get layer():Object
	 {
		 return _layer;
	 }

	 public function set layer(value:Object):void
	 {
		 _layer = value;
	 }


	}
}