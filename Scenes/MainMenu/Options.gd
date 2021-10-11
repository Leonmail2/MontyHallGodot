extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var fullscreen = $Options/MarginContainer4/HBoxContainer2/Fullscreen
onready var vsync_button = $Options/MarginContainer3/HBoxContainer2/VsyncCheckBox
onready var speed_display = $Options/MarginContainer2/HBoxContainer/SpeedDisplay
onready var speed_slider = $Options/MarginContainer2/HBoxContainer/SpeedSlider
onready var framerate_options = $Options/MarginContainer5/HBoxContainer2/MaxFramerate
# Called when the node enters the scene tree for the first time.
func _ready():
	update_options()
	WindowAndSettingsManager.connect("options_updated",self,"update_options")
		
	#for resolution in WindowAndSettingsManager.resolutions:
	#	resolution_selector.add_item(str(resolution.x)+"x"+str(resolution.y),WindowAndSettingsManager.resolutions.find(resolution))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#
func update_options():
	speed_slider.value = WindowAndSettingsManager.door_speed
	fullscreen.pressed = WindowAndSettingsManager.fullscreen
	framerate_options.selected = WindowAndSettingsManager.max_framerate_index
	vsync_button.pressed = WindowAndSettingsManager.vsync

func _on_SpeedSlider_value_changed(value):
	speed_display.text = str(value)
	WindowAndSettingsManager.set_door_speed(value,true)


func _on_VsyncCheckBox_toggled(button_pressed):
	WindowAndSettingsManager.set_vsync(button_pressed,true)


func _on_Fullscreen_toggled(button_pressed):
	WindowAndSettingsManager.set_fullscreen(button_pressed,true)


func _on_MaxFramerate_item_selected(index):
	WindowAndSettingsManager.set_max_framerate_index(index,true)


func _on_Options_visibility_changed():
	if OS.window_fullscreen != WindowAndSettingsManager.fullscreen:
		WindowAndSettingsManager.set_fullscreen(OS.window_fullscreen,true)
	update_options()

