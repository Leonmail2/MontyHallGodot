extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var menu = load("res://Scenes/MainMenu/MainMenu.tscn").instance()
	add_child(menu)

func initalize_montehall():
	var monte = load("res://Scenes/MonteHall/MonteHall.tscn").instance()
	add_child(monte)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
