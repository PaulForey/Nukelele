package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Stamp;
	/**
	 * ...
	 * @author Rob
	 */
	public class Bullet extends Entity
	{
		[Embed(source = "assets/shotsheet.png")] private const SHOT : Class;
		public var note: int,
					owner: int; //0 == player, 1 == enemy
		private var sprite: Spritemap,
					velocity: Point,
					speed : Number = 9;
		public function Bullet(px: Number, py: Number, angle: Number, note: int, owner:int)
		{
			sprite = new Spritemap(SHOT, 8, 64);
			sprite.add("this", [note]);
			sprite.play("this");
			sprite.centerOrigin();
			sprite.angle = -angle * (180 /  Math.PI);
			super(px, py, sprite);
			velocity = new Point(speed * Math.sin(angle), -speed * Math.cos(angle));
			type = "bullet";
			this.note = note;
			setHitbox(6, 6, 3, 3);
			this.owner = owner;
			//play sound looping somewhere in here or in update
		}
		
		public override function update(): void
		{
			x += velocity.x;
			y += velocity.y;

            if (y < -40 || y > 480 || x<-40 || x>640)
                world.remove(this);
			
		}
	}
}
