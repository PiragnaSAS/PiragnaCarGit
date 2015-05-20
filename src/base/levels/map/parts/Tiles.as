package base.levels.map.parts
{
	import flash.utils.Dictionary;

	public class Tiles
	{
		public static var dict:Dictionary;
		
		public function Tiles(tileSets:Array){		
			dict = new Dictionary();
			for(var i:uint = 0; i<tileSets.length; i++){
				dict[tileSets[i]["firstgid"]] = tileSets[i]["name"];
			}
		}
		
	}
}