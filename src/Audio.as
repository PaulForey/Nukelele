package
{
    import net.flashpunk.FP;
    import org.si.sion.*;
    import org.si.sion.utils.*;

    public class Audio
    {
        // Public variables:
        public static var tempo:int = 160;

        // Public Methods:
        public static function init():void
        {
            // 
        }

        public static function changeMusic(gameState:int):void
        {
            if(gameState == 0)
            {
                // change music to scary
            }
            else if(gameState == 1)
            {
                // change music to happy
            }
        }

        // Private Methods:

    }
}
