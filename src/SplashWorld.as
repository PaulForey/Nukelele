package
{
    import net.flashpunk.graphics.Stamp;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class SplashWorld extends World
    {

        [Embed(source="assets/startScreen.png")] private const STARTSCREEN:Class;
        [Embed(source="assets/deathScreen.png")] private const DEATHSCREEN:Class;

        private var background:Stamp; 

        private var textBackground:Image;

        private var splashText:Text;

        private var isEnding:Boolean;

        public function SplashWorld(isEnding:Boolean = false):void
        {
            if(Main.driver.isPlaying)
                Main.driver.stop();

            this.isEnding = isEnding;

            if(isEnding)
            {
                background = new Stamp(DEATHSCREEN);
                addGraphic(background);

                splashText = new Text("You died!\nPress space to respawn.\nUnless you're a coward.", 320, 320);
                splashText.align = "center";
            }
            else
            {
                background = new Stamp(STARTSCREEN);
                addGraphic(background);

                splashText = new Text("Nukelele!\nPress space to start.\nArrows to move.\nA, S, D & F to fire.", 320, 160);
                splashText.color = 0x000000;
                splashText.width = 150;
                splashText.height = 200;
                splashText.align = "center";

                textBackground = Image.createRect(280, 90, 0xFFFFFF);
                textBackground.centerOrigin();
                textBackground.x = 320;
                textBackground.y = 90;
                addGraphic(textBackground);

            }

            splashText.wordWrap = true;
            splashText.centerOrigin();
            addGraphic(splashText);
        }

        public override function update():void
        {
            if(Input.pressed(Key.SPACE))
            {
                FP.world = new GameWorld();
            }
        }
    }
}
                

