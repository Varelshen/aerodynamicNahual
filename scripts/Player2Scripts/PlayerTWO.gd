extends Node2D

var death = 0

var HealthGain = 0
var wayStuck = 0

func _ready():
	death = 0
	$AnimationPlayer.play("AnimPlayer")
	$AnimationPlayer2.play("Aura")
	
	$Node2D/Node2D/Light2D.scale.y = 0

func _process(delta):
	$PlayerSprite.position.x = $X_Position.position.x
	$PlayerSprite.position.y = $Y_Position.position.y
	
	$Aura.position.x = $X_Position.position.x
	$Aura.position.y = $Y_Position.position.y
	
	if Input.is_action_pressed("TurnLeftP2") and !Input.is_action_pressed("TurnRightP2"):
		$PlayerSprite.rotation_degrees= -5.5
	if Input.is_action_pressed("TurnRightP2") and !Input.is_action_pressed("TurnLeftP2"):
		$PlayerSprite.rotation_degrees= 5.5

	if !Input.is_action_pressed("TurnLeftP2") and !Input.is_action_pressed("TurnRightP2"):
		$PlayerSprite.rotation_degrees = 0

func _physics_process(delta):

	if $Node2D/Node2D/Light2D.scale.y >= 0.5:
		if $PlayerSprite/HeavyBreathing.playing == false:
			$PlayerSprite/HeavyBreathing.playing = true
	else:
		if $PlayerSprite/HeavyBreathing.playing == true:
			$PlayerSprite/HeavyBreathing.playing = false

	if Input.is_action_just_released("BellRingP2"):
		$PlayerSprite/BellRing.play()

func _on_BaseLifeCollitionP2_area_entered(area):
	if area.get_name() == "BaseLifeCollitionP1":
		wayStuck = 1
		$Y_Position/Icon2.visible = false
		print("DoorStuck")
	else:
		print("hit")
		death = 1
		$AudioStreamPlayer.play()
		$Transition/AnimationPlayer.play("Transition")
		$AnimationPlayer3.play("ScenesHit")

func _on_BaseLifeCollitionP2_area_exited(area):
	if area.get_name() == "BaseLifeCollitionP1":
		$Y_Position/Icon2.visible = true
		wayStuck = 0


func _on_AntiAura_area_entered(area):
	if area.get_name() == "PuntosStamina":
		$Aura.visible = false
		$PlayerSprite/Recuperandoce.visible = true
		HealthGain = 1
		
		$Y_Position/Under.visible = false
		
func _on_AntiAura_area_exited(area):
	if area.get_name() == "PuntosStamina":
		$Aura.visible = true
		$PlayerSprite/Recuperandoce.visible = false
		HealthGain = 0

		$Y_Position/Under.visible = true


func _on_Timer_timeout():
	if HealthGain == 1 and $Node2D/Node2D/Light2D.scale.y >= 0:
		$Node2D/Node2D/Light2D.scale.y -= 0.02
	else:
		$Node2D/Node2D/Light2D.scale.y += 0.01
		



func _on_AnimationPlayer3_animation_finished(anim_name):
	get_tree().reload_current_scene()
