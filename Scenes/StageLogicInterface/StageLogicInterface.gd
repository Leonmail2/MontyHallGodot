extends Node
signal trial_finished

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stage = null setget set_stage
var camera = null setget set_camera
var hud = null setget set_HUD

var player_has_chosen = false
var monty_has_revealed = false
var player_has_chosed_second_door = false
var trial_finished = false

func set_stage(new_stage):
	stage = new_stage
	stage.connect("door_clicked",self,"on_Stage_door_clicked")
	stage.connect("door_finished_revealing",self,"on_Stage_door_finished_revealing")

func set_camera(new_camera):
	camera = new_camera
	camera.connect("finished_interpolating",self,"on_Camera_finished_interpolating")

func set_HUD(new_hud):
	hud = new_hud
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	MonteHallLogic.connect("door_reveal_chosen",self,"on_MontyHallLogic_door_reveal_chosen")

func reset_trial():
	initalize_trial()

func initalize_trial():
	player_has_chosen = false
	monty_has_revealed = false
	player_has_chosed_second_door = false
	trial_finished = false
	if stage != null:
		stage.close_all_now()
		MonteHallLogic.start_simulation()
		var config = MonteHallLogic.get_current_door_config()
		for i in range(config.size()):
			stage.set_item_behind_door(i,config[i])
		stage.enable_clickable_doors()
	hud.set_text("Choose a door")
	stage.disable_all_choice_overlay()
	stage.close_all_now()
	camera.set_interpolation_target(stage.overviewcampos.global_transform)

func check_if_player_wins():
	trial_finished = true
	var result = MonteHallLogic.check_if_player_wins()
	if result == true:
		hud.set_text("you win a car!")
	else:
		hud.set_text("you win a goat")
	for i in range(3):
		if i != MonteHallLogic.player_second_door_choice and i != MonteHallLogic.revealed_door:
			stage.reveal_door(i)
	hud.update_hud()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_Stage_door_clicked(door_num):
	if not player_has_chosen:
		player_has_chosen = true
		hud.set_text("Revealing a Goat...")
		stage.disable_clickable_doors()
		MonteHallLogic.door_chosen_by_player(door_num)
		print("door chosen by player: " + str(door_num))
		stage.enable_choice_overlay(door_num)
	if player_has_chosen and not player_has_chosed_second_door and monty_has_revealed:
		MonteHallLogic.player_choose_second_door(door_num)
		player_has_chosed_second_door = true
		stage.disable_clickable_doors()
		stage.disable_all_choice_overlay()
		stage.enable_choice_overlay(door_num)
		hud.set_text("revealing chosen door...")
		yield(zoom_in_reveal_zoom_out(door_num),"completed")
		check_if_player_wins()
		

func on_MontyHallLogic_door_reveal_chosen(door):
	if not monty_has_revealed:
		print("door being revealed: " + str(door))
		yield(zoom_in_reveal_zoom_out(door),"completed")
		monty_has_revealed = true
		hud.set_text("Stay or Switch?")
		for i in range(MonteHallLogic.current_door_config.size()):
			if i != MonteHallLogic.revealed_door:
				stage.enable_clickable_door(i)

func zoom_in_reveal_zoom_out(door):
	stage.disable_clickable_doors()
	match door:
		0:
			camera.set_interpolation_target(stage.door1camloc.global_transform)
		1:
			camera.set_interpolation_target(stage.door2camloc.global_transform)
		2:
			camera.set_interpolation_target(stage.door3camloc.global_transform)
	yield(camera,"finished_interpolating")
	stage.reveal_door(door)
	yield(stage,"door_finished_revealing")
	camera.set_interpolation_target(stage.overviewcampos.global_transform)
	yield(camera,"finished_interpolating")
	


func _on_PlayAgainTimer_timeout():
	hud.set_text("play again?")
