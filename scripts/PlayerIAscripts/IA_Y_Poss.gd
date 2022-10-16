extends KinematicBody2D

export var speed = 1
export var acceleration = 4
export var DeAcceleration = 20
export var maxspeed = 190


func _physics_process(delta):

	var input_vector = Vector2(Input.get_action_strength("TurnRightP2") - Input.get_action_strength("TurnLeftP2"),
	 Input.get_action_strength("brakeP2") - Input.get_action_strength("accelerateP2"))
	
	var move_direction = input_vector.normalized()
	move_direction.x = 0
	
	if Input.is_action_pressed("accelerateP2") or Input.is_action_pressed("brakeP2"):
		speed = speed + acceleration
		speed = min(speed,maxspeed)
	else:
		speed = speed - DeAcceleration
		speed = max(speed,1)
		
		
	if $Under.visible == false and $Icon2.visible == false:
		if move_direction.y > 0:
			move_and_slide((speed*acceleration) * move_direction)
	elif $Under.visible == true and $Icon2.visible == false:
		if move_direction.y < 0:
			move_and_slide((speed*acceleration) * move_direction)
	else:
		move_and_slide((speed*acceleration) * move_direction)
