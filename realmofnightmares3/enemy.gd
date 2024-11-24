extends RigidBody3D

@onready var player = $"../GUY"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = (player.global_transform.origin - global_transform.origin).normalized()
	apply_force(direction * 600.0, Vector3.ZERO)
	look_at(player.global_transform.origin, Vector3(0,1,0))
	rotate_y(deg_to_rad(90))
	
