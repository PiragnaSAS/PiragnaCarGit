package collitionableObjects.superHeroes
{
	import base.levels.map.parts.PiragnaSprite;
	import base.levels.map.parts.Tiles;
	
	import core.General;
	
	import assets.Assets;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class SuperHero extends Sprite
	{
		private var superHeroImage:Image;
		private var _x:Number;
		private var _y:Number;
		private var _speed:Number;
		private var name:String;
		public function SuperHero(heroImageName:String,newX:Number,newY:Number){ 
			this.name=heroImageName;
			_x=newX;
			_y=newY;
			addChildAt(new PiragnaSprite(_x,_y,new Image(Assets.getAtlasTexture("Cars",heroImageName)),"hero"),0);
		}

		public function setSuperHeroImage(newImage:Image):void{
			this.superHeroImage=newImage;
		}
		
		public function getSuperHeroImage():Image{
			return this.superHeroImage;
		}
		public function update():void{
			var child:DisplayObject;
			if(getChildAt(0).y < General.screenHeight+200){
			child = getChildAt(0);
			child.x = getChildAt(0).x + 4;
			child.y = getChildAt(0).y -2.3;
			removeChildAt(0);
			addChild(child);
			//trace(getChildAt(0).x,getChildAt(0).y);
			}
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
