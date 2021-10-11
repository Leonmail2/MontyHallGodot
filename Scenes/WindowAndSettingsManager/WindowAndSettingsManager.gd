extends Node
signal door_speed_updated
signal options_updated
# Declare member variables here. Examples:
# var a = 2
export var default_settings = {"fullscreen":true,"vsync":false,"door_speed":1,"max_framerate_index":1}
export var settingsfilename = "user://settings.json"

export var default_vsync = true
export var default_door_speed = true
export var default_fullscreen = true
export var default_max_framerates = [30,60,90,120,0]
export var default_max_framerate_index = 1

var vsync = true setget set_vsync
var door_speed = 1 setget set_door_speed
var fullscreen = true setget set_fullscreen
var max_framerate_index = 1 setget set_max_framerate_index

func set_door_speed(speed,writetofile=false):
	door_speed = speed
	emit_signal("options_updated")
	emit_signal("door_speed_updated",speed)
	if writetofile:
		write_to_settings_file()

func set_fullscreen(new_fullscreen,writetofile=false):
	fullscreen = new_fullscreen
	emit_signal("options_updated")
	OS.window_fullscreen = fullscreen
	if writetofile:
		write_to_settings_file()

func set_vsync(new_vsync,writetofile=false):
	vsync = new_vsync
	emit_signal("options_updated")
	OS.vsync_enabled = vsync
	if writetofile:
		write_to_settings_file()

func set_max_framerate_index(framerate_index,writetofile=false):
	if framerate_index >= 0 and framerate_index < default_max_framerates.size():
		max_framerate_index = framerate_index
		emit_signal("options_updated")
		Engine.target_fps = default_max_framerates[framerate_index]
		if writetofile:
			write_to_settings_file()
	else:
		pass


func _ready():
	#get_tree().get_root().connect("size_changed",self,"_on_root_size_changed")
	var result = read_settings_from_file()
	if result != OK:
		reset_settings_file_to_default()
		read_settings_from_file()
	
	OS.min_window_size = Vector2(int(OS.get_screen_size().x*0.6),int(OS.get_screen_size().y*0.6))
	OS.window_fullscreen = fullscreen

func read_settings_from_file():
	var file = File.new()
	var err = file.open(settingsfilename,File.READ)
	if err != OK:
		print("failed to open file")
		print(str(err))
		return false
	var data = file.get_as_text()
	file.close()
	if data == "":
		return ERR_INVALID_DATA
	print(data)
	var data_parse = JSON.parse(data)
	if data_parse.error != OK:
		return ERR_PARSE_ERROR
	if typeof(data_parse.result) == TYPE_DICTIONARY:
		var keys = data_parse.result.keys()
		if default_settings.keys() == keys:
			if typeof(data_parse.result["fullscreen"]) == TYPE_BOOL:
				fullscreen = data_parse.result["fullscreen"]
			else:
				return ERR_INVALID_DATA
			
			if typeof(data_parse.result["vsync"]) == TYPE_BOOL:
				vsync = data_parse.result["vsync"]
			else: 
				return ERR_INVALID_DATA
			
			if typeof(data_parse.result["door_speed"]) == TYPE_REAL or typeof(data_parse.result["door_speed"]) == TYPE_INT:
				door_speed = data_parse.result["door_speed"]
			else:
				return ERR_INVALID_DATA
			
			if typeof(data_parse.result["max_framerate_index"]) == TYPE_INT or typeof(data_parse.result["max_framerate_index"]) == TYPE_REAL:
				if data_parse.result["max_framerate_index"] <= default_max_framerates.size() and data_parse.result["max_framerate_index"] >= 0:
					max_framerate_index = int(data_parse.result["max_framerate_index"])
			else: 
				return ERR_INVALID_DATA
		else:
			return ERR_INVALID_DATA
	else:
		return ERR_PARSE_ERROR
	return OK

func reset_settings_file_to_default():
	var file = File.new()
	var err = file.open(settingsfilename,File.WRITE)
	if err != OK:
		print("failed to open file")
		print(str(err))
		return false
	var text = JSON.print(default_settings)
	file.store_line(text)
	file.close()
	
func write_to_settings_file():
	var file = File.new()
	var err = file.open(settingsfilename,File.WRITE)
	if err != OK:
		print("failed to open file")
		print(str(err))
		return false
	var settings = {}
	settings["fullscreen"] = fullscreen
	settings["vsync"] = vsync
	settings["door_speed"] = door_speed
	settings["max_framerate_index"] = max_framerate_index
	print(JSON.print(settings))
	file.store_line(JSON.print(settings))
	file.close()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
