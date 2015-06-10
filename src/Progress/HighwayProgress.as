package Progress
{	
	import flash.geom.Matrix;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class HighwayProgress extends Sprite
	{
		private var highwayImage:Quad;
		
		public function HighwayProgress()
		{
			highwayImage=new Quad(231,12,0x000000);
			var mt:Matrix  = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,0,0);
			mt.invert();
			highwayImage.transformationMatrix = mt;
			highwayImage.x=-8;
			highwayImage.y=95;
			addChild(highwayImage);
		}
	}
}