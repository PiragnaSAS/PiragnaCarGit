package car.enemyCar
{
	import car.Car;
	
	import starling.display.Image;

	public class BonusCar extends Taxi
	{
		private var actualBonusCarImage:String;
		
		private var bonusFuel:uint=25;
		
		public function BonusCar(initialState:uint) 
		{
			this.react(initialState);
		}
		
		override public function react(...args):void{
			switch(args[0])
			{
				case Car.EST_MOVING:
				{
					this.moving();
					break;
				}
				/*case Car.EST_EXPLODING:	
				{
					this.exploding();
					break;
				}*/
				
				/*default:
				{
					break;
				}*/
			}
			}
		
		private function moving():void{
			this.actualBonusCarImage="moving_bonus_car_image";
			
		}
		/*
		private function exploding(hero:Car):void{
			this.actualBonusCarImage="exploding_bonus_car_image";

		}*/
		
		public function getBonusFuel():uint{
			return bonusFuel;
		}
		public function setBonusFuel(newFuelvalue:uint):void{
			this.bonusFuel=newFuelvalue;
		}
	
	}
}