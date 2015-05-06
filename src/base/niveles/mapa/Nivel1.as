package base.niveles.mapa
{
	import base.niveles.parts.Land;
	
	import starling.events.Event;

	public class Nivel1 extends Mapa
	{
		private var myArray:Array = new Array();
		
		
		public function Nivel1()
		{
			super();
			for(var i:uint = 0; i<120; i++){
				myArray[i] = i%2;//Math.floor(Math.random()*0);
			}
		}
		
		private function onAddedToStage(e:Event):void
		{
			for(var i:uint = 0; i<myArray.length; i++){
				
				this.addLand(0,0);
				this.addBorders();
			}
		}
		
		private function addBorders():void
		{
			
		}
		
		private function addLand(x:uint, y:uint):void
		{
			this.addChild(new Land(x,y));
		}
	}
}