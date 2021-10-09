extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var stage = $Stage
onready var camera = $InterpolatingCamera
onready var hud = $HUD
# Called when the node enters the scene tree for the first time.
func _ready():
	camera.global_transform = stage.overviewcampos.global_transform
	StageLogicInterface.set_stage(stage)
	StageLogicInterface.set_camera(camera)
	StageLogicInterface.set_HUD(hud)
	initalize_trial()

func initalize_trial():
	StageLogicInterface.initalize_trial()
	#$HUD.display_text("CHOOSE A DOOR")

func end_trial():
	StageLogicInterface.reset_trial()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HUD_open_all_doors():
	stage.reveal_all()


func _on_HUD_start_trial():
	initalize_trial()
