package car
{
	import flash.geom.Point;
	
	import collitionableObjects.Padrino;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;

	public class Car extends Sprite 
	{
		private var actualImage:String;
		private var actualState:uint;
		private var position:Point;
		private var carImage:DisplayObject;
		
		private var _movementX:Number, _movementY:Number;
		private var _auxMovementX:Number, _auxMovementY:Number;
		
		public static const EST_MOVING:uint = 0;
		public static const EST_DRIFTING:uint = EST_MOVING + 1 ;
		public static const EST_UNCONTROLLABLE:uint =EST_DRIFTING + 1 ;
		public static const EST_EXPLODING:uint = EST_UNCONTROLLABLE + 1;
		public static const EST_REVIVING:uint = EST_EXPLODING + 1;
		public static const EST_DEFAULT:uint= EST_REVIVING +1;
		
		//vars to handle drifts
		private var driftDirection:Boolean; //0 left 1 right
		private var driftImpulse:Number;
		
		private var _speed:Number = 4;
		private var _saw:Boolean = false;
		private var _inside:Number=0;
		public function Car(posx:Number, posy:Number, image:DisplayObject){
			this.setCarImage(image);
			this.x=posx;
			this.y=posy;
			this.auxMovementX = this.movementX = 0;
			this.auxMovementY = this.movementY = 0;
			carImage.alignPivot();
			addChildAt(this.getCarImage(),0);
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
			throw new AbstractMethodError();	
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

		public function update():void{
			throw new AbstractMethodError();
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
				driftImpulse*=.7;
				trace("it's coming left", this.movementX, this.movementY );
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
				trace("it's coming right", this.movementX, this.movementY );
				this.movementX = driftImpulse;
				this.movementY = driftImpulse*Math.tan(Math.PI/6);
				driftImpulse*=.7;
				
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
			this.driftDirection = driftDirection;
			this.driftImpulse = driftImpulse;
			
			trace("kajsdlasjdlkasjdljasdlkjsadjasldjaslkjdlksajda");
			setState(Car.EST_DRIFTING);	
		}
	}
}