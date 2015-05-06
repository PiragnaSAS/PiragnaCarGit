package car.hero
{
	import car.Car;

	public class Hero extends Car{
		
		private var score:uint = 0;
		private var fuel:uint = 0;
		
		public function Hero(initialState:uint){
		
		}
		
		public function getScore():uint{
			return score;
		}
		
		public function raiseScore():void{
			score++;
		}
			
		public function getFuel():uint{
			return fuel;
		}
		
		public function raiseFuel(fuel:uint):void{
			this.fuel += fuel;
		}
		
		public function decreaseFuel(gasolina:uint):void{
			this.fuel -= gasolina;
		}
	}
}