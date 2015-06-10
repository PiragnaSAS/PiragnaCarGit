package collitionableObjects.superHeroes
{
	
	import core.General;
	
	import layers.Layer;
	
	import assets.Assets;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Hulk extends Sprite
	{
		private var _x:Number;
		private var _y:Number;
		private var _name:String;
		private var _speed:Number;
		private var counter:Number;
		public function Hulk(newX:Number,newY:Number)
		{		
			_x=newX;
			_y=newY;
			var image:MovieClip=new MovieClip(Assets.getAtlasTextures("Cars","Hulk"));
			Starling.juggler.add(image);
			addChild(image);
			getChildAt(0).x=_x;
			getChildAt(0).y=_y;
		}
		
		public function update():void{
			this.getChildAt(0).x -= this.getSpeed()*Layer.factorx;
			this.getChildAt(0).y -= this.getSpeed()*Layer.factory;											
			var child:DisplayObject;
			if(getChildAt(0).x < -100 && getChildAt(0).y > General.screenHeight+200){		
				child = getChildAt(0);
				var randomNumber:Number= Math.random()*200+80;
				child.x = getChildAt(0).x + randomNumber;
				child.y = getChildAt(0).y - randomNumber*Math.tan(Math.PI/6);
				removeChildAt(0);
				addChild(child);					
			}	
		}
		
		public function getName():String{
			return name;
		}
		
		public function getSpeed():Number
		{
			return _speed;
		}
		
		public function setSpeed(value:Number):void
		{
			_speed = value;
		}
		
		
	}
}
