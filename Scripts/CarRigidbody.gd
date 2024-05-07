extends RigidBody3D

@onready var car_mesh = $RigidBody3D/Car_Body
@onready var ground_ray = $RigidBody3D/Car_Body/RayCast3D
@onready var left_tire = $Front_Left_Tire1
@onready var right_tire = $Front_Right_Tire1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
