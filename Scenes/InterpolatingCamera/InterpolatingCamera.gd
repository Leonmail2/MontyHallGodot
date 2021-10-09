extends Spatial
signal finished_interpolating

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var interpolation = 15.0
export var interpolation_finished_threshold = 0.1
export var interpolation_angle_finished_threshold = 0.01
var target_position = Transform()
var is_interpolating = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_interpolation_target(target):
	target_position = target
	is_interpolating = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_interpolating:
		var current_transform = Quat(global_transform.basis)
		var target_transform = Quat(target_position.basis)
		var new_transform = current_transform.slerp(target_transform,interpolation*delta)
		global_transform.basis = Basis(new_transform)
		global_transform.origin = global_transform.origin.linear_interpolate(target_position.origin,interpolation*delta)
		var angle_between_vecs = -global_transform.basis.z.angle_to(-target_position.basis.z)
		if (global_transform.origin - target_position.origin).length() <= interpolation_finished_threshold and angle_between_vecs < interpolation_angle_finished_threshold:
			is_interpolating = false
			emit_signal("finished_interpolating")
