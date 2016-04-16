package  
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var mPlayer 			:Ship;
		private var mShotLag 			:Number;
		private var mShips				:FlxGroup;
		private var mBullets			:FlxGroup;
		private var mBackground			:Background;
		private var mHud				:Hud;
		private var mMultiplayer		:Multiplayer;
	
		override public function create():void {
			var i:int;
	
			mHud			= new Hud();
			mShips			= new FlxGroup();
			mBullets 		= new FlxGroup(Constants.BULLET_MAX);
			mBackground		= new Background();
			mMultiplayer	= new Multiplayer();
			mShotLag 		= 0;
			
			FlxG.worldBounds = new FlxRect(0, 0, Constants.WORLD_WIDTH, Constants.WORLD_HEIGHT);
			FlxG.camera.setBounds(0, 0, FlxG.worldBounds.width, FlxG.worldBounds.height);
			
			for (i = 0; i < Constants.BULLET_MAX; i++) {
				mBullets.add(new Bullet());
			}
			
			add(mBackground);
			add(mShips);
			add(mBullets);
			add(mHud);
			
			super.create();
		}
		
		public function onHitByBullet(theBullet :Bullet, theShip :Ship) :void {
			if(theBullet.owner != theShip.owner && !theShip.flickering && theShip.alive) {
				theShip.kill();
				handlePlayerKilled(theShip, theBullet.user_name);
			}
		}
		
		private function handlePlayerKilled(thePlayerShip :Ship, theOwner:String) :void {
			mMultiplayer.sendDie(thePlayerShip);
			mHud.showMessage("You were killed by "+theOwner+"!", "Respawn in N seconds", Constants.PLAYER_RESPAWN);
		}
		
		override public function update():void {
			super.update();
			
			mMultiplayer.update();
			
			if (mPlayer != null) {
				updatePlayerInput();
				FlxG.overlap(mBullets, mPlayer, onHitByBullet);
			}
		}
		
		public function updatePlayerInput():void {
			if (!mPlayer.alive) return;
			
			if (mShotLag >= 0) {
				mShotLag -= FlxG.elapsed;
			}
			
			if (FlxG.keys.pressed("SPACE") && mShotLag <= 0) {
				var aBulletType :Class = Bullet;
				
				shoot(mPlayer, aBulletType, true);
				mShotLag = Constants.PLAYER_SHOT_LAG;
			}
			
			if (FlxG.keys.pressed("UP") || FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("W") || FlxG.keys.pressed("S")) {
				var aSign :Number = FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("S") ? -1 : 1;
				
				mPlayer.x += mPlayer.direction.x * aSign;
				mPlayer.y += mPlayer.direction.y * aSign;
				
				if (mPlayer.x<0 || mPlayer.x>Constants.GAME_ORG_WIDTH-50)
					mPlayer.x -= mPlayer.direction.x * aSign;
				
				if (mPlayer.y<0 || mPlayer.y>Constants.GAME_ORG_HEIGHT-50)
					mPlayer.y -= mPlayer.direction.y * aSign;
			}
			
			if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A") || FlxG.keys.pressed("D")) {
				mPlayer.rotate(FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D") ? Constants.PLAYER_ROTATION : -Constants.PLAYER_ROTATION);
			}
			if (FlxG.keys.pressed("HOME")){
				mPlayer.x = 0;
			}
			if (FlxG.keys.pressed("END")){
				mPlayer.x = Constants.GAME_ORG_WIDTH-50;
			}
			if (FlxG.keys.pressed("PAGEUP")){
				mPlayer.y = 0;
			}
			if (FlxG.keys.pressed("PAGEDOWN")){
				mPlayer.y = Constants.GAME_ORG_HEIGHT-50;
			}
		}
		
		public function shoot(theShip :Ship, theBulletType :Class, theShouldSendMultiplayer :Boolean = false) :void {
			var aBullet :Bullet;

			aBullet  = (FlxG.state as PlayState).bullets.getFirstAvailable(theBulletType) as Bullet;
			
			if (aBullet) {
				aBullet.goFrom(theShip);
				
				if (theShouldSendMultiplayer) {
					mMultiplayer.sendShot(theShip, theBulletType);
				}
			}
		}
		
		override public function destroy():void {
			
			super.destroy();
		}
		
		public function get bullets() :FlxGroup { return mBullets; }
		public function get ships() :FlxGroup { return mShips; }
		public function get player() :Ship { return mPlayer; }
		public function get hud() :Hud { return mHud; }
		
		public function set player(v :Ship) :void { mPlayer = v; }
	}
}