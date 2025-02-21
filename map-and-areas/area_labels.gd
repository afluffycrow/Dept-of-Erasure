extends Node2D

var default_font: Font = ThemeDB.fallback_font

@export var areas: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw() -> void:
	for region in areas.areas_array:
		var string = region.name
		var pos = areas.locs_array[areas.areas_array.find(region)]
		draw_string(default_font,pos,string, HORIZONTAL_ALIGNMENT_LEFT, -1,14, Color.WHITE)
