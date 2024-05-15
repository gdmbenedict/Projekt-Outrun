class_name Pickup
extends Node

@export_category("Rotation")
@export var xRotationSpeed: float = 0
@export var yRotationSpeed: float = 0
@export var zRotationSpeed: float = 0

var parent: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	RotatePickup(delta)

func _on_body_entered(body: Node) -> void:
	
	if(body is PlayerHealth):
		UsePickup()

func UsePickup() -> void:
	parent.queue_free()

func RotatePickup(delta: float) -> void:
	
	var rotationVector = Vector3(xRotationSpeed, yRotationSpeed, zRotationSpeed) * delta
	parent.rotation_degrees += rotationVector
