package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class BlueCar extends Car
	{
		public function BlueCar(posx:Number,posy:Number)
		{
			super(posx,posy, new Image(Assets.getAtlasTexture("Cars","car_blue")));
			this.react(Car.EST_MOVING);	
		}
		
		private function moving():void{
			this.setImage("moving_blue_image");
			this.setState(Car.EST_MOVING);
		}
		
		private function exploding():void{
			this.setImage("exploding_blue_image");
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
				trace( "drift de azul");
				super.handleDrift();
			}
		}
	}
}