package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	/**
	 * ...
	 * @author Rob
	 */
	public class Bullet extends Entity
	{
		[Embed(source = "assets/shot.png")] private const SHOT : Class;
		public var note: int;
		private var sprite: Stamp,
					velocity: Point,
					speed : Number = 5;
		public function Bullet(px: Number, py: Number, angle: Number, note: int)
		{
			sprite = new Stamp(SHOT);
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