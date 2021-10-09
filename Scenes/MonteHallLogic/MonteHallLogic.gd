extends Node
signal door_reveal_chosen

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var door_configs = [[1,0,0],[0,1,0],[0,0,1]]
var current_door_config = [] setget set_current_door_config, get_current_door_config
var current_player_door_choice = null #starts from 0
var player_second_door_choice = null
var revealed_door = null
var player_switched = null
var player_won = null

func set_current_door_config(new_door_config):
	current_door_config = new_door_config

func get_current_door_config():
	return current_door_config

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func get_door_config():
	return door_configs[randi()%door_configs.size()]

func determine_goat_door_reveal(door_config,player_door_choice):
	var new_door_config = door_config.duplicate()
	new_door_config[player_door_choice] = 1
	var goat_door_indexes = []
	for i in range(0,new_door_config.size()):
		if new_door_config[i] == 0:
			goat_door_indexes.append(i)
	var revealed_door = goat_door_indexes[randi()%goat_door_indexes.size()]
	return revealed_door

func start_simulation():
	current_door_config = get_door_config()
	current_player_door_choice = null
	revealed_door = null
	player_switched = null
	player_won = null
	player_second_door_choice = null

func door_chosen_by_player(door):
	current_player_door_choice = door
	revealed_door = determine_goat_door_reveal(current_door_config,current_player_door_choice)
	emit_signal("door_reveal_chosen",revealed_door)

func player_choose_second_door(door):
	if door == current_player_door_choice:
		player_switched = false
	else:
		player_switched = true
	player_second_door_choice = door
	if current_door_config[player_second_door_choice] == 1:
		player_won = true
	else:
		player_won = false

func check_if_player_wins():
	if player_won != null:
		if current_door_config[player_second_door_choice] == 1:
			player_won = true
		else:
			player_won = false
		HistoryManager.store_trial_information(player_won,player_switched)
		return player_won
	else:
		return player_won

func reset_simulation():
	current_door_config = null
	player_switched = null
	revealed_door = null
	current_player_door_choice = null
	player_won = null
	player_second_door_choice = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
