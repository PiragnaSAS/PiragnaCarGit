package
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class touchButtons extends Sprite
	{
		private var button:Button;
		private var command:String;
		
		public function touchButtons(command:String,buttonTexture:Texture){
			this.command=command;
			button=new Button(buttonTexture);
			button.addEventListener(Event.TRIGGERED,pressButton);
		}
		
		private function pressButton():void{
			dispatchEvent(new Event(command));
		}
		
	}
}