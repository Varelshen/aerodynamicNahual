extends Node2D

var pause = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Input.is_action_just_pressed("EscBack"):
#		if $PauseMenu.visible == true:
#			$PauseMenu/UIanims.play("PauseHide")
#		if $PauseMenu.visible == false:
#			$PauseMenu/UIanims.play("PauseShown")

	if Input.is_action_just_pressed("EscBack"):
		if pause == 0:
			$UIanims.play("PauseShown")
			get_parent().get_tree().paused = true
			pause = 1
		elif pause == 1:
			$UIanims.play("PauseHide")
			get_parent().get_tree().paused = false
			pause = 0
	

func _on_Resume_pressed():
	$UIanims.play("PauseHide")
#	get_parent().get_tree().paused = false
	pause = 0
	get_tree().paused = false


func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_MainMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/HomeMenu.tscn")
