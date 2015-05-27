package base.ia
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import base.levels.map.Level1;
	import base.levels.map.parts.PiragnaSprite;
	import car.Car;

	public class AIManager
	{
		private var context:Level1;
		private var  raceLayerRectangles:Array;
		
		public function AIManager(context:Level1)
		{
			this.context = context;
			this.raceLayerRectangles = new Array();
			this.generateRaceLayerRectangles();
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
		
		public function update():Level1
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			var hr:Car = this.context.getHero();
			var hPoint:Point = new Point(hr.x +102, hr.y +59);
			var tPoimt:Point = mt.transformPoint(hPoint);
			
			var tRectangle:Rectangle = new Rectangle(tPoimt.x,tPoimt.y, 31,18);	
			for each (var i:Rectangle in this.raceLayerRectangles) 
			{
				if(tRectangle.intersects(i))
				{
					//trace("choca",i.x ,i.y , "carro" ,tPoimt.x, tPoimt.y);
				}		
				else
				{
				
					//trace("no", i.x ,i.y , "carro" ,tPoimt.x, tPoimt.y);
				}
			}
			
			return this.context;
		}
		
		private function generateRaceLayerRectangles():void
		{
			var mt:Matrix = new Matrix(.7071212775140268,.7071212775140268 ,-1.2247888166255514 ,1.2247888166255514,50,50);
			if(this.context.getRaceLayer() != null)
			{
			
			
				var numChildRace:Number = this.context.getRaceLayer().numChildren;
				for (var i:int = 0; i < this.context.getRaceLayer().numChildren; i++) 
				{
					var tempPiragna:PiragnaSprite = PiragnaSprite(this.context.getRaceLayer().getChildAt(i));
					if(tempPiragna.getName() ==  "carretera_11" || tempPiragna.getName() ==  "carretera_12" || tempPiragna.getName() ==  "carretera_17" || tempPiragna.getName() ==  "carretera_16" || tempPiragna.getName() ==  "carretera_19")
					{
						var tPoint:Point = new Point(tempPiragna.x,tempPiragna.y);
						var tp_1:Point =  mt.transformPoint(tPoint);
						var tRectangle:Rectangle = new Rectangle((tp_1.x ) -60 ,
							(tp_1.y) - 105, 140,20);	
						this.raceLayerRectangles.push(tRectangle);
					}
				}
			}
		}
		
		public function getRectangles():Array
		{
			return this.raceLayerRectangles;
		}
		
		
	}
}