extends Node

class_name SharedFunctions

# function by "thygrrr" taken from: https://www.reddit.com/r/godot/comments/17ccx4y/pass_by_reference/
# function that smoothly transisitions a Vector 3 to a target value.
# derivative is the rate of change for the value.
static func smooth_damp(current : Vector3, target : Vector3, smoothTime : float, deltaTime : float, derivative: Vector3) -> Vector3:
	
	if smoothTime == 0 or target.is_equal_approx(current):
		# Clunky way of writing back the updated value :(
		derivative.x = 0
		derivative.y = 0
		derivative.z = 0
		return target

	var omega := 2.0 / smoothTime

	var x := omega * deltaTime;
	var exp := 1.0 / (1.0 + x + 0.48 * x * x + 0.235 * x * x * x);

	var change := current - target;
	var originalTo = target;

	# Clamp maxSpeed
	#var maxChange = maxSpeed * smoothTime;
	#change = clamp(change, -maxChange, maxChange);
	target = current - change;

	var temp := (derivative + omega * change) * deltaTime
	var derivative_new := (derivative - omega * temp) * exp

	# Clunky way of writing back the updated value :(
	derivative.x = derivative_new.x
	derivative.y = derivative_new.y
	derivative.z = derivative_new.z

	var output = target + (change + temp) * exp
	return output;
