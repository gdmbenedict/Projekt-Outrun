extends Node

@export_category("Pickups")
@export var pickups: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Spawn pickup and set location and parent
	var spawnedPickup = pickups.pick_random().instantiate() as Node3D
	spawnedPickup.global_position = self.global_position
	self.get_parent().add_child(spawnedPickup)
	
	print("special pickup spawned")
	
	#despawn self
	#queue_free()
