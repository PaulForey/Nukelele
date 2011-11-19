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


        // Sound effects:

        //[Embed(source="assets/sfx/enemy_spawn.mp3")] private static var enemySpawn:Sound;
        //[Embed(source="assets/sfx/enemy_die.mp3")] private static var enemyDie:Sound;

        //[Embed(source="assets/sfx/player_spawn.mp3")] private static var playerSpawn:Sound;
        //[Embed(source="assets/sfx/player_die.mp3")] private static var playerSpawn:Sound;

        //[Embed(source="assets/sfx/shot1")] private static var shot1:Sound;  // f
        //[Embed(source="assets/sfx/shot2")] private static var shot2:Sound;  // a
        //[Embed(source="assets/sfx/shot3")] private static var shot3:Sound;  // c
        //[Embed(source="assets/sfx/shot4")] private static var shot4:Sound;  // e


        // Public Methods:
        public static function init(thatDriver:SiONDriver):void
        {
            driver = thatDriver;

            happyMML =  "%6@1   v13 o3  $c4 r4 c4 r4;";                 // Kick pattern
            happyMML += "%6@2   v13 o3  $r4 c4 r4 c4;";                 // Snare pattern
            happyMML += "%6@3   v13 o3  $c4 c4 c4 c4;";                 // Closed hat pattern
            happyMML += "%6@5   v13 o4  $[f8 r8 c8 r8]7 f8 c8 f8 e8;";// Bass pattern

            sadMML =    "%6@1   v13 o3  $c8 c8 r4 c8 c8 r4;";           // Kick pattern
            sadMML +=   "%6@2   v13 o3  $r4 c8 r16 c16 r4 c8 r16 c16;"; // Snare pattern
            sadMML +=   "%6@4   v13 o3  $c8 c8 c8 c8;";                 // Open hat pattern
            sadMML +=   "%6@5   v13 o4  $[d8 r8>a8<r8]7 d8>a8<d8 e8;";// Bass pattern

            happyData = driver.compile(happyMML);
            sadData = driver.compile(sadMML);

            var percusVoices:Array = presetVoices['valsound.percus'];
            happyData.setVoice(1, percusVoices[1]);                 // Kick drum
            happyData.setVoice(2, percusVoices[27]);                // snare drum
            happyData.setVoice(3, percusVoices[15]);                // closed hat
            happyData.setVoice(4, percusVoices[16]);                // open hat
            happyData.setVoice(5, presetVoices['valsound.bass16']); // bass

            sadData.setVoice(1, percusVoices[1]);                   // Kick drum
            sadData.setVoice(2, percusVoices[27]);                  // snare drum
            sadData.setVoice(3, percusVoices[15]);                  // closed hat
            sadData.setVoice(4, percusVoices[16]);                  // open hat
            sadData.setVoice(5, presetVoices['valsound.bass16']);   // bass      
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
