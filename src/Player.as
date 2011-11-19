package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Rob
	 */
	public class Player extends Entity 
	{
		[Embed(source = "assets/uke.png")] private const UKE: Class;
		private var sprite:Spritemap,
					speed: Number = 6,
					loadtime: int = 30;
					
		public function Player(px:int, py:int) 
		{
			sprite = new Spritemap(UKE,32,64);
			super(px, py, sprite);
			setHitbox(16, 48, -8, -8);
		}
		
		public override function update():void
		{
			loadtime = loadtime > 0? loadtime-1:0;
			x += speed * (int(Input.check(Key.RIGHT)) - int(Input.check(Key.LEFT)));
			y += speed * (int(Input.check(Key.DOWN)) - int(Input.check(Key.UP)));
			if(!loadtime){
				if (Input.pressed(Key.A)) {
					world.add(new Bullet(x + 8, y + 8, 0, 0));
					loadtime = 30;
				}
				if (Input.pressed(Key.S)) {
					world.add(new Bullet(x + 8, y + 8, 0, 1));
					loadtime = 30;
				}
				if (Input.pressed(Key.D)) {
					world.add(new Bullet(x + 8, y + 8, 0, 2));
					loadtime = 30;
				}
				if (Input.pressed(Key.F)) {
					world.add(new Bullet(x + 8, y + 8, 0, 3));
					loadtime = 30;
				}
			}
			//if (collide("bullet", x, y) && (world as GameWorld).currentGameState = 1) {
				//lose game
		//		world.remove(this);
			//}
		}
		
		public function setFrame(fraym:int):void
		{
			sprite.frame = fraym;
		}
	}
}