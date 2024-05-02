extends CharacterBody3D


@export var trackedVelocity: Vector3 #variable that stores the velocity of the player

@export var gears: Array[Gear] = []
var activeGear: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activeGear = 0
	trackedVelocity = Vector3(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input_dir := Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
 
func shiftGear() -> void:
	
	#check for shift up
	if(trackedVelocity.z >= gears[activeGear + 1].GetMinSpeed()):
		activeGear += 1
		
	#check that active gear is not zero
	elif (activeGear > 0):
		
		#check for shift down
		if(trackedVelocity.z < gears[activeGear].GetMinSpeed()):
			activeGear -= 1
	
