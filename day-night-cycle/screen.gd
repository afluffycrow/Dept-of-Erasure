extends Node2D

@export var ui = Control
@export var canvas_modulate = CanvasModulate
@export var canvas_layer = CanvasLayer

func _ready() -> void:
	canvas_layer.visible = true
	canvas_modulate.time_out.connect(ui.set_daytime)
	
