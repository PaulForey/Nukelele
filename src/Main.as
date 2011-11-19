package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
    import org.si.sion.*;
	/**
	 * ...
	 * @author Rob and Paul, dickhead
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{
        public static var driver:SiONDriver = new SiONDriver();

		public function Main():void 
		{
			super(640, 480);
            Audio.init();
			FP.world = new GameWorld();
			FP.console.enable();
		}

	}
}
