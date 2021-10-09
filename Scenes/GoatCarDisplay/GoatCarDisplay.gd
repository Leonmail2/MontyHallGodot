extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var goat = $Goat
onready var car = $Car

# Called when the node enters the scene tree for the first time.
func _ready():
	goat.hide()
	car.hide()

func show_goat():
	goat.show()
	car.hide()

func show_car():
	goat.hide()
	car.show()

func reset_display():
	goat.hide()
	car.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
