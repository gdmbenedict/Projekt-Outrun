extends Node3D

class_name PlayerMovement

@export_category("Horizontal Movement")
@export var horizontalTimeToMax: float = 1
@export var horizontalMaxSpeed: float = 25

@export_category("Gears")
@export var gears: Array[Gear] = []
var activeGear: int

@export var trackedVelocity: Vector3 #variable that stores the velocity of the player

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activeGear = 0
	trackedVelocity = Vector3(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	HandleForwardMovement(delta)
	HandleHorizontalMovement(delta)
	
	#print statement testing trackedVelocity
	#print(trackedVelocity)

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

#Function that returns the Vector3 stored velocity of the vehicle. This is returned in KMH.
func GetVelocity() -> Vector3:
	return trackedVelocity

#Function that returns the speed of the player along the z-axis in KMH
func GetSpeed() -> float:
	return trackedVelocity.z

#function that shifts the player down a gear and dramatically reduces their speed.
func EmergencyShift() -> void:
	
	if(activeGear != 0):
		activeGear -= 1
	
	trackedVelocity.z = gears[activeGear].GetMinSpeed()
