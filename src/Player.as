package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Rob
	 */
	public class Player extends Entity 
	{
		[Embed(source = "assets/uke.png")] private const UKE: Class;
		private var sprite:Image,
					speed: Number = 3;
		public function Player(px:int, py:int) 
		{
			sprite = new Image(UKE);
			super(px, py, sprite);
		}
		
		public override function update():void
		{
			x += speed * (int(Input.check(Key.RIGHT)) - int(Input.check(Key.LEFT)));
			y += speed * (int(Input.check(Key.DOWN)) - int(Input.check(Key.UP)));
			if (Input.pressed(Key.A)) world.add(new Bullet(x + 8, y + 8, 0, 0));
			if (Input.pressed(Key.S)) world.add(new Bullet(x + 8, y + 8, 0, 1));
			if (Input.pressed(Key.D)) world.add(new Bullet(x + 8, y + 8, 0, 2));
			if (Input.pressed(Key.F)) world.add(new Bullet(x + 8, y + 8, 0, 3));
		}
	}

}