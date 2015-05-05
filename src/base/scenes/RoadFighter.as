package base.scenes
{
	import base.ia.GestorIA;
	import base.niveles.mapa.Mapa;
	import base.niveles.mapa.Nivel1;
	
	import car.heroe.Heroe;
	
	import recursos.Recursos;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class RoadFighter extends Sprite
	{
		private var gestorIA:GestorIA;
		private var nivel:Mapa;
		private var hero:Heroe;
		
		private var speed:uint;
		
		public function RoadFighter()
		{
			this.nivel = new Nivel1();
			this.gestorIA = new GestorIA(this.nivel);
			this.hero = new Heroe();
			
			this.addChild(this.nivel);
		}
		
		private function onEnterFrame(e:Event):void
		{
			//hilo principal
			
			actualizarControles();
			actualizar();
			actualizarIA();
		}
		
		private function actualizarControles():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function actualizar()
		{
		
		}
		
		private function actualizarIA()
		{
			this.nivel = this.gestorIA.update();
		}
	}
}