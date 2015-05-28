package trainInformation
{
	import flash.geom.Matrix;
	
	import core.General;
	
	import resources.Resources;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Train extends Sprite
	{
		
		private var trainImage:Image;
		private var fuel:TextField;
		private var score:TextField;
		private var speed:TextField;
		
		public function Train(fuel:Number,score:Number,speed:Number)
		{
			trainImage=new Image(Resources.getTexture("trainInformation"));
			trainImage.alignPivot("center","center");
			trainImage.width=General.viewPortGame.width/25;
			trainImage.height=General.viewPortGame.width/25;
			trainImage.x=100;
			trainImage.y=300;
			addChild(trainImage);
			this.fuel= new TextField(100,20, ""+fuel,"",10);
			this.score =new TextField(100,20,""+score,"",10,10);
			this.speed=new TextField(100,20,""+speed,"",10,20);
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
	}
}