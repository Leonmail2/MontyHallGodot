extends Control
signal start_trial
signal open_all_doors

onready var displaytext = $HUD/Control/MarginContainer/VBoxContainer2/DisplayText

onready var goats_won_switching = $HUD/Panel/DataGrid/GoatsWon
onready var cars_won_switching = $HUD/Panel/DataGrid/CarsWon
onready var goats_won_not_switching = $HUD/Panel/DataGrid/GoatsWon2
onready var cars_won_not_switching = $HUD/Panel/DataGrid/CarsWon2

onready var options = $Options
onready var hud = $HUD

var is_in_options = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
onready var reset_button = $HUD/Panel/Panel/HBoxContainer/MarginContainer/Reset

func disable_reset():
	reset_button.disabled = true

func enable_reset():
	reset_button.disabled = false

func _ready():
	is_in_options = false
	$HUD.show()
	$Options.hide()
	update_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_text(text):
	displaytext.text = text

func clear_text():
	displaytext.text = ""

func _on_Button_button_up():
	emit_signal("start_trial")


func _on_Button2_button_up():
	emit_signal("open_all_doors")


func _on_Quit_button_up():
	get_tree().quit(0)

func update_hud():
	var data = HistoryManager.retrive_json_file_information()
	goats_won_switching.text = "Goats won from switching: " + str(data["trials_lost_switching"])
	cars_won_switching.text = "Cars won from switching: " + str(data["trials_won_switching"])
	goats_won_not_switching.text = "Goats won from not switching: " + str(data["trials_lost_not_switching"])
	cars_won_not_switching.text = "Cars won from not switching: " + str(data["trials_won_not_switching"])

func _on_OpenOptions_button_up():
	is_in_options = true
	$Options.show()
	get_tree().paused = true


func _on_BackToMenuButton_button_up():
	get_tree().paused = false
	get_node("/root/Main").reinitalize_main_menu()


func _on_ResumeButton_button_up():
	is_in_options = false
	$Options.hide()
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		is_in_options = !is_in_options
		get_tree().paused = is_in_options
		$Options.visible = is_in_options
