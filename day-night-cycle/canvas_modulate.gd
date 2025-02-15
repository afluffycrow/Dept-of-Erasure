extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = 2*PI / MINUTES_PER_DAY # need to mess with this depending on the curve, since the curve only represents day

signal time_out(day:int, hour:int, minute:int)

var time:float = 0.0
var hour := 0
var past_minute:float = -1

@export var gradient:GradientTexture1D
@export var ingame_speed:= 0.25 #fudge with it to get right feel
@export var start_time:= 9 # hour

var time_colour:= 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * start_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * ingame_speed 
	_recalculate_time()
	time_colour = (sin(time - PI/2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(time_colour)
	print(str(color))
	
func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	var day = int(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	hour = (current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	if past_minute != minute:
		past_minute = minute
		time_out.emit(day,hour,minute)
