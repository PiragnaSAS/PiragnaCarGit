package base.levels.map.parts
{
	
	
	public class Administrador
	{
		private var jsonlvl:Array;
		private var tilesLayer:Tiles;
		private var jsonLayers:Array;
		private var jsonTiles:Array;
		private var jsonArray:Array;
		private var jsonData:Array;
		private var jsonNames:Array;
		private var jsonCars:Array;
		private var finalCarsLayer:Array;
		private var finalRaceLayer:Array;
		private var finalFrontObjectsLayer:Array;
		public function Administrador(){
			jsonlvl=new Array();
			jsonArray=new Array();
			jsonCars=new Array();
			finalCarsLayer= new Array();
			finalRaceLayer= new Array();
			finalFrontObjectsLayer = new Array();
		}
		
		public  function addJson(newJson:Object,newCars:Object):void{
			var json:Object = newJson;
			var Cars:Object = newCars;
			jsonlvl.push(json);
			jsonCars.push(Cars);
		}
		public function createFinalMap():void{
						
			finalRaceLayer.push(["bgTack_7_7"]);
			finalRaceLayer.push(["bgTack_7_7"]);
			finalRaceLayer.push(["bgTack_7_7"]);
			finalRaceLayer.push(["bgTack_0_0"]);
			
			finalFrontObjectsLayer.push(["frTack_4"]);
			finalFrontObjectsLayer.push(["frTack_4"]);
			finalFrontObjectsLayer.push(["frTack_4"]);
			finalFrontObjectsLayer.push(["frTack_4"]);		
				
			for each (var json:Object in jsonlvl){
				tilesLayer = new Tiles(json["tilesets"]);
				for each(var layer:Object in json["layers"]){
					switch(layer["name"]){
						case "RaceLayer":
							jsonData = new Array();
							jsonTiles= new Array();
							jsonNames= new Array();
							var data:Array=layer["data"];
							
							if(data!=null){
								for(var i:int=0;i<data.length;i++){
									jsonData.push(data[i]);
								}
							}
							for(var j:int=0;j<jsonData.length;j++){
								jsonTiles.push(Tiles.dict[jsonData[j]]);
							}
							
							finalRaceLayer=finalRaceLayer.concat(jsonTiles);
							break;
						case "FrontObjectsLayer":
							jsonData = new Array();
							jsonTiles= new Array();
							jsonNames= new Array();
							var data:Array=layer["data"];
							if(data!=null){
								for(var i:int=0;i<data.length;i++){
									jsonData.push(data[i]);
								}
							}
							
							for(var j:int=0;j<jsonData.length;j++){
								jsonTiles.push(Tiles.dict[jsonData[j]]);
							}
							
							finalFrontObjectsLayer=finalFrontObjectsLayer.concat(jsonTiles);
							break;
					}
					
				}
				
			}
					
			
			for each (var json:Object in jsonCars){
				tilesLayer = new Tiles(json["tilesets"]);
				for each(var layer:Object in json["layers"]){
					switch(layer["name"]){
						case "CarsLayer":
							jsonData = new Array();
							jsonTiles= new Array();
							jsonNames= new Array();
							var data:Array=layer["data"];
							if(data!=null){
								for(var i:int=0;i<data.length;i++){
									jsonData.push(data[i]);
								}
							}
							for(var j:int=0;j<jsonData.length;j++){
								jsonTiles.push(Tiles.dict[jsonData[j]]);
							}
							
							finalCarsLayer=finalCarsLayer.concat(jsonTiles);
							break;
					}
				}
			}
			
			for(var l:uint=0 ; l<3*6*4;l++){
				finalCarsLayer.push("transparency");
			}
			
			trace(finalCarsLayer);
			
			finalRaceLayer.push(["bgTack_0_0"]);
			finalRaceLayer.push(["bgTack_7_7"]);
			finalRaceLayer.push(["bgTack_7_7"]);
			finalRaceLayer.push(["bgTack_7_7"]);
						
			finalFrontObjectsLayer.push(["frTack_4"]);
			finalFrontObjectsLayer.push(["frTack_4"]);
			finalFrontObjectsLayer.push(["frTack_4"]);
			finalFrontObjectsLayer.push(["frTack_4"]);	
			
			trace(finalRaceLayer.length);
		}
		
		public function getFinalCarsLayer():Array{
			return this.finalCarsLayer;
		}
		public function getFinalFronObjectsLayer():Array{
			return this.finalFrontObjectsLayer;
		}
		public function getFinalRaceLayer():Array{
			return this.finalRaceLayer;
		}
		
	}
}