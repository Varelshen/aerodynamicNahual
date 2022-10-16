extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("EscBack"):
		get_tree().change_scene("res://scenes/HomeMenu.tscn")
	pass


func _on_ani_finished():
	get_tree().change_scene("res://scenes/HomeMenu.tscn")
	pass # Replace with function body.
