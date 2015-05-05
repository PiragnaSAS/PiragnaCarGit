package car.heroe
{
	import car.Carro;

	public class Heroe extends Carro{
		
		private var score:uint = 0;
		private var fuel:uint = 0;
		
		public function Heroe(){
		
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