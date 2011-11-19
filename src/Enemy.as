package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Rob
	 */
	public class Enemy extends Entity 
	{
		[Embed(source = "assets/enemy.png")] private const ENEMY:Class;
		private var onscreen: Boolean = false,
					sprite: Image,
					note : int,
					time : Number,
					xphase : Number,
					yphase : Number;
		public function Enemy(note: int)
		{
			sprite = new Image(ENEMY);
			sprite.alpha = 0;
			xphase = 0.01 + Math.random() / 40;
			yphase = 0.01 + Math.random() / 20;
			super(288 + 288 * Math.sin(time * xphase), 120 + 120 * Math.sin(time * yphase), sprite);
			FP.tween(sprite, { alpha: 1 }, 0.1, { complete: function():void{ onscreen = true; } } );
			this.note = note;
			setHitbox(16, 16, -8, -8);
			time = 0;
		}
		
		public override function update(): void
		{
			if (onscreen) {
				//do update stuff
				var bul:Bullet = collide("bullet", x, y) as Bullet;
				if (bul) {
					trace("collided");
					if (bul.note == note){
						world.remove(this);
						world.remove(bul);
						//particles
					}
				}
			}
			x = 288 + 288 * Math.sin(time * xphase);
			y = 120 + 120 * Math.sin(time * yphase);
			time++;
		}
	}
}