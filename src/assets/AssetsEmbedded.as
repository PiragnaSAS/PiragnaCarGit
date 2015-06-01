package assets
{
	import starling.errors.AbstractClassError;

	public final class AssetsEmbedded
	{
		[Embed(source="../../assets/xmls/game_details.xml", mimeType="application/octet-stream")]
		public static const GameDetails_Xml:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/mapa_1_1.json", mimeType="application/octet-stream")]
		public static const mapa_1_0_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/car_1_1_1.json", mimeType="application/octet-stream")]
		public static const car_1_0_0_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/car_1_1_2.json", mimeType="application/octet-stream")]
		public static const car_1_0_1_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/car_1_1_3.json", mimeType="application/octet-stream")]
		public static const car_1_0_2_JSON:Class
		
		
		[Embed(source="../../assets/Carreteras/Carreteras/mapa_1_2.json", mimeType="application/octet-stream")]
		public static const mapa_1_1_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/car_1_2_1.json", mimeType="application/octet-stream")]
		public static const car_1_1_0_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/car_1_2_2.json", mimeType="application/octet-stream")]
		public static const car_1_1_1_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/car_1_2_3.json", mimeType="application/octet-stream")]
		public static const car_1_1_2_JSON:Class
		
		[Embed(source="../../assets/Carreteras/Carreteras/mapa_1_3.json", mimeType="application/octet-stream")]
		public static const mapa_1_2_JSON:Class
		
		
		
		public function AssetsEmbedded(){ throw new AbstractClassError(); }
	}
}