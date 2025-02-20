extends Node2D

const HIGH = 5
const MED = 2
const LOW = 1

signal evening_start()

@export var active_operation: Operation = Operation.new() #sets up a new operation
#connects to nodes to be used in operations code
@export var areas: Node2D
@export var game: Node
@export var ui = Control
#sets min and max enemy knowledge for randomisation on each operation
@export var min_EK = 12
@export var max_EK = 35

#create operation contest variables
@onready var contested_regions: Array
@onready var morale = 80.0
@onready var enemy_knowledge = 35.0

# create variables to track operations
@onready var prev_op_loc: String
@onready var prev_op_outcome: = "Stalemate"
@onready var prev_op_type: String

@onready var in_tray_array: Array[Letter]

func _ready() -> void:
	CLOCK.time_out.connect(ui.set_daytime)
	CLOCK.evening_started.connect(_evening)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_morning()
	if Input.is_action_just_pressed("ui_cancel"):
		_evening()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _morning():
	CLOCK.time += CLOCK.INGAME_TO_REAL_MINUTE_DURATION * CLOCK.MINUTES_PER_HOUR * 14.5
	CLOCK.paused = false
	
	#set your active operation 
	for region in areas.areas_array: # for all the levels in the dict
		if region.controller == "contested":
			contested_regions.append(region.name)
	active_operation.location = contested_regions.pick_random()
	active_operation.type = active_operation.type_list.pick_random() #This currently does nothing
	enemy_knowledge = randf_range(min_EK,max_EK)
	print("From the list: " + str(contested_regions) + " the operation was decided as a " + str(active_operation.type) + " operation in " + str(active_operation.location))
	
	#what follows is an atrocity of the highest proportions
	#set your trackers for how many letters have been added
	var letters_added:= 0
	var fails_added:=0
	var wins_added:=0
	
	if letters_added <= 4 and prev_op_outcome == "Fail": # if you lost last time, 
		for letter in game.letters_array: #go through the array
			if fails_added <= 2: # if fewer than 2 fail category letters are added
				if letter.sent == false and letter.category == "Fail": #check the letter hasnt been used before and is of fail category
					_update_location(letter)
					in_tray_array.append(letter) # if so add it to in tray
					fails_added+=1 #increment fail letters count
					letters_added+=1 
			elif letter.sent == false and letter.category == "General":
				_update_location(letter)
				in_tray_array.append(letter)
				letters_added +=1
				
	elif letters_added <= 4 and prev_op_outcome == "Success":
		for letter in game.letters_array:
			if wins_added <= 2:
				if letter.sent == false and letter.category == "Success":
					_update_location(letter)
					in_tray_array.append(letter)
					wins_added+=1
					letters_added+=1
			elif letter.sent == false and letter.category == "General":
				_update_location(letter)
				in_tray_array.append(letter)
				letters_added +=1
			
	elif letters_added <= 4:
		for letter in game.letters_array:
			if letter.sent == false and letter.category == "General":
				_update_location(letter)
				in_tray_array.append(letter)
				letters_added +=1
	print(in_tray_array)
	print("total"+str(letters_added))
	print("fails"+str(fails_added))
			
	
	

func _evening():
	CLOCK.paused = true
	#look through letters HERE IS WHERE TO ADD CALLS TO THE MARKING FUNCTION 
	enemy_knowledge += (1 * HIGH + 2 * MED + 3 * LOW + 4 * LOW) # 1 is portion/number of uncensored locations
	# 2 is number of uncensored times, 3 is number of uncensored combat words, 4 is uncensored emotions
	morale += (1*HIGH - 2*MED - 3*LOW) + 4 #1 is number of letters gone through
	#2 is total letter proportion censored, 3 is number of mood words censored
	#4 is a letter by letter bonus amount (some positive letters will have this?)
	prev_op_loc = active_operation.location # store where the operation was
	prev_op_type = active_operation.type # store what type of operation it was
	var new_cont_set :=0
	if enemy_knowledge > morale:
		for region in areas.areas_array:
			if region.name == active_operation.location: #select the active location
				region.controller = "enemy" # make it taken over
			if region.controller == "ally" and new_cont_set == 0: #set 1 new allied region to contested
				region.controller = "contested"
				new_cont_set = 1
		prev_op_outcome = "Fail" #store that it failed
	elif enemy_knowledge == morale:
		for region in areas.areas_array:
			if region.name == active_operation.location:
				region.controller = "contested"
			if region.controller != "contested" and new_cont_set == 0:
				region.controller = "contested"
				new_cont_set = 1
		prev_op_outcome = "Stalemate"
	else:
		for region in areas.areas_array:
			if region.name == active_operation.location:
				region.controller = "ally"
			if region.controller == "enemy" and new_cont_set == 0:
				region.controller = "contested"
				new_cont_set = 1
		prev_op_outcome = "Success"
		
	print(str(prev_op_loc)+str(prev_op_outcome) + str(prev_op_type))
	contested_regions = []
	
	#transition to end day screen

func _update_location(letter):
	var letter_string :String
	var replace_with:String = active_operation.location
	letter_string = letter.contents.replacen("location",replace_with)
	letter.contents = letter_string
	print(letter.contents)
