package  
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		private var mOwner :String;
		private var muser : String;
		public function Bullet() {
			makeGraphic(2, 5, 0xffffffff);
			kill();
		}
		
		public function goFrom(theShip :Ship) :void {
			reset(theShip.x + theShip.width / 2, theShip.y + theShip.height / 2);
			
			velocity.x = theShip.direction.x * Constants.BULLET_SPEED;
			velocity.y = theShip.direction.y * Constants.BULLET_SPEED;
			
			angle = theShip.angle;
			owner = theShip.owner;
			user_name = theShip.name;
			if(theShip.multiplayerColor != 0) {
				color = theShip.multiplayerColor;
			}
		}
		
		override public function update():void {
			super.update();
			
			if (x < 0 || y < 0 || x > Constants.WORLD_WIDTH || y > Constants.WORLD_HEIGHT) {
				kill();
			}
		}
		
		public function get owner() :String { return mOwner; }
		public function get user_name(): String {return muser; }
		public function set owner(v :String) :void { mOwner = v; }
		public function set user_name(v :String) :void { muser = v; }
	}
}