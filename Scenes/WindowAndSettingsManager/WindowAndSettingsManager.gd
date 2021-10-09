extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.min_window_size = Vector2(600,400)

func go_fullscreen():
	OS.window_fullscreen = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
