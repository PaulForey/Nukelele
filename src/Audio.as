package
{
    import net.flashpunk.Sfx;
    import com.increpare.bfxr.Bfxr;
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
        private static const enemySpawnData:String = "1,0.5,0.0003,0.01,0.0679,0.495,0.75,0.615,,0.1074,-0.4496,0.4769,0.385,0.7683,0.7888,0.9061,0.2067,0.109,0.4457,0.4055,0.0509,-0.9254,0.7634,-0.468,-0.7258,0.9287,0.9537,0.9086,,0.3049,0.0897,-0.4947,0.05"
        private static const enemyDieData:String = "1,0.5,0.1,0.01,0.084,0.815,0.5847,0.186,,0.1684,,0.2062,0.5859,0.272,0.4682,0.3516,-0.5873,0.4615,0.1054,0.5078,0.0775,-0.0314,0.2399,-0.9011,-0.1715,0.9193,0.2426,0.0513,0.0092,0.6699,,-0.617,0.05";

        private static var enemySpawn:Bfxr = new Bfxr();
        private static var enemyDie:Bfxr = new Bfxr();

        private static const enemyShot0:Array = new Array(65, presetVoices['lead16'], 2);
        private static const enemyShot1:Array = new Array(69, presetVoices['lead16'], 2);
        private static const enemyShot2:Array = new Array(72, presetVoices['lead16'], 2);
        private static const enemyShot3:Array = new Array(76, presetVoices['lead16'], 2);

        [Embed(source="assets/sfx/playerSpawn.mp3")] private static const SFX_PLAYERSPAWN:Class;
        [Embed(source="assets/sfx/playerDie.mp3")] private static const SFX_PLAYERDIE:Class;

        [Embed(source="assets/sfx/playerShot0.mp3")] private static const SFX_PLAYERSHOT0:Class;  // f
        [Embed(source="assets/sfx/playerShot1.mp3")] private static const SFX_PLAYERSHOT1:Class;  // a
        [Embed(source="assets/sfx/playerShot2.mp3")] private static const SFX_PLAYERSHOT2:Class;  // c
        [Embed(source="assets/sfx/playerShot3.mp3")] private static const SFX_PLAYERSHOT3:Class;  // e

        private static var playerSpawn:Sfx = new Sfx(SFX_PLAYERSPAWN);
        private static var playerDie:Sfx = new Sfx(SFX_PLAYERDIE);

        private static var playerShot0:Sfx = new Sfx(SFX_PLAYERSHOT0);
        private static var playerShot1:Sfx = new Sfx(SFX_PLAYERSHOT1);
        private static var playerShot2:Sfx = new Sfx(SFX_PLAYERSHOT2);
        private static var playerShot3:Sfx = new Sfx(SFX_PLAYERSHOT3);

        // Public Methods:
        public static function init():void
        {
            enemySpawn.Load(enemySpawnData);
            enemySpawn.Cache();

            enemyDie.Load(enemyDieData);
            enemyDie.Cache();

            driver = Main.driver;

            happyMML =  "%6@1   v15 o3  $c4 c4 c4 c4;";                 // Kick pattern
            happyMML += "%6@2   v16 o3  $r8 c8 r8 c8;";                 // Snare pattern
            happyMML += "%6@2   v4  o3  $c16 c16 r16 c16;";             // Second Snare pattern
            happyMML += "%6@3   v13 o3  $c4 c4 c4 c4;";                 // Closed hat pattern
            happyMML += "%6@5   v15 o4  $[f8 r8 c8 r8]7 f8 c8 f8 e8;";  // Bass pattern

            sadMML =    "%6@1   v12 o3  $c4 r4 r8 c8 r4;";           // Kick pattern
            sadMML +=   "%6@2   v15 o3  $r4 c8 r16 c16 r4 c4;"; // Snare pattern
            sadMML +=   "%6@4   v13 o3  $c8 c8 c8 c8;";                 // Open hat pattern
            sadMML +=   "%6@5   v9  o2  $[d8 r8>a8<r8]7 d8>a8<d8 e8;";  // Bass pattern

            happyData = driver.compile(happyMML);
            sadData = driver.compile(sadMML);

            var percusVoices:Array = presetVoices['valsound.percus'];
            happyData.setVoice(1, percusVoices[1]);                 // Kick drum
            happyData.setVoice(2, percusVoices[27]);                // snare drum
            happyData.setVoice(3, percusVoices[15]);                // closed hat
            happyData.setVoice(4, percusVoices[16]);                // open hat
            happyData.setVoice(5, presetVoices['valsound.bass16']); // bass

            sadData.setVoice(1, percusVoices[2]);                   // Kick drum
            sadData.setVoice(2, percusVoices[28]);                  // snare drum
            sadData.setVoice(3, percusVoices[15]);                  // closed hat
            sadData.setVoice(4, percusVoices[16]);                  // open hat
            sadData.setVoice(5, presetVoices['valsound.lead31']);   // bass      
        }

        public static function play (sound:String):void
        {
            var thisSound:Object = Audio[sound];
            if(thisSound is Bfxr)
                thisSound.Play(0.3);
            else if (thisSound is Array)
                driver.noteOn(thisSound[0], thisSound[1], thisSound[2]);
            else
                thisSound.play();
        }

        public static function changeMusic(gameState:int):void
        {
            if(gameState == 0)
            {
                stopAllDriverTracks();
                driver.sequenceOn(happyData);
            }
            else if(gameState == 1)
            {
                stopAllDriverTracks();
                driver.sequenceOn(sadData);
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
