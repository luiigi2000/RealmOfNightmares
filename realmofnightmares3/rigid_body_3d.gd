extends RigidBody3D

var mouse_sensitivity := 0.001 
var twist_input := 0.0 
var pitch_input := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$AnimationTree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("left","right")
	input.z = Input.get_axis("forward","backward")
	apply_central_force($TwistPivot.basis * input * 7500.0 * delta)
	if input.x == 0 and input.z ==0:
		$AnimationTree.active = false
	else:
		$AnimationTree.active = true
	if Input.is_action_just_pressed("ui_cancel"): 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	$TwistPivot.rotate_y(twist_input)
	$TwistPivot/PitchPivot.rotate_x(pitch_input) 
	$TwistPivot/PitchPivot.rotation.x = clamp($TwistPivot/PitchPivot.rotation.x,deg_to_rad(-30),deg_to_rad(30)) 
	twist_input = 0.0 
	pitch_input = 0.0
	if Input.is_mouse_button_pressed(1):
		$AnimationPlayer.play("stab")
	elif Input.is_mouse_button_pressed(2):
		$AnimationPlayer.play("dodge")
	
	
func _unhandled_input(event: InputEvent) -> void: 
	if event is InputEventMouseMotion: 
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: 
			twist_input  = - event.relative.x * mouse_sensitivity 
			pitch_input = - event.relative.y * mouse_sensitivity 
			

			
