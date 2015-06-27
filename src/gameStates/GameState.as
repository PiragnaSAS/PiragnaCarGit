package gameStates
{
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;

	public class GameState extends Sprite
	{
		private var name:String;
		
		public function GameState(name:String){
			this.name = name;
		}
		
		public function setName(name:String):void{
			this.name= name;
		}
		
		public function getName():String{
			return name;
		}
		
		public function update():void{
			throw new AbstractMethodError();
		}		
	}
}