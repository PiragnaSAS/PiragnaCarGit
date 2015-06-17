package car.enemyCar
{
	import flash.geom.Point;
	
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;
	public class AgresiveBlueCar extends BlueCar
	{
		
		public function AgresiveBlueCar(pox:Number,poy:Number)
		{
			super(pox,poy);
		}
		
		private function moving(heroPos:Point):void{
			this.setImage("moving_agresive_blue_image");
			this.setState(Car.EST_MOVING);
			
		}
		
		private function exploding():void{
			this.setImage("exploding_agresive_blue_image");
			this.setState(Car.EST_EXPLODING);
		}
		
		override public function update():void{
			if(this.getState() == Car.EST_DEFAULT)
			{
				if(movementX == 0){
					
					if(auxMovementX < .1 && auxMovementX > -.1){
						auxMovementX = 0;
						auxMovementY = 0;
					}else{
						auxMovementX *= .9;
						auxMovementY = auxMovementX*Math.tan(Math.PI/6);
					}
					
				}
				this.x += auxMovementX;
				this.y += auxMovementY;
			}
			if(this.getState() == Car.EST_DRIFTING){
				trace( "drift de azul agresivo");
				super.handleDrift();
			}
		}
	}
}