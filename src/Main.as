package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
    import net.flashpunk.utils.Key;
    import org.si.sion.*;
	/**
	 * ...
	 * @author Rob and Paul, dickhead
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{
        public static var driver:SiONDriver = new SiONDriver(),
						  currentScore: int = 0,
						  bestScore: int = 0;
		public function Main():void 
		{
			super(640, 480);
            Audio.init();
			FP.world = new GameWorld();
			FP.console.enable();
            FP.console.toggleKey = Key.T;
		}

	}
}
