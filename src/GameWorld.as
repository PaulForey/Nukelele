package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Rob
	 */
	public class GameWorld extends World 
	{
		
		public function GameWorld()
		{
			add(new Player(320, 240));
		}
		
	}

}