package base.levels.map
{
	import core.General;
	
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Loser extends Sprite
	{
		private var textArea1:TextField;
		private var textArea2:TextField;
		public function Loser()
		{
			textArea1=new TextField(200,50,"congratulations??","RedCarGameFont",20,0xFFBD4A);
			textArea2=new TextField(200,50,"you have been lost your whole time","RedCarGameFont",20,0xFFBD4A);
			textArea1.alignPivot("center","center");
			textArea1.x=General.viewPortGame.width/2;
			textArea1.y=General.viewPortGame.height/2;
			textArea2.alignPivot("center","center");
			textArea2.x=General.viewPortGame.width/2;
			textArea2.y=General.viewPortGame.height/2+50;
			addChild(textArea1);
			addChild(textArea2);
		}
	}
}