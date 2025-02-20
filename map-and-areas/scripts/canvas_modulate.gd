extends CanvasModulate


@export var gradient:GradientTexture1D


var time_colour:= 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_colour = (sin(CLOCK.time - PI/2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(time_colour)
	
	
