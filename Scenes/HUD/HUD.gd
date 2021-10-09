extends Control
signal start_trial
signal open_all_doors

onready var goats_won_switching = $VBoxContainer/Panel/DataGrid/GoatsWon
onready var cars_won_switching = $VBoxContainer/Panel/DataGrid/CarsWon
onready var goats_won_not_switching = $VBoxContainer/Panel/DataGrid/GoatsWon2
onready var cars_won_not_switching = $VBoxContainer/Panel/DataGrid/CarsWon2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	update_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_text(text):
	$VBoxContainer/Control/MarginContainer/VBoxContainer2/DisplayText.text = text

func clear_text():
	$VBoxContainer/Control/MarginContainer/VBoxContainer2/DisplayText.text = ""

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



