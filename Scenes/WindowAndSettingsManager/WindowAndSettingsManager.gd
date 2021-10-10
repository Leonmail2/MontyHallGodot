extends Node
signal door_speed_updated

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var resolutions = [Vector2(640,480),Vector2(800,600),Vector2(1440,1080),Vector2(3840,2160),Vector2(1152,648),Vector2(1280,720),Vector2(1920,1080),Vector2(2560,1440),Vector2(3840,2160)]

export var default_version = "0.1"
var default_resolution = Vector2(0,0)
export var default_door_speed = 1.0
export var default_vsync = true
export var default_fullscreen = true

var current_fullscreen = true
var current_resolution = Vector2(0,0)
var settings_filename = "user://settings.json"
var door_speed = 1.0 setget set_door_speed
var vsync = true setget set_vsync
var version = ""

func set_door_speed(new_door_speed):
	door_speed = new_door_speed
	emit_signal("door_speed_updated",door_speed)
	store_settings()

func set_vsync(new_vsync):
	vsync = new_vsync
	OS.set_use_vsync(vsync)
	store_settings()

# Called when the node enters the scene tree for the first time.
func _ready():
	default_resolution = OS.get_screen_size()
	OS.min_window_size = Vector2(800,480)
	read_settings()
	if not typeof(current_resolution) == TYPE_VECTOR2:
		current_resolution = default_resolution
	print(current_resolution)
	OS.set_window_size(current_resolution)
		
	#dealing with settings

func go_fullscreen():
	OS.window_fullscreen = true

func read_settings():
	var file = File.new()
	if file.file_exists(settings_filename):
		file.open(settings_filename,file.READ)
		
		file.close()
	else:
		make_blank_settings_file()
		read_settings()

func make_blank_settings_file():
	var file = File.new()
	file.open(settings_filename,file.WRITE)
	
	file.close()

func store_settings():
	var file = File.new()
	if file.file_exists(settings_filename):
		file.open(settings_filename,file.WRITE)
		
		file.close()
	else:
		make_blank_settings_file()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
