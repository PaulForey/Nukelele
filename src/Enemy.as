package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	/**
	 * ...
	 * @author Rob
	 */
	public class Enemy extends Entity 
	{
		[Embed(source = "assets/enemy.png")] private const ENEMY:Class;
		private var onscreen: Boolean = false,
					sprite: Stamp,
					note: int;
		public function Enemy(note: int, px:int)
		{
			sprite = new Stamp(ENEMY);
			super(px, -32, sprite);
			FP.tween(this, { y: 32 }, 1, { complete: function():void{ onscreen = true; } } );
			this.note = note;
			setHitbox(16, 16, -8, -8);
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
		}
	}
}