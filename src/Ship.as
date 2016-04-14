package  
{
	import org.flixel.*;
	
	public class Ship extends FlxSprite
	{
		private var mDirection 			:FlxPoint;
		private var mOwner				:String;
		private var mColor				:uint;
		private var mRespawnCount		:Number;
		private var mName				:FlxText;
		
		public function Ship(theOwner :String, theX :Number, theY :Number, theColor :uint, theName :String) {
			super(theX, theY);
			loadGraphic(Assets.SHIPS, true, false, 48, 49, true);
			
			mDirection 		= new FlxPoint(Constants.PLAYER_SPEED, Constants.PLAYER_SPEED);
			mOwner 			= theOwner;
			mColor 			= theColor;
			mRespawnCount	= Constants.PLAYER_RESPAWN;
			mName			= new FlxText(x, y, 60, theName);
			mName.color		= theColor != 0 ? theColor : 0xffffff;
			mName.alignment	= "center";
			frame 			= 0;
			
			if(theColor != 0) {
				color = theColor;
			}
			
			adjustRotationAccordingDirection();
		}
		
		override public function update():void {
			super.update();
			
			if (!alive) {
				mRespawnCount -= FlxG.elapsed;

				if (mRespawnCount <= 0) {
					mRespawnCount = Constants.PLAYER_RESPAWN;
					respawn();
					
					if (amIPlayerControlled()) {
						(FlxG.state as PlayState).hud.hideMessages();	
					}
				}
			}
			
			mName.x = x + width / 2 - mName.width / 2;
			mName.y = y + height + 5;
		}
		
		override public function draw():void {
			super.draw();
			mName.draw();
		}
		
		private function amIPlayerControlled() :Boolean {
			return owner == (FlxG.state as PlayState).player.owner;
		}
		
		public function rotate(theAngle :Number) :void {
			var aX :Number = mDirection.x;
			var aY :Number = mDirection.y;
				
			mDirection.x = aX * Math.cos(theAngle) - aY * Math.sin(theAngle);
			mDirection.y = aX * Math.sin(theAngle) + aY * Math.cos(theAngle);
				
			adjustRotationAccordingDirection();
		}
		
		public function respawn() :void {
			reset(x, y);
			visible = true;
			flicker(Constants.PLAYER_IMMUNIZATION);
		}
		
		private function adjustRotationAccordingDirection() :void {
			angle = 90 + (180 * getAngle(mDirection))/Math.PI;
		}
		
		public function getAngle(theVector :FlxPoint) :Number {
			return Math.atan2(theVector.y, theVector.x);
		}
		
		override public function kill():void {
			if (!alive) return;
			
			alive = false;
			visible = false;
		}
		
		public function get direction() :FlxPoint { return mDirection; }
		public function get owner() :String { return mOwner; }
		public function set owner(v :String) :void { mOwner = v; }
		public function get multiplayerColor() :uint { return mColor; }
		public function get respawnCount() :Number { return mRespawnCount; }
	}
}