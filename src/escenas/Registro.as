package escenas
{
	import flash.text.TextField;
	
	import core.General;
	
	import gui.BotonRedondoLabel;
	
	import memoria.MemoriaYaku;
	
	import recursos.Recursos;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Registro extends Sprite implements IEscena
	{
		private static const REGISTRO_NUEVO:uint = 0;
		private static const AUTO_REGISTRO:uint = 1;
		
		private var registroActual:uint;
		
		private var fondo:Image;
		private var contenedor:Sprite;
		private var marco:Image;
		private var campoNombre:Image;
		private var campoNombreEtiqueta:Image;
		private var txtImputNombre:TextField;
		private var campoCorreo:Image;
		private var campoCorreoEtiqueta:Image;
		private var txtImputCorreo:TextField;
		private var campoSeleccionEdad:Image;
		private var campoSeleccionGenero:Image;
		private var btnIniciarCecion:BotonRedondoLabel;
		private var btnRegistroNuevo:BotonRedondoLabel;
		private var btnSalir:BotonRedondoLabel;
		private var btnIniciar:BotonRedondoLabel;
		
		private var campoError:*;
		
		
		public function Registro()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			inicializar();
			if(MemoriaYaku.hayUsuarioRegistrado)
			{
				abrirAutoRegistro(MemoriaYaku.usuario.nombre, MemoriaYaku.usuario.correo);
			}
			else
			{
				abrirRegistroNuevo();
			}
		}
		
		private function inicializar():void
		{
			fondo = new Image(Recursos.obtenerTextura("Fondo2"));
			fondo.width = General.viewPortJuego.width;
			fondo.height = General.viewPortJuego.height;
			addChild(fondo);
			
			contenedor = new Sprite();
			contenedor.x = Math.floor(General.viewPortJuego.width/2);
			contenedor.y = Math.floor(General.viewPortJuego.height/2)-General.viewPortJuego.height;
			
			
		}
		
		private function abrirRegistro():void
		{
			
		}
		
		private function abrirAutoRegistro(nombre:String, correo:String):void
		{
			abrirRegistro();
			txtImputNombre.text = nombre;
			txtImputCorreo.text = correo;
		}
		
		private function abrirRegistroNuevo():void
		{
			
		}
		
		public function destruir():void
		{
		}
	}
}