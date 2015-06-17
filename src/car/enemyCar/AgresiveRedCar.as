package car.enemyCar
{

	
	import car.Car;
	

	public class AgresiveRedCar extends RedCar
	{
		public function AgresiveRedCar(pox:Number,poy:Number)
		{
			super(pox,poy);
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
				super.handleDrift();
			}
		}
	}
}