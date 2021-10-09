extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var optionsmenu = $Options
onready var mainmenu = $MainMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	mainmenu.show()
	optionsmenu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_up():
	get_parent().initalize_montehall()
	queue_free()


func _on_ExitButton_button_up():
	get_tree().quit(0)


func _on_Options_button_up():
	mainmenu.hide()
	optionsmenu.show()

func _on_BackToMainMenu_button_up():
	optionsmenu.hide()
	mainmenu.show()
