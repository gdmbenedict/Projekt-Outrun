extends Node

class_name Gear

@export var maxSpeed: float
@export var minSpeed: float
@export var timeShift: float
@export var smoothingFactor: float

#initialization function
func _init() -> void:
	pass

func IncreaseSpeed(currentSpeed: float, deltaTime: float) -> float:
	
	var accTime: float #this stores where the car is on its velocity graph
	var newSpeed: float #this is the new final speed after acceleration
	var speedIncrease: float #this is the actual increase in speed in the specified amount of time (deltaTime)
	
	#derives the current point in acceleration
	accTime = (-smoothingFactor + timeShift*currentSpeed - timeShift*maxSpeed - timeShift)/(currentSpeed - maxSpeed)
	
	#determining the new speed after specified period of time (deltaTime)
	newSpeed = -(accTime + deltaTime + smoothingFactor)/(accTime + deltaTime - timeShift) + maxSpeed + 1
	
	#determines raw increase in speed so that it can be modified before addition to actual speed
	speedIncrease = newSpeed - currentSpeed
	
	return speedIncrease

func GetMaxSpeed() -> float:
	return maxSpeed
	
func GetMinSpeed() -> float:
	return minSpeed


