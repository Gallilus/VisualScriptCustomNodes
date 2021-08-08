tool
extends VisualScriptCustomFunc

func _init():
	_input_clues = [
			{"name":"start_vel", "value": Vector3.FORWARD},
			{"name":"delta", "value": 0.0},
			{"name":"direction", "value": Vector3.FORWARD},
			{"name":"max_speed", "value": 3.0},
			{"name":"accel", "value": 2.0},
			{"name":"decel", "value": 4.0},
			{"name":"grav_mul", "value": 1.0},
			]
	_output_clues = [{"name":"vel"}]

func _custom_function(velocity, delta, dir, max_speed, accel, decel, grav_mul)->Vector3:
	# Apply gravity.
	var gravity = -ProjectSettings.get_setting("physics/3d/default_gravity")
	velocity.y += delta * gravity * grav_mul

	# Using only the horizontal velocity, interpolate towards the input.
	var hvel = velocity
	hvel.y = 0

	var target = dir * max_speed
	var acceleration
	if dir.dot(hvel) > 0:
		acceleration = accel
	else:
		acceleration = decel

	hvel = hvel.linear_interpolate(target, acceleration * delta)

	# Assign hvel's values back to velocity, and then move.
	velocity.x = hvel.x
	velocity.z = hvel.z

	return velocity
