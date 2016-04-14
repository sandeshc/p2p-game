package 
{
	import flash.events.Event;
	import flash.system.Capabilities;
	import org.flixel.*;

	[SWF(width="600", height="480", backgroundColor="#000000")]
	public class Game extends FlxGame 
	{
		public function Game(){
			super(Constants.BUFFER_WIDTH, Constants.BUFFER_HEIGHT, ActivationState, Constants.BUFFER_ZOOM);
			
			forceDebugger = true;
			FlxG.flashFramerate = 30;
			FlxG.framerate = 30;
			
			FlxG.mouse.show();
		}
		
		override protected function create(theEvent :Event):void {
            super.create(theEvent);
        }
	}
}