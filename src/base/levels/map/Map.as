package base.levels.map
{
	import layers.RaceLayer;
	import layers.CarsAndBorderLayer;
	import layers.ObjectsLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	
	import starling.display.Sprite;

	public class Map extends Sprite
	{
		private var groundLayer:GroundLayer;
		private var objectsLayer:ObjectsLayer;
		private var raceLayer:RaceLayer;
		private var frontObjectsLayer:FrontObjectsLayer;
		private var carsAndBorderLayer:CarsAndBorderLayer;
		
		
		public function Map()
		{
			groundLayer = new GroundLayer();
			objectsLayer = new ObjectsLayer();
			raceLayer = new RaceLayer();
			frontObjectsLayer = new FrontObjectsLayer();
			carsAndBorderLayer = new CarsAndBorderLayer();
			
/*			var p1:Point =new Point();	
			var mt:Matrix = new Matrix();
			var p2:Point = mt.transformPoint(p1);
*/			
			addChild(groundLayer);
			addChild(objectsLayer);
			addChild(raceLayer);
			addChild(frontObjectsLayer);
			addChild(carsAndBorderLayer);			
		}
		
	}
}