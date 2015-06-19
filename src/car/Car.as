package car
{
	import flash.geom.Point;
	
	import assets.Assets;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Car extends Sprite 
	{
		private var actualImage:String;
		private var actualState:uint;
		private var position:Point;
		private var carImage:DisplayObject;
		private var reactioned:Boolean;
		private var isActive:Boolean = true;
		
		private var _movementX:Number, _movementY:Number;
		private var _auxMovementX:Number, _auxMovementY:Number;
		
		public static const EST_MOVING:uint = 0;
		public static const EST_DRIFTING:uint = EST_MOVING + 1 ;
		public static const EST_UNCONTROLLABLE:uint =EST_DRIFTING + 1 ;
		public static const EST_EXPLODING:uint = EST_UNCONTROLLABLE + 1;
		public static const EST_REVIVING:uint = EST_EXPLODING + 1;
		public static const EST_DEFAULT:uint= EST_REVIVING +1;
		public static const EST_EXPLODED:uint= EST_DEFAULT +1;
		
		//vars to handle drifts
		private var driftDirection:Boolean; //0 left 1 right
		private var driftImpulse:Number;

		private var _speed:Number = 2;
		private var _saw:Boolean = false;
		private var _inside:Number=0; 
		
		
		private var timeAfterEnd:Number = 0;

		
		public function Car(posx:Number, posy:Number, image:DisplayObject){
			this.setCarImage(image);
			this.x=posx;
			this.y=posy;
			this.auxMovementX = this.movementX = 0;
			this.auxMovementY = this.movementY = 0;
			carImage.alignPivot();
			addChildAt(this.getCarImage(),0);
			this.reactioned = false;
		}
		
		public function finalMove():void{
			if(timeAfterEnd >= 1000){
			this.x += 2*Math.cos(-Math.PI/6);
			this.y += 2*Math.sin(-Math.PI/6);
			}else{
				timeAfterEnd+=10;
			}
		}	
		

		public function get auxMovementY():Number
		{
			return _auxMovementY;
		}

		public function set auxMovementY(value:Number):void
		{
			_auxMovementY = value;
		}

		public function get movementY():Number
		{
			return _movementY;
		}

		public function set movementY(value:Number):void
		{
			_movementY = value;
		}

		public function get auxMovementX():Number
		{
			return _auxMovementX;
		}

		public function set auxMovementX(value:Number):void
		{
			_auxMovementX = value;
		}

		public function get movementX():Number
		{
			return _movementX;
		}

		public function set movementX(value:Number):void
		{
			_movementX = value;
		}

		public function getInside():Number
		{
			return _inside;
		}

		public function setInside(value:Number):void
		{
			_inside = value;
		}

		public function get saw():Boolean
		{
			return _saw;
		}

		public function set saw(value:Boolean):void
		{
			_saw = value;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

		public function react(...args):void{
		}
		public function getState():uint{
			return actualState;
		}
		public function setState(newState:uint):void{
			actualState=newState;
		}
		public function getCarImage():DisplayObject{
			return carImage;
		}
		public function setCarImage(newImage:DisplayObject):void{
			this.carImage=newImage;
		}
		
		public function getImage():String{
			return actualImage;
		}
		
		public function setImage(newImage:String):void{
			actualImage=newImage;
		}
		
		public function setDriftImpulse(driftImpulse:Number):void{
			this.driftImpulse = driftImpulse;
		}
		
		public function getDriftImpulse():Number{
			return this.driftImpulse;
		}
		
		public function setDriftingDirection(driftingDirection:Boolean):void{
			this.driftDirection = driftingDirection;
		}
		
		public function getDriftingDirection():Boolean{
			return this.driftDirection;
		}
		
		public function handleDrift():void{
			if(!getDriftingDirection())
			{
				this.movementX = -driftImpulse;
				this.movementY = -driftImpulse*Math.tan(Math.PI/6);
				driftImpulse*=.3;
				if(driftImpulse<0.1){
					driftImpulse = 0;		
				}
				
				if(this.movementX != 0){
					this.auxMovementX = this.movementX;
					this.auxMovementY = movementY;
				}else{
					setState(Car.EST_DEFAULT);	
				}				
			}
			else
			{
				this.movementX = driftImpulse;
				this.movementY = driftImpulse*Math.tan(Math.PI/6);
				driftImpulse*=.3;
				
				if(driftImpulse<0.1){
					driftImpulse = 0;		
				}
				
				if(this.movementX != 0){
					this.auxMovementX = this.movementX;
					this.auxMovementY = movementY;
				}else{
					setState(Car.EST_DEFAULT);	
				}
				
			}
			
			this.x += auxMovementX;
			this.y += auxMovementY;
		}
		
		public function drift(driftImpulse:Number,driftDirection:Boolean):void{
			trace("a drift")
			this.driftDirection = driftDirection;
			this.driftImpulse = driftImpulse;
			this.setState(Car.EST_DRIFTING);	
		}
		
		public function update():void{
			if(this.getState() == Car.EST_DEFAULT)
			{
				if(movementX == 0){
					
					if(auxMovementX < .1 && auxMovementX > -.1){
						auxMovementX = 0;
						auxMovementY = 0;
					}else{
						auxMovementX *= .9;
						auxMovementY = auxMovementX*Math.tan(Math.PI/6);
					}
					
				}
				this.x += auxMovementX;
				this.y += auxMovementY;
			}
			if(this.getState() == Car.EST_DRIFTING){
				this.handleDrift();
			}

			if(this.getState() == Car.EST_EXPLODING){
				this.handleExplode();
			}
		}

		private function handleExplode():void
		{
			this.setState(Car.EST_EXPLODED);
			this.removeChildAt(0);
			var crashImage:MovieClip = new MovieClip(Assets.getAtlasTextures("Cars","boom"),24);
			crashImage.alignPivot();
			crashImage.loop = false;
			Starling.juggler.add(crashImage);
			crashImage.play();
			crashImage.addEventListener(Event.COMPLETE, function(){trace("some")});
			this.addChild(crashImage);
		}

		public function getReactioned():Boolean
		{
			return this.reactioned;
		}
		
		public function setReactioned(reactioned:Boolean):void
		{
			this.reactioned = reactioned;
		}
		
		public  function explode():void
		{
			this.setState(Car.EST_EXPLODING);	
		}
		
		public function getIsActive():Boolean
		{
			return this.isActive;
		}
		
		public function setIsActive(active:Boolean):void
		{
			 this.isActive = active;
		}

	}
}