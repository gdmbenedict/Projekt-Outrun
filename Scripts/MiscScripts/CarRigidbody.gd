extends RigidBody3D

@onready var car_mesh = $Car_Mesh
@onready var body_mesh = $Car_Mesh/Car
@onready var ground_ray = $Car_Mesh/RayCast3D
@onready var right_tire = $Car_Mesh/Car/Front_Right_Tire1
@onready var left_tire = $Car_Mesh/Car/Front_Left_Tire1

# Where to place car mesh relative to sphere
var sphere_offset = Vector3.DOWN
# turn amount
var steering = 18.0
# How quick the car turns
var turn_speed = 4.0
# below this speed, car doesn't turn
var turn_stop_limit = 0.75

var speed_input = 0
var turn_input = 0

func _physics_process(delta):
	car_mesh.position = position + sphere_offset
	if ground_ray.is_colliding():
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)
		
func _process(delta):
	if not ground_ray.is_colliding():
		return
	turn_input = Input.get_axis("steer_right", "steer_left") * deg_to_rad(steering)
	right_tire.rotation.y = turn_input
	left_tire.rotation.y = turn_input
	
	if linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		
