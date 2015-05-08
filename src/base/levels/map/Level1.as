package base.levels.map
{
	import base.levels.map.parts.Land;
	import base.levels.map.parts.PlaneLand;
	import base.levels.map.parts.UpSeparator;
	
	import core.General;
	
	import starling.events.Event;

	public class Level1 extends Map
	{
		private var myArray:Array = new Array();
		private var iniLandX:int = -200//-490;
		private var iniLandY:int = General.screenHeight - 550;
		private var distanceLandX:Number= 36;
		private var distanceLandY:Number = 16;
		
		private var iniSepUpX:int = iniLandX 
		private var iniSepUpY:int = iniLandY
		private var distanceSepUpX:Number= 40;
		private var distanceSepUpY:Number = 17.3;
		
		private var iniSepDownX:Number = iniLandX+ 120;
		private var iniSepDownY:Number = iniLandY + 156;
		
		public function Level1()
		{
			super("scene01.png");
			for(var i:uint = 0; i<120; i++){
				myArray[i] = i%2;//Math.floor(Math.random()*0);
			}
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.addLand(this.iniLandX,this.iniLandY);
			
			for(var i:uint = myArray.length; i>1; i--){
				this.iniLandX += this.distanceLandX;
				this.iniLandY -= this.distanceLandY;
				if(i%2){
					this.addLand(this.iniLandX ,this.iniLandY);		
				}else{
					this.addPlaneLand(this.iniLandX, this.iniLandY);	
				}
				
			}
			
			this.addChildAt(new UpSeparator(this.iniSepUpX,this.iniSepUpY), myArray.length);
			for(var j:uint = myArray.length; j> 0; j--){
				this.iniSepUpX += this.distanceSepUpX;
				this.iniSepUpY -= this.distanceSepUpY;
				this.iniSepDownX += this.distanceSepUpX;
				this.iniSepDownY -= this.distanceSepUpY;
				this.addBorders(this.iniSepUpX,this.iniSepUpY,this.iniSepDownX,this.iniSepDownY, i);	
			}
		}
		
		private function addBorders(xUp:Number, yUp:Number, xDown:Number, yDown:Number, zIndex:uint):void
		{
			this.addChildAt(new UpSeparator(xUp, yUp), zIndex);
			this.addChildAt(new UpSeparator(xDown, yDown), zIndex + 120);
		}
		
		private function addLand(x:Number, y:Number):void
		{
			this.addChild(new Land(x,y));
		}
		
		private function addPlaneLand(x:Number, y:Number):void{
			this.addChild(new PlaneLand(x,y));
		}
	}
}