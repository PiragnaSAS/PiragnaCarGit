package car.enemyCar
{
	import flash.geom.Point;
	
	import assets.Assets;
	
	import car.Car;
	
	import starling.display.Image;
	public class AgresiveBlueCar extends BlueCar
	{
		
		public function AgresiveBlueCar(pox:Number,poy:Number)
		{
			super(pox,poy);
			/*this.setCarImage(new Image(Assets.getAtlasTexture("Cars","car_blue")));
			this.x=pox;
			this.y=poy;
			addChildAt(this.getCarImage(),0);
			this.react(Car.EST_MOVING);*/
		}
		override public function react(...args):void{
			switch(args[0])
			{
				case Car.EST_MOVING:
				{
					this.moving(args[1]);
					break;
				}
				case Car.EST_EXPLODING:
				{
					this.exploding();
					break;
				}case Car.EST_DRIFTING:
				{
					this.drifting(args[1]);
					break;
				}	
					/*default:
					{
					break;
					}*/
			}
		}
		
		private function moving(heroPos:Point):void{
			this.setImage("moving_agresive_blue_image");
			this.setState(Car.EST_MOVING);
			
		}
		
		private function exploding():void{
			this.setImage("exploding_agresive_blue_image");
			this.setState(Car.EST_EXPLODING);
		}
		
		private function drifting(direction:String):void
		{
			switch(direction)
			{
				case "left":
				{
					this.setImage("drifting_left_agresive_blue_image")
				}
				case "rigth":
				{
					this.setImage("drifting_right_agresive_blue_image")
				}
			}
			this.setState(Car.EST_DRIFTING);
		}
		
		
	}
}