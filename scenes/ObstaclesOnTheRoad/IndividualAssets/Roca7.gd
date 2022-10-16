extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$NavigationObstacle2D.estimate_radius = true
	print($NavigationObstacle2D.is_radius_estimated()," radius estimated")
