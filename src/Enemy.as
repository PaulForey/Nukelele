package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Rob
	 */
	public class Enemy extends Entity 
	{
		[Embed(source = "assets/enemy.png")] private const ENEMY:Class;
		public var note: int;
		private var onscreen: Boolean = false,
					sprite: Spritemap,
					time : Number,
					xfreq : Number,
					yfreq : Number;

		public function Enemy(note: int)
		{
			sprite = new Spritemap(ENEMY, 32, 32);
			sprite.alpha = 0;
			xfreq = 0.005 + Math.random() / 150;
			yfreq = 0.005 + Math.random() / 100;
			super(288 + 288 * Math.sin(time * xfreq), 120 + 120 * Math.sin(time * yfreq), sprite);
			FP.tween(sprite, { alpha: 1 }, 0.1, { complete: function():void{ onscreen = true; } } );
			this.note = note;
			setHitbox(16, 16, -8, -8);
			time = 0;
		}
		
		public function shoot(px: Number, py: Number): void
		{
			(world as GameWorld).queueBullet(new Bullet(x, y, Math.atan2(px - x + 16, y + 32 - py) + Math.random() * 0.1, note, 1));
		}
		
		public override function update(): void
		{
			if (onscreen) {
				//do update stuff
				var bul:Bullet = collide("bullet", x, y) as Bullet;
				if (bul) {
					if (bul.note == note && bul.owner!=1){
                        Audio.play("enemyDie");
						world.remove(this);
						world.remove(bul);
						//particles
					}
				}
			}
			x = 288 + 288 * Math.sin(time * xfreq);
			y = 120 + 120 * Math.sin(time * yfreq);
			time++;
		}

        public function setFrame(frame:int):void
        {
            sprite.frame = frame;
        }
	}
}
