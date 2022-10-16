extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.visible = 0
	$Node2D/Bar.scale.x = 0
	
func _physics_process(delta):
	
	#Changes the order when the front player. With its apropiate Z node index.
	if $PlayerONE/PlayerSprite/Recuperandoce.visible == true:
		var PlayerNode = get_node("PlayerONE")
		move_child(PlayerNode, get_node("PlayerONE2").get_index() + 1)
	else:
		var PlayerNode = get_node("PlayerONE")
		move_child(PlayerNode, get_node("PlayerONE2").get_index() - 1)

	


func _on_Timer_timeout():
	$Node2D/Bar.scale.x += 0.01875
	
	
	#Win screen things
	if $Node2D/Bar.scale.x >= 1:
		$PauseMenu.pause = true
		$WinScreenMenu/WinAnim.play("WinAnim")
		$WinScreenMenu/TextBlinkAnim.play("GoalReminderAnim")
		$WinScreenMenu/WinningSound.play()
		$PauseMenu.pause_mode = Node.PAUSE_MODE_INHERIT
		get_tree().paused = true
		$PauseMenu.pause_mode = Node.PAUSE_MODE_INHERIT




func _on_TextureButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

