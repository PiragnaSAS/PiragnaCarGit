package car.enemyCar
{
	import car.Car;

	public class BonusCar extends Taxi
	{

		private var bonusFuel:uint=25;
		
		public function BonusCar(pox:Number,poy:Number) 
		{
			super(pox,poy);
			/*this.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_bonus")));
			this.x=pox;
			this.y=poy;
			addChildAt(this.getCarImage(),0);
			this.react(Car.EST_MOVING);
			*/
		}
		
		override public function react(...args):void{
			switch(args[0])
			{
				case Car.EST_MOVING:
				{
					this.moving();
					break;
				}
				/*default:
				{
					break;
				}*/
			}
			}
		
		private function moving():void{
			this.setImage("moving_bonus_car_image");
			this.setState(Car.EST_MOVING);
		}
		
		public function getBonusFuel():uint{
			return bonusFuel;
		}
		public function setBonusFuel(newFuelvalue:uint):void{
			this.bonusFuel=newFuelvalue;
		}
	
	}
}