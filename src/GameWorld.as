package  
{
	import flash.events.SecurityErrorEvent;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;
    import org.si.sion.*;
	/**
	 * ...
	 * @author Rob
	 */
	public class GameWorld extends World 
	{
        [Embed(source="assets/background.png")] private const BACKGROUND:Class;
        private var background:Spritemap;

        private var driver:SiONDriver;

        private var currentGameState:int = 0;

        private var beatCounter:int = 0;

		private var bullets: Vector.<Bullet>,
					enemies : Vector.<Enemy>,
					spawn : int = 1,
					player: Player,
					order: Array = [],
					current: Text,
					best: Text;

		public function GameWorld()
		{
            background = new Spritemap(BACKGROUND, 640, 480);
            background.setFrame(0);
            addGraphic(background);
            driver = Main.driver;

            driver.setBeatCallbackInterval(1);
            driver.setTimerInterruption(1, onTimerInterrupt);

			bullets = new Vector.<Bullet>();
			enemies = new Vector.<Enemy>();

            driver.play();

			player = new Player(320, 240);
			add(player);
            Audio.play("playerSpawn");
			current = new Text("current score = " + Main.currentScore.toString(), 160, 450);
			best = new Text("best score = " + Main.bestScore.toString(), 480, 450);
			addGraphic(current);
			addGraphic(best);
		}

        public function get gameState():int {return currentGameState;}
		
        private function setGameState(newState:int):void
        {
            if(currentGameState == newState)
                return;

            currentGameState = newState;
        }

		public function queueBullet(b:Bullet):void
		{
			bullets.push(b);
		}
		
		public function queueEnemy(e:Enemy):void
		{
			enemies.push(e);
		}

        private function onTimerInterrupt():void
        {
            var enemyShotFired:Boolean = false;

			while (bullets.length) {
				var b:Bullet = bullets.pop();
                if(b.owner == 0)
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
                    background.setFrame(0);
					spawn += int(1.1 * Math.random());
					order = [0, 1, 2, 3];
				}
                else if(gameState == 1)
                {
                    setGameState(0);
                    background.setFrame(1);
                }

                Audio.changeMusic(currentGameState);
            }
			if (beatCounter % 4)
				Main.currentScore++;
            // Stuff to happen every 16 beats (should be at the start of one bar)
            if(gameState == 1)
            {
				if((beatCounter % 16)==0){
					var v : Vector.<Enemy> = new Vector.<Enemy>(),
						a : Array = order.splice(Math.random() * order.length, 1),
						toShoot : int;
					toShoot = a[i];
					trace(toShoot);
					getClass(Enemy, v);
					
					while (v.length) {
						var e:Enemy = v.pop();
						if (e.note == toShoot) {
							if (!enemyShotFired)
							{
								Audio.play("enemyShot" + e.note.toString());
								enemyShotFired = true;
							}
							e.shoot(player.x, player.y);
						}
					}
				}
				else{
					v = new Vector.<Enemy>();
					getClass(Enemy, v);
					trace(v.length);
					if (Math.random() < 0.04 && v.length) {
						e = v[int(v.length * Math.random())];
						e.shoot(player.x, player.y);
						Audio.play("enemyShot" + e.note.toString());
					}
				}
            }

            beatCounter++;
        }
	}
}
