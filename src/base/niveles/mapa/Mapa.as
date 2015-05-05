package base.niveles.mapa
{
	import layers.CapaCarrera;
	import layers.CapaCarrosYBorde;
	import layers.CapaObjetos;
	import layers.CapaObjetosFrente;
	import layers.CapaSuelo;
	
	import starling.display.Sprite;

	public class Mapa extends Sprite
	{
		private var capaSuelo:CapaSuelo;
		private var capaObjetos:CapaObjetos;
		private var capaCarrera:CapaCarrera;
		private var capaObjetosFrente:CapaObjetosFrente;
		private var capaCarrosYBorde:CapaCarrosYBorde;
		
		
		public function Mapa()
		{
			capaSuelo = new CapaSuelo();
			capaObjetos = new CapaObjetos();
			capaCarrera = new CapaCarrera();
			capaObjetosFrente = new CapaObjetosFrente();
			capaCarrosYBorde = new CapaCarrosYBorde();
			
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