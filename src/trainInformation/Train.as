package trainInformation
{
	import flash.geom.Matrix;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Train extends Sprite
	{
		
		private var trainImage:Image;
		private var fuel:TextField;
		private var score:TextField;
		private var speed:TextField;
		
		public function Train()
		{
//			trainImage=new Image(Assets.getTexture("trainInformation"));
//			trainImage.alignPivot("center","center");
//			trainImage.width=General.viewPortGame.width/25;
//			trainImage.height=General.viewPortGame.width/25;
//			trainImage.x=100;
//			trainImage.y=300;
//			addChild(trainImage);
			this.fuel= new TextField(100,20, "fuel: 0","RedCarGameFont",10,0xFFBD4A);
			this.score =new TextField(100,20,"score: 0","RedCarGameFont",10,0xFFBD4A);
			this.speed=new TextField(100,20,"speed: 0 Km/h","RedCarGameFont",10,0xFFBD4A);
			var mt:Matrix  = new Matrix(.86602783203125,-.5 ,0 ,1);
			this.fuel.transformationMatrix=mt;
			this.score.transformationMatrix=mt;
			this.speed.transformationMatrix=mt;
			this.fuel.x=10;
			this.fuel.y=300;
			this.score.x=120;
			this.score.y=300;
			this.speed.x=330;
			this.speed.y=300;
			addChild(this.fuel);
			addChild(this.score);
			addChild(this.speed);
		}
		
		public function updateTrain(fuel:Number,score:Number,speed:Number):void 
		{
			this.fuel.text=fuel.toString();
			this.score.text=score.toString();
			this.speed.text=Math.round(speed*35)+" Km/h";
		}
	}
}