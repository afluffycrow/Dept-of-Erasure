extends Resource
class_name Letter

@export_multiline var contents: String
@export var category: String
@export var tags: Array[String]

var loc_censored:= 0.0
var time_censored:= 0.0
var comb_censored:= 0.0
var mood_consored:= 0.0
var total_censored:= 0.0
#var bonus:= 5.0

var sent:= false
