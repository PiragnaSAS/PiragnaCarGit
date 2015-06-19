package car.enemyCar
{
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;

	public class BonusCar extends Car
	{

		private var bonusFuel:uint=35;
		private var isBonusTaken:Boolean = false;
		
		public function BonusCar(pox:Number,poy:Number) 
		{
			super(pox,poy, new Image(Assets.getAtlasTexture("Cars","car_bonus"))); 
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
	
		public function bonusTaken():Boolean
		{
			return this.isBonusTaken;
		}
		
		public function takeBonus():void
		{
			this.isBonusTaken = true;
		}
	}
}