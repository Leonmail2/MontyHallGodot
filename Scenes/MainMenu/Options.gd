extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var resolution_selector = $Options/MarginContainer4/HBoxContainer2/ResolutionSelector
onready var vsync_button = $Options/MarginContainer3/HBoxContainer2/VsyncCheckBox
onready var speed_display = $Options/MarginContainer2/HBoxContainer/SpeedDisplay
onready var speed_slider = $Options/MarginContainer2/HBoxContainer/SpeedSlider
var door_speed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	speed_slider.value = WindowAndSettingsManager.door_speed
	door_speed = speed_slider.value
	vsync_button.pressed = WindowAndSettingsManager.vsync
	
		
	for resolution in WindowAndSettingsManager.resolutions:
		resolution_selector.add_item(str(resolution.x)+"x"+str(resolution.y),WindowAndSettingsManager.resolutions.find(resolution))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#


func _on_SpeedSlider_value_changed(value):
	speed_display.text = str(value)
	door_speed = value
	WindowAndSettingsManager.door_speed = value


func _on_VsyncCheckBox_toggled(button_pressed):
	WindowAndSettingsManager.vsync = button_pressed
