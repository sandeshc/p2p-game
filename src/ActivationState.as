package  
{
	import org.flixel.*;

	public class ActivationState extends FlxState
	{
		private var mHeadline 	:FlxText;
		private var mSub 		:FlxText;
		
		public function ActivationState() {
			mHeadline = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "Waiting");
			mHeadline.alignment = "center";
			mHeadline.size = 28;
			mHeadline.scrollFactor.x = 0;
			mHeadline.scrollFactor.y = 0;

			mSub = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Click anywhere or press any key to start the game.");
			mSub.alignment = "center";
			mSub.size = 12;
			mSub.scrollFactor.x = 0;
			mSub.scrollFactor.y = 0;
			
			add(new Background());
			add(mHeadline);
			add(mSub);
		}
		
		override public function update():void {
			super.update();
			
			if (FlxG.mouse.pressed() || FlxG.keys.any()) {
				FlxG.switchState(new PlayState());
			}
		}
	}
}