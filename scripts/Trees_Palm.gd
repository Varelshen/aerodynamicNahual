extends Node2D


export var palmAnimVelocity = 1.35


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer2.playback_speed = palmAnimVelocity
	$AnimationPlayer2.play("TressMovement")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
