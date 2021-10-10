extends Spatial
signal door_clicked
signal door_finished_revealing

export var door_opening_speed = 2.3

onready var Door1AnimManager = $door1/AnimationPlayer
onready var Door2AnimManager = $door2/AnimationPlayer
onready var Door3AnimManager = $door3/AnimationPlayer

onready var door1camloc = $SlidingDoor1CameraPos
onready var door2camloc = $SlidingDoor2CameraPos
onready var door3camloc = $SlidingDoor3CameraPos

onready var overviewcampos = $OverviewCamera

onready var door1light = $Door1Light
onready var door2light = $Door2Light
onready var door3light = $Door3Light

onready var doordisplay1 = $GoatCarDisplay1
onready var doordisplay2 = $GoatCarDisplay2
onready var doordisplay3 = $GoatCarDisplay3

onready var clickabledoor1 = $ClickableDoor1
onready var clickabledoor2 = $ClickableDoor2
onready var clickabledoor3 = $ClickableDoor3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	door_opening_speed = WindowAndSettingsManager.door_speed
	Door1AnimManager.play("Closed")
	Door2AnimManager.play("Closed")
	Door3AnimManager.play("Closed")
	doordisplay1.reset_display()
	doordisplay2.reset_display()
	doordisplay3.reset_display()
	connect("door_speed_changed",WindowAndSettingsManager,"on_door_speed_changed")

func on_door_speed_changed(speed):
	door_opening_speed = speed

func reveal_door(door_num):
	match door_num:
		0:
			Door1AnimManager.play("OpeningNoBounce",-1,door_opening_speed)
		1:
			Door2AnimManager.play("OpeningNoBounce",-1,door_opening_speed)
		2:
			Door3AnimManager.play("OpeningNoBounce",-1,door_opening_speed)
	

func reveal_all():
	Door1AnimManager.play("OpeningNoBounce",-1,door_opening_speed)
	Door2AnimManager.play("OpeningNoBounce",-1,door_opening_speed)
	Door3AnimManager.play("OpeningNoBounce",-1,door_opening_speed)

func close_all_now():
	Door1AnimManager.stop()
	Door2AnimManager.stop()
	Door3AnimManager.stop()
	Door1AnimManager.play("Closed")
	Door2AnimManager.play("Closed")
	Door3AnimManager.play("Closed")
	

func close_all():
	Door1AnimManager.play("Closing")
	Door2AnimManager.play("Closing")
	Door3AnimManager.play("Closing")

func set_item_behind_door(door,item):
	match door:
		0:
			if item == 1:
				doordisplay1.show_car()
			else:
				doordisplay1.show_goat()
		1:
			if item == 1:
				doordisplay2.show_car()
			else:
				doordisplay2.show_goat()
		2:
			if item == 1:
				doordisplay3.show_car()
			else:
				doordisplay3.show_goat()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func enable_clickable_doors():
	clickabledoor1.enabled = true
	clickabledoor2.enabled = true
	clickabledoor3.enabled = true

func disable_clickable_doors():
	clickabledoor1.enabled = false
	clickabledoor2.enabled = false
	clickabledoor3.enabled = false

func enable_clickable_door(door):
	match door:
		0:
			clickabledoor1.enabled = true
		1:
			clickabledoor2.enabled = true
		2:
			clickabledoor3.enabled = true

func enable_choice_overlay(door):
	match door:
		0:
			clickabledoor1.show_selection_display()
		1:
			clickabledoor2.show_selection_display()
		2:
			clickabledoor3.show_selection_display()

func disable_all_choice_overlay():
	clickabledoor1.hide_selection_display()
	clickabledoor2.hide_selection_display()
	clickabledoor3.hide_selection_display()

func on_door_finished_reveal(door):
	emit_signal("door_finished_revealing",door)

func _on_ClickableDoor_is_just_pressed():
	emit_signal("door_clicked",0)

func _on_ClickableDoor2_is_just_pressed():
	emit_signal("door_clicked",1)

func _on_ClickableDoor3_is_just_pressed():
	emit_signal("door_clicked",2)
