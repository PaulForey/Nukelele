package  
{
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

		public function GameWorld()
		{
            driver.setBeatCallbackInterval(1);
            driver.setTimerInterruption(1, onTimerInterrupt);

            Audio.init();

            driver.play("t" + Audio.tempo.toString() + ";");

			add(new Player(320, 240));
		}

        public function get gameState():int {return currentGameState;}

        private function setGameState(newState:int):void
        {
            if(currentGameState == newState)
                return;

            currentGameState = newState;
        }

        private function onTimerInterrupt():void
        {
            //var beatIndex:int = beatCounter % 16;

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
                if(gameState == 0)
                    setGameState(1);
                else if(gameState == 1)
                    setGameState(0);

                Audio.changeMusic(gameState);
            }

            beatCounter++;
        }
	}

}
