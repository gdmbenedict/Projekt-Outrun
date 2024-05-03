extends CharacterBody3D

@export var horizontalTimeToMax: float = 1
@export var horizontalMaxSpeed: float = 25

@export var trackedVelocity: Vector3 #variable that stores the velocity of the player

@export var gears: Array[Gear] = []
var activeGear: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activeGear = 0
	trackedVelocity = Vector3(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	HandleForwardMovement(delta)
	HandleHorizontalMovement(delta)
	
	#print statement testing trackedVelocity
	print(trackedVelocity)

func HandleForwardMovement(delta: float) -> void:
	
	shiftGear()
	
	trackedVelocity.z += gears[activeGear].IncreaseSpeed(trackedVelocity.z, delta)

func HandleHorizontalMovement(delta: float) -> void:
	#Horizontal Movement
	var input_dir := Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	#check for horizontal input
	if(input_dir.x != 0):
		#Apply acceleration
		trackedVelocity.x += input_dir.x * horizontalMaxSpeed * (1 / horizontalTimeToMax) * delta
		#clamp to max value
		if(trackedVelocity.x > horizontalMaxSpeed):
			trackedVelocity.x = horizontalMaxSpeed
		#clamp to min value
		elif(trackedVelocity.x < -horizontalMaxSpeed):
			trackedVelocity.x = -horizontalMaxSpeed
	
	#damp if no input
	else:
		StraightenHorizontalMovement(delta)
 
# Function that damps horizontal movement towards zero
func StraightenHorizontalMovement(delta: float) -> void:
	
	if(trackedVelocity.x > 0):
		trackedVelocity.x -= horizontalMaxSpeed* (1 / horizontalTimeToMax) * delta
		if (trackedVelocity.x < 0):
			trackedVelocity.x = 0
	
	elif(trackedVelocity.x < 0):
		trackedVelocity.x += horizontalMaxSpeed* (1 / horizontalTimeToMax) * delta
		if(trackedVelocity.x > 0):
			trackedVelocity.x = 0

# Function that determines if gear needs to be shifted
func shiftGear() -> void:
	
	if(activeGear < 4):
		#check for shift up
		if(trackedVelocity.z >= gears[activeGear + 1].GetMinSpeed()):
			activeGear += 1
	
	#check that active gear is not zero
	if (activeGear > 0):
		
		#check for shift down
		if(trackedVelocity.z < gears[activeGear].GetMinSpeed()):
			activeGear -= 1
	
