extends Node2D

var areas_array: Array
var locs_array: = [
]

	
var region1: MapRegion = MapRegion.new()
var region2: MapRegion = MapRegion.new()
var region3: MapRegion = MapRegion.new()
var region4: MapRegion = MapRegion.new()
var region5: MapRegion = MapRegion.new()
var region6: MapRegion = MapRegion.new()
var region7: MapRegion = MapRegion.new()
var region8: MapRegion = MapRegion.new()
var region9: MapRegion = MapRegion.new()
var region10: MapRegion = MapRegion.new()
var region11: MapRegion = MapRegion.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	region1.sprite = $Alberton
	region1.controller = "contested"
	region1.name = "Alberton"
	areas_array.append(region1) 
	var z1_loc = $z1_loc
	locs_array.append(z1_loc.position)
	
	region2.sprite = $"Oily-bluff"
	region2.controller = "enemy"
	region2.name = "Oily Bluff"
	areas_array.append(region2) 
	var z1_loc2 = $z1_loc2
	locs_array.append(z1_loc2.position)
	
	region3.sprite = $"Stuffon-orchards"
	region3.controller = "contested"
	region3.name = "Ladnov"
	areas_array.append(region3)
	var z1_loc3 = $z1_loc3
	locs_array.append(z1_loc3.position) 
	
	region4.sprite = $"Western-mountains"
	region4.controller = "ally"
	region4.name = "Western Mountains"
	areas_array.append(region4) 
	var z1_loc4 = $z1_loc4
	locs_array.append(z1_loc4.position) 
	
	region5.sprite = $Juns
	region5.controller = "ally"
	region5.name = "Juns"
	areas_array.append(region5)
	var z1_loc5 = $z1_loc5
	locs_array.append(z1_loc5.position)  
	
	region6.sprite = $Snaff
	region6.controller = "ally"
	region6.name = "Hallem"
	areas_array.append(region6) 
	var z1_loc6 = $z1_loc6
	locs_array.append(z1_loc6.position) 
	
	region7.sprite = $"South-flingo"
	region7.controller = "ally"
	region7.name = "Constad"
	areas_array.append(region7) 
	var z1_loc7 = $z1_loc7
	locs_array.append(z1_loc7.position) 
	
	region8.sprite = $Lake
	region8.controller = "ally"
	region8.name = "Orbany"
	areas_array.append(region8) 
	var z1_loc8 = $z1_loc8
	locs_array.append(z1_loc8.position) 
	
	region9.sprite = $Christon
	region9.controller = "ally"
	region9.name = "Christon"
	areas_array.append(region9)
	var z1_loc9 = $z1_loc9
	locs_array.append(z1_loc9.position) 
	
	region10.sprite = $"Eastern-dunes"
	region10.controller = "ally"
	region10.name = "Eastern Dunes"
	areas_array.append(region10)
	var z1_loc10 = $z1_loc10
	locs_array.append(z1_loc10.position) 
	
	region11.sprite = $"Map-capitol"
	region11.controller = "ally"
	region11.name = "Capitol"
	areas_array.append(region11)
	var z1_loc11 = $z1_loc11
	locs_array.append(z1_loc11.position) 
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for region in areas_array: # for all the levels in the dict
		if region.controller == "ally": # check if controller is 0 (i e ally)
			region.sprite.self_modulate = Color(0.7, 0.9, 1, 0.7) # if so make white
		if region.controller == "contested":
			region.sprite.self_modulate = Color(1, 0.84, 0.75, 0.7) # if so make orange
		if region.controller == "enemy":
			region.sprite.self_modulate = Color(0.690196, 0.188235, 0.376471, 1) # if so make red


		
