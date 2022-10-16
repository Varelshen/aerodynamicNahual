extends Node2D

var changePos = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.visible = 0
	$Node2D/Bar.scale.x = 0
	
func _process(delta):
	
	if Input.is_action_just_released("ChangePositions") and changePos == 1:
		$Navigation2D/NavigationPolygonInstance2.position.x =883
		$Navigation2D/NavigationPolygonInstance2.position.y =858
		$CambioRequest.play()
		$Node2D2/CambioArrowsAnim.play("ChangeRedUp")
		changePos=0
		print("abajo")
	elif Input.is_action_just_released("ChangePositions") and changePos == 0:
		$Navigation2D/NavigationPolygonInstance2.position.x =883
		$Navigation2D/NavigationPolygonInstance2.position.y =360
		print("arriba")
		$CambioRequest.play()
		$Node2D2/CambioArrowsAnim.play("CambioDirectionIA")
		changePos=1
	
#	$Navigation2D/PlayerONE2/Node2D.position.x = 0
#	$Navigation2D/PlayerONE2/Node2D.position.y = 0
#

	
	$IAPositionBack.global_position = $Navigation2D/PlayerONE/X_Position.global_position
#	$IAPositionBack.position.y = $PlayerONE/Y_Position.global_position

func _physics_process(delta):
	
	#Changes the order when the front player. With its apropiate Z node index.
	if $Navigation2D/PlayerONE/PlayerSprite/Recuperandoce.visible == true:
		var PlayerNode = get_node("Navigation2D/PlayerONE")
		get_node("Navigation2D").move_child(PlayerNode, get_node("Navigation2D/PlayerONE2").get_index() + 1)
	else:
		var PlayerNode = get_node("Navigation2D/PlayerONE")
		get_node("Navigation2D").move_child(PlayerNode, get_node("Navigation2D/PlayerONE2").get_index() - 1)

#	if Input.is_action_just_pressed("EscBack"):
#		if $PauseMenu.visible == true:
#			$PauseMenu/UIanims.play("PauseHide")
#		if $PauseMenu.visible == false:
#			$PauseMenu/UIanims.play("PauseShown")

#		get_tree().paused = true


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

