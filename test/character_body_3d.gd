extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = ($TwistPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$TwistPivot.rotate_y(twist_input)
	$TwistPivot/PitchPivot.rotate_x(pitch_input)
	$TwistPivot/PitchPivot.rotation.x = clamp($TwistPivot/PitchPivot.rotation.x,-0.5,0.5)
	twist_input = 0.0
	pitch_input = 0.0
func  _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input  = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

	move_and_slide()
