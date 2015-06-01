package scene
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	
	import core.General;
	
	import events.EventScene;
	
	import assets.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Presentation extends Sprite implements IScene
	{
		private var fondo2:Image;
		private var fondo:Image;
		private var logos:Image;
		private var logoP:Image;
		
		public function Presentation()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//inicializar
			fondo2 = new Image(Assets.obtenerTextura("Fondo2"));
			fondo2.width = General.viewPortJuego.width;
			fondo2.height = General.viewPortJuego.height;
			addChild(fondo2);
			
			fondo =  new Image(Assets.obtenerTextura("Fondo1"));
			fondo.width = General.viewPortJuego.width;
			fondo.height = General.viewPortJuego.height;
			addChild(fondo);
			
			logos = new Image(Assets.obtenerTexturaDeAtlas("Logos","logos patrocinadores"));
			logos.alignPivot();
			logos.alpha = 0;
			logos.x = Math.ceil(General.viewPortJuego.width/2);
			logos.y = Math.ceil(General.viewPortJuego.height/2);
			addChild(logos);
			
			logoP = new Image(Assets.obtenerTexturaDeAtlas("Logos","logos desarrolladores"));
			//logoP.alpha = 0;
			logoP.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			logoP.x = Math.ceil(General.viewPortJuego.width/2);
			logoP.y = General.viewPortJuego.height+logoP.height;
			addChild(logoP);
			
			TweenLite.to(logos, .7, {alpha:1, ease:Cubic.easeInOut, delay:0});
			TweenLite.to(logoP, .4, {y:General.viewPortJuego.height, ease:Cubic.easeOut, delay:.9});
			TweenLite.to(logos, .8, {alpha:0, ease:Cubic.easeInOut, delay:3.4});
			TweenLite.to(fondo, .3, {alpha:0, ease:Cubic.easeInOut, delay:3.8});
			TweenLite.to(logoP, .4, {y:General.viewPortJuego.height+logoP.height+10, ease:Cubic.easeIn, delay:3.9, onComplete:onComplete});
			
			function onComplete():void
			{
				destruir();
				
				dispatchEvent(new EventScene(EventScene.CAMBIO_DE_ESCENA, General.ESCENA_REGISTRO));
			}
		}
		
		public function destruir():void
		{
			//
		}
	}
}