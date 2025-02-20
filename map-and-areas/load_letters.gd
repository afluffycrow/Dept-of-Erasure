extends Node

@export var file_paths: Array[String]
@export var letters_array: Array

@onready var path = "res://letters/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_get_filepaths()
	_create_letters()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		print(str(file_paths))

func _get_filepaths():
	var dir = DirAccess.open(path)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = path + file_name  
		file_paths.append(file_path)  
		file_name = dir.get_next()  

func _create_letters():
	for path in file_paths:
		var new_letter: Letter = Letter.new()
		var file = FileAccess.open(path,FileAccess.READ)
		new_letter.contents = file.get_as_text()
		letters_array.append(new_letter)
	print(letters_array)
