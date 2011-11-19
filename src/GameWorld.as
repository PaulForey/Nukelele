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
					spawn : int = 1,
					player: Player;

		public function GameWorld()
		{
            driver.setBeatCallbackInterval(1);
            driver.setTimerInterruption(1, onTimerInterrupt);

            Audio.init(driver);

			bullets = new Vector.<Bullet>();
			enemies = new Vector.<Enemy>();

            driver.play("t" + Audio.tempo.toString() + ";");

			player = new Player(320, 240);
			add(player);
		}

        public function get gameState():int {return currentGameState;}
		
		public function queueBullet(b:Bullet):void
		{
			bullets.push(b);
		}
		
		public function queueEnemy(e:Enemy):void
		{
			enemies.push(e);
		}
        private function setGameState(newState:int):void
        {
            if(currentGameState == newState)
                return;

            currentGameState = newState;
        }

        private function onTimerInterrupt():void
        {
			while (bullets.length) {
				var b:Bullet = bullets.pop();
                Audio.play("playerShot" + b.note.toString());
                add (b);
			}
			while (enemies.length) {
				add(enemies.pop());
			}
			this.getClass(Enemy, enemies);
			while (enemies.length) {
				(enemies.pop()).setFrame([0,1,2,2][beatCounter % 4]);
			}
			player.setFrame([0, 1, 2, 1][beatCounter % 4]);
			
            // Stuff to happen every 16 beats (should be at the start of one bar)
            if(gameState == 1 && (beatCounter % 8)==0)
            {
				var v : Vector.<Enemy> = new Vector.<Enemy>(),
					toShoot : int = Math.random() * 4;
				getClass(Enemy, v);
				while (v.length) {
					var e:Enemy = v.pop();
					if (e.note == toShoot) {
						//***play enemy shoot sound***
						e.shoot(player.x, player.y);
					}
				}
            }

            // Stuff to happen every 4 bars
            if(beatCounter % 64 == 0)
            {
                // stuff
                trace("every four bars!");
                if (gameState == 0) {
					for (var i:int = 0; i < spawn; i++)
						queueEnemy(new Enemy(int(Math.random() * 4)));
					Audio.play("enemySpawn");
                    setGameState(1);
					spawn += int(1.1*Math.random());
				}
                else if(gameState == 1)
                    setGameState(0);

                //Audio.changeMusic(currentGameState);
            }
            beatCounter++;
        }
	}
}
