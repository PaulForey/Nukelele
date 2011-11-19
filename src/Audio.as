package
{
    import net.flashpunk.FP;
    import org.si.sion.*;
    import org.si.sion.utils.SiONPresetVoice;

    public class Audio
    {
        // Public variables:
        public static var tempo:int = 160;

        // Private variables:
        private static var driver:SiONDriver;

        private static var presetVoices:SiONPresetVoice = new SiONPresetVoice();
        
        private static var happyMML:String = new String();

        private static var sadMML:String = new String();

        private static var happyData:SiONData = new SiONData();

        private static var sadData:SiONData = new SiONData();

        // Public Methods:
        public static function init(thatDriver:SiONDriver):void
        {
            driver = thatDriver;

            happyMML =  "%6@1   v13 o3  $c4 r4 c4 r4;";                 // Kick pattern
            happyMML += "%6@2   v13 o3  $r4 c4 r4 c4;";                 // Snare pattern
            happyMML += "%6@3   v13 o3  $c4 c4 c4 c4;";                 // Closed hat pattern

            sadMML =    "%6@1   v13 o3  $c8 c8 r4 c8 c8 r4;";           // Kick pattern
            sadMML +=   "%6@2   v13 o3  $r4 c8 r16 c16 r4 c8 r16 c16;"; // Snare pattern
            sadMML +=   "%6@3   v13 o3  $[c8 c8 c8 c8];";               // Closed hat pattern

            happyData = driver.compile(happyMML);
            sadData = driver.compile(sadMML);

            var percusVoices:Array = presetVoices['valsound.percus'];
            happyData.setVoice(1, percusVoices[1]);
            happyData.setVoice(2, percusVoices[27]);
            happyData.setVoice(3, percusVoices[16]);

            sadData.setVoice(1, percusVoices[1]);
            sadData.setVoice(2, percusVoices[27]);
            sadData.setVoice(3, percusVoices[16]);
        }

        public static function changeMusic(gameState:int):void
        {
            if(gameState == 0)
            {
                // change music to scary
                stopAllDriverTracks();
                driver.sequenceOn(sadData);
            }
            else if(gameState == 1)
            {
                // change music to happy
                stopAllDriverTracks();
                driver.sequenceOn(happyData);
            }
        }

        // Private Methods:
        private static function stopAllDriverTracks():void
        {
            for(var i:int = 0; i < 64; i++)
            {
                driver.sequenceOff(i);
            }
        }
    }
}
