package base.ia
{
	import base.levels.map.Map;
	
	import flash.display.Sprite;

	public class IAManager
	{
		private var context:Map;
		
		public function IAManager(contex)
		{
			this.context = contex;
		}
		
		private function checkCollision(layer:Sprite, hero:Sprite):void
		{
			//por el momento se va a comprobar la colisión entre los demás carros
			//y liego la colisión entre los demás carros con el heroe
			checkCollisionLayer(layer);
			checkCollisionHeroCar(layer,hero);
			
		}
		
		private function checkCollisionLayer(layer:Sprite):void
		{
			var numChildren:int = layer.numChildren;
			for(var i:uint = 0; i< numChildren; i++)
			{
				for(var j:uint = 0; j< numChildren; j++)
				{
					if ((i != j)&&((layer.getChildAt(i) as Sprite).hitTestObject(layer.getChildAt(j) as Sprite)))
					{
						//acá se debe manejar la colisión con base a nuestro contexto que es el mapa
							
					}
				}	
			}
		}
		
		private function checkCollisionHeroCar(layer:Sprite, hero:Sprite):void
		{
			var numChildren:int = layer.numChildren;
			for(var i:uint = 0; i< numChildren; i++)
			{
				if ((layer.getChildAt(i).hitTestObject(hero)))
				{
					//acá se debe manejar la colisión con base a nuestro contexto que es el mapa
				}
			}
		}
		
		//implementado pero no usado, se debe cambiar la lógica de las colisiones de acuerdo a la perspectiva
		private function collide(obj1:Sprite, obj2:Sprite):Boolean
		{
			//este método va a cambiar deacuerdo a la perspectiva, por ahora se utilizará este
			return obj1.hitTestObject(obj2);
		}
		
		public function update():Map
		{
			return this.context;
		}
		
		
	}
}