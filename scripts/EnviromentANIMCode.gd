extends Node2D

export var velocityBackground = 1.620
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.playback_speed = velocityBackground
	$AnimationPlayer.play("MoveAsphalt")
#	$AnimationPlayer2.play("Parallax")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
