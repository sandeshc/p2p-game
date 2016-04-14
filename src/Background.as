package  
{
	import org.flixel.*;

	public class Background extends FlxGroup
	{
		public function Background() {
			var aBackground :FlxSprite = new FlxSprite(0, 0, Assets.BACKGROUND);
			
			var aRows :int = Constants.WORLD_HEIGHT / aBackground.height;
			var aCols :int = Constants.WORLD_WIDTH / aBackground.width;
			
			for (var i:int = 0; i < aRows; i++) {
				for (var j:int = 0; j < aCols; j++) {
					add(new FlxSprite(j * aBackground.width, i * aBackground.height, Assets.BACKGROUND));
				}
			}
		}
	}
}