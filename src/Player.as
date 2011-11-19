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
        private const LOADTIME:int = 0;

		[Embed(source = "assets/uke.png")] private const UKE: Class;
		private var sprite:Spritemap,
					speed: Number = 6,
					loadtimer: int = LOADTIME;
					
		public function Player(px:int, py:int) 
		{
			sprite = new Spritemap(UKE,32,64);
			super(px, py, sprite);
			setHitbox(16, 48, -8, -8);
		}
		
		public override function update():void
		{
			loadtimer = loadtimer > 0? loadtimer-1:0;
			x += speed * (int(Input.check(Key.RIGHT)) - int(Input.check(Key.LEFT)));
			y += speed * (int(Input.check(Key.DOWN)) - int(Input.check(Key.UP)));
			if((world as GameWorld).gameState == 0 && !loadtimer){
				if (Input.pressed(Key.A)) {
					(world as GameWorld).queueBullet(new Bullet(x + 8, y + 8, 0, 0));
					loadtimer = LOADTIME;
				}
				if (Input.pressed(Key.S)) {
					(world as GameWorld).queueBullet(new Bullet(x + 8, y + 8, 0, 1));
					loadtimer = LOADTIME;
				}
				if (Input.pressed(Key.D)) {
					(world as GameWorld).queueBullet(new Bullet(x + 8, y + 8, 0, 2));
					loadtimer = LOADTIME;
				}
				if (Input.pressed(Key.F)) {
					(world as GameWorld).queueBullet(new Bullet(x + 8, y + 8, 0, 3));
					loadtimer = LOADTIME;
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
