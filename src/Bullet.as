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
		public var note: int;
		private var sprite: Spritemap,
					velocity: Point,
					speed : Number = 5;
		public function Bullet(px: Number, py: Number, angle: Number, note: int)
		{
			sprite = new Spritemap(SHOT, 8, 32);
			sprite.add("this", [note]);
			sprite.play("this");
			sprite.angle = angle * 180 / (2 * Math.PI);
			super(px, py, sprite);
			velocity = new Point(speed * Math.sin(angle), -speed * Math.cos(angle));
			type = "bullet";
			this.note = note;
			setHitbox(16, 16, 0, 0);
			//play sound looping somewhere in here or in update
		}
		
		public override function update(): void
		{
			x += velocity.x;
			y += velocity.y;
		}
	}
}