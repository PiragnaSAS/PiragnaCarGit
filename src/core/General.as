package core
{
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	import scene.Game;

	public final class General
	{
		public static const SCENE_GAME:String = getQualifiedClassName(scene.Game);
		//public static const SCENE_PRESENTATION:String = getQualifiedClassName(Presentation);
		//public static const SCENE_INTRODUCTION:String = getQualifiedClassName(Introduction);
		//public static const SCENE_GANE_TOAD:String = getQualifiedClassName(ToadGame);
		//public static const SCENE_RECORD:String = getQualifiedClassName(Record);
		//public static const SCENE_ALBUM:String = getQualifiedClassName(Album);
		
		public static var screenWidth:uint;
		public static var screenHeight:uint;
		public static var screenAspectRatio:Number;
		
		public static var viewPortBaseWidth:int;
		public static var viewPortBaseHeight:int;
		public static var viewPortBaseAspectRatio:Number;
		
		public static var viewPortBaseLimitWidth:int;
		public static var viewPortBaseLimiteHeight:int;
		
		public static var viewPort:Rectangle = new Rectangle();
		public static var viewPortGame:Rectangle = new Rectangle();
		public static var viewPortAspectRatio:Number;
		
		trace(">>> Initial time capture");
		public static const INITIAL_TIME:uint = (new Date().getTime()) - getTimer();
		public static function get fecha():uint { return INITIAL_TIME + getTimer(); }
		
		public function General() {}
		
		public static function calculateAspectRatioScreen():void
		{
			
			screenAspectRatio = screenHeight/screenWidth;
		}
		
		public static function calculateAspectRatioBase():void
		{
			viewPortBaseAspectRatio = viewPortBaseWidth/viewPortBaseHeight;
		}
		
		public static function calculateViewPort(method:uint):void
		{
			var moreHigh:Boolean = viewPortBaseAspectRatio < screenAspectRatio;
			
			switch(method)
			{
				case 0:
					if (moreHigh)
					{
						viewPort.width = screenHeight; 
						viewPort.height = int(screenWidth * viewPortBaseAspectRatio);
						viewPort.y = int((screenHeight - viewPort.height) / 2);
					}
					else
					{
						viewPort.width  = int(screenHeight / viewPortBaseAspectRatio);
						viewPort.height = screenHeight;
						viewPort.x = int((screenWidth - viewPort.width) / 2);
					}
					break;
				
				case 1:
					viewPort.width = screenWidth;
					viewPort.height = screenHeight;
					viewPort.x = 0;
					viewPort.y = 0;
					break;
				
				case 2:
					//con limite
					break;
			}
			viewPortAspectRatio = viewPort.height/viewPort.width;
		}
		
		public static function calculateViewPortGame():void
		{
			var masAlto:Boolean = viewPortBaseAspectRatio < viewPortAspectRatio;
			if (masAlto)
			{
				viewPortGame.width = viewPortBaseWidth; 
				viewPortGame.height = int(viewPortBaseWidth * viewPortAspectRatio);
				viewPortGame.y = 0;
			}
			else
			{
				viewPortGame.width  = int(viewPortBaseHeight / viewPortAspectRatio);
				viewPortGame.height = viewPortBaseHeight;
				viewPort.x = 0;
			}
		}
	}
}