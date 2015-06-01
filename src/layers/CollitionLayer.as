package layers
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	public class CollitionLayer extends Sprite
	{
		private var layer:Object;
		private var name:String;
		protected var visible:Boolean;
		protected var width:Number;
		protected var height:Number;
		private var linesArray:Array;
		private var _initialPositions:Array;
		private var _lineObject:Object;
		public function CollitionLayer(newLayer:Object){
			this.layer=newLayer;
			this.name=newLayer["name"];
			height=newLayer["height"];
			visible=newLayer["visible"];
			width=newLayer["width"];
			this.lineObject=this.layer["objects"];
			linesArray=new Array();
			trace(name);
			initialPositions=new Array();
			loadCollitionByLayer();
		}
		
		
		
		public function loadCollitionByLayer():void{
			
			var counter:uint=0;
			
			for each (var objects:Object in this.lineObject){
				counter++;
				linesArray.add= new Array();
				for each(var points:Object in objects["polyline"]){
					linesArray[counter-1]=new Point(points["y"]/Math.tan(Math.PI/6),(-1)*points["y"]);	
				}
				trace(objects["y"]/Math.tan(Math.PI/6),(-1)*objects["y"]);
				initialPositions[counter-1]=new Point(objects["y"]/Math.tan(Math.PI/6),(-1)*objects["y"]);

			}
			
			
			
		}
		public function get lineObject():Object
		{
			return _lineObject;
		}
		
		public function set lineObject(value:Object):void
		{
			_lineObject = value;
		}
		
		public function get initialPositions():Array
		{
			return _initialPositions;
		}
		
		public function set initialPositions(value:Array):void
		{
			_initialPositions = value;
		}
	}
}