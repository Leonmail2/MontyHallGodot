extends Area
signal is_just_pressed
export var door_number = 1

var show_door_number = true setget set_show_door_number 
var enabled = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func show_selection_display():
	$SelectionDisplay.show()

func hide_selection_display():
	$SelectionDisplay.hide()

func set_show_door_number(door_number_vis):
	show_door_number = door_number_vis
	if door_number_vis == true:
		$NumberDisplay.show()
	else:
		$NumberDisplay.hide()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport/CanvasLayer/Control/Label.text = str(door_number)
	$MouseOverDisplay.hide()
	if not show_door_number:
		$NumberDisplay.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_pressed():
	enabled = false
	emit_signal("is_just_pressed")

func _on_ClickableDoor_input_event(camera, event, click_position, click_normal, shape_idx):
	if enabled:
		if event is InputEventMouseButton:
			if event.button_index == 1 and event.pressed:
				is_pressed()
				$MouseOverDisplay.hide()


func _on_ClickableDoor_mouse_entered():
	if enabled:
		$MouseOverDisplay.show()


func _on_ClickableDoor_mouse_exited():
	$MouseOverDisplay.hide()
