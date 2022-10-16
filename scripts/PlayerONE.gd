extends Node2D

var death = 0

var HealthGain = 0
var wayStuck = 0
var tired = true

func _ready():
	death = 0
	$AnimationPlayer.play("AnimPlayer")
	$AnimationPlayer2.play("Aura")
	
	$Node2D/Node2D/Light2D.scale.y = 0

	
#	$AnimationPlayer3.play("FixDangModulateError")

func _process(delta):
	$PlayerSprite.position.x = $X_Position.position.x
	$PlayerSprite.position.y = $Y_Position.position.y
	
	$Aura.position.x = $X_Position.position.x
	$Aura.position.y = $Y_Position.position.y
	
	
	if Input.is_action_pressed("TurnLeft") and !Input.is_action_pressed("TurnRight"):
		$PlayerSprite.rotation_degrees= -5.5
	if Input.is_action_pressed("TurnRight") and !Input.is_action_pressed("TurnLeft"):
		$PlayerSprite.rotation_degrees= 5.5

	if !Input.is_action_pressed("TurnLeft") and !Input.is_action_pressed("TurnRight"):
		$PlayerSprite.rotation_degrees = 0

func _physics_process(delta):
	if Input.is_action_just_released("BellRing"):
		$PlayerSprite/BellRing.play()

	if $Node2D/Node2D/Light2D.scale.y >= 0.5:
		if $PlayerSprite/HeavyBreathing.playing == false:
			$PlayerSprite/HeavyBreathing.playing = true
	else:
		if $PlayerSprite/HeavyBreathing.playing == true:
			$PlayerSprite/HeavyBreathing.playing = false


func _on_BaseLifeCollitionP1_area_entered(area):
	if area.get_name() == "BaseLifeCollitionP2":
		wayStuck = 1
		$Y_Position/Icon2.visible = false
		print("DoorStuck")
	else:
		print("hit")
		$AudioStreamPlayer.play()
		$AnimationPlayer3.play("scenesHit")
		$Transition/AnimationPlayer.play("Transition")
		death = 1
func _on_BaseLifeCollitionP1_area_exited(area):
	if area.get_name() == "BaseLifeCollitionP2":
		$Y_Position/Icon2.visible = true
		wayStuck = 0



func _on_AntiAura_area_entered(area):
	if area.get_name() == "PuntosStaminaP2":
		$PlayerSprite/Recuperandoce.visible = true
		HealthGain = 1
		$Aura.visible = false
		$Y_Position/Under.visible = false
	
	
func _on_AntiAura_area_exited(area):
	if area.get_name() == "PuntosStaminaP2":
		$Aura.visible = true
		$PlayerSprite/Recuperandoce.visible = false
		HealthGain = 0
		
		$Y_Position/Under.visible = true

func _on_Timer_timeout():
	if HealthGain == 1 and $Node2D/Node2D/Light2D.scale.y >= 0:
		$Node2D/Node2D/Light2D.scale.y -= 0.02
	else:
		$Node2D/Node2D/Light2D.scale.y += 0.01
	
	if $Node2D/Node2D/Light2D.scale.y >= 1:
		$AnimationPlayer3.play("scenesHit")



func _on_AnimationPlayer3_animation_finished(anim_name):
	get_tree().reload_current_scene()
