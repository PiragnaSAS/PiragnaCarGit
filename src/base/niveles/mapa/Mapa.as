package base.niveles.mapa
{
	import layers.RaceLayer;
	import layers.CarsAndBorderLayer;
	import layers.ObjectsLayer;
	import layers.FrontObjectsLayer;
	import layers.GroundLayer;
	
	import starling.display.Sprite;

	public class Mapa extends Sprite
	{
		private var capaSuelo:GroundLayer;
		private var capaObjetos:ObjectsLayer;
		private var capaCarrera:RaceLayer;
		private var capaObjetosFrente:FrontObjectsLayer;
		private var capaCarrosYBorde:CarsAndBorderLayer;
		
		
		public function Mapa()
		{
			capaSuelo = new GroundLayer();
			capaObjetos = new ObjectsLayer();
			capaCarrera = new RaceLayer();
			capaObjetosFrente = new FrontObjectsLayer();
			capaCarrosYBorde = new CarsAndBorderLayer();
			
/*			var p1:Point =new Point();	
			var mt:Matrix = new Matrix();
			var p2:Point = mt.transformPoint(p1);
*/			
			addChild(capaSuelo);
			addChild(capaObjetos);
			addChild(capaCarrera);
			addChild(capaObjetosFrente);
			addChild(capaCarrosYBorde);			
		}
		
	}
}