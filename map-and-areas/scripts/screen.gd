extends Node2D

@export var ui = Control
@export var canvas_modulate = CanvasModulate


func _ready() -> void:
	
	canvas_modulate.time_out.connect(ui.set_daytime)
	
