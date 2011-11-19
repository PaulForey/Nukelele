package  
{
	import flash.events.SecurityErrorEvent;
	import net.flashpunk.World;
    import org.si.sion.*;
	
	/**
	 * ...
	 * @author Rob
	 */
	public class GameWorld extends World 
	{
        private var driver:SiONDriver = new SiONDriver();

        private var currentGameState:int = 0;

        private var beatCounter:int = 0;

		private var bullets: Vector.<Bullet>,
					enemies : Vector.<Enemy>,
					spawn : int = 1;
		
		public function GameWorld()
		{
            driver.setBeatCallbackInterval(1);
            driver.setTimerInterruption(1, onTimerInterrupt);

            Audio.init(driver);

			bullets = new Vector.<Bullet>();
			enemies = new Vector.<Enemy>();

            driver.play("t" + Audio.tempo.toString() + ";");

			add(new Player(320, 240));
		}

        public function get gameState():int {return currentGameState;}
		
		public function queuebullet(x:Number, y:Number, angle:Number, note: int):void
		{
			bullets.push(new Bullet(x, y, angle, note))
		}
		
		public function queueenemy(note:int):void
		{
			enemies.push(new Enemy(note));
		}
        private function setGameState(newState:int):void
        {
            if(currentGameState == newState)
                return;

            currentGameState = newState;
        }

        private function onTimerInterrupt():void
        {
            //var beatIndex:int = beatCounter % 16;
			while (bullets.length) {
				add(bullets.pop());
				//***play sound here***
			}
			while (enemies.length) {
				add(enemies.pop());
			}

            // Stuff to happen every 16 beats (should be at the start of one bar)
            if(beatCounter % 16 == 0)
            {
                // stuff
                trace("every bar!");
            }

            // Stuff to happen every 4 bars
            if(beatCounter % 64 == 0)
            {
                // stuff
                trace("every four bars!");
                if (gameState == 0) {
					for (var i:int = 0; i < spawn; i++)
						queueenemy(int(Math.random() * 4));
					//***maybe play a spawn sound here***
                    setGameState(1);
					spawn++;
				}
                else if(gameState == 1)
                    setGameState(0);

                Audio.changeMusic(currentGameState);
            }
            beatCounter++;
        }
	}
}
