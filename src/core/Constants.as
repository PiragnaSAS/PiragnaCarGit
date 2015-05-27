package core
{
	import flash.utils.getTimer;
	
	import base.scenes.RoadFighter;
	
	import starling.errors.AbstractClassError;

	public class Constants
	{
		public static const STAGE_WIDTH:int  = 480;
		public static const STAGE_HEIGHT:int = 320;
		
		public static const ASPECT_RATIO:Number = STAGE_HEIGHT / STAGE_WIDTH;
		
		// nombre de clase de esccenas
		public static const MAIN_SCENE:Class = RoadFighter;
		//public static const MAIN_SCENE:Class = Game_2;
		//
	/*	public static const SCN_MAIN_SCENE:String = getQualifiedClassName(MAIN_SCENE);
		public static const SCN_PRESENTATION:String = getQualifiedClassName(Presentation);
		public static const SCN_INTRODUCTION:String = getQualifiedClassName(Introduction);
		public static const SCN_REGISTRATION_FORM:String = getQualifiedClassName(RegistrationForm);
		public static const SCN_FROG_GAME:String = getQualifiedClassName(FrogGame);
		public static const SCN_ALBUM:String = getQualifiedClassName(AlbumScene);
		*/
		trace(">>> captura de tiempoInicial");
		public static const TIEMPO_INICIAL:uint = (new Date().getTime()) - getTimer();
		
		public static var premios:Array = new Array();
		
		
		public function Constants() { throw new AbstractClassError(); }
	}
}