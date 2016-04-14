package  
{
	import org.flixel.*;
	
	public class Hud extends FlxGroup
	{
		private var mHeadline 	:FlxText;
		private var mSub 		:FlxText;
		private var mTotal 		:FlxText;
		
		public function Hud() {
			mHeadline = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "");
			mHeadline.alignment = "center";
			mHeadline.size = 28;
			mHeadline.scrollFactor.x = 0;
			mHeadline.scrollFactor.y = 0;

			mSub = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "");
			mSub.alignment = "center";
			mSub.size = 12;
			mSub.scrollFactor.x = 0;
			mSub.scrollFactor.y = 0;
			
			mTotal = new FlxText(FlxG.width - 90, 5, 80, "Players: 0");
			mTotal.alignment = "right";
			mTotal.scrollFactor.x = 0;
			mTotal.scrollFactor.y = 0;

			hideMessages();
			
			add(mHeadline);
			add(mSub);
			add(mTotal);
		}
		
		public function showMessage(theHeadline :String, theSub :String, theSubFlickerTime :Number = 0.1) :void {
			mHeadline.visible = true;
			mSub.visible = true;
			mHeadline.text = theHeadline;
			mSub.text = theSub;
			
			mSub.flicker(theSubFlickerTime);
		}
		
		public function hideMessages() :void {
			mHeadline.visible = false;
			mSub.visible = false;
		}
		
		public function updatePlayersCount(theAmount :int) :void {
			mTotal.text = "Players: " + theAmount;
			mTotal.flicker(0.5);
		}
		
		override public function update():void {
			super.update();
			
			var aPlayer :Ship = (FlxG.state as PlayState).player;
			
			if (aPlayer != null && !aPlayer.alive) {
				mSub.text = "Respawn in " + (FlxG.state as PlayState).player.respawnCount.toFixed(1) + " seconds";
			}
		}
	}
}