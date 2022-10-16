extends KinematicBody2D

var death = 0

var HealthGain = 0
var wayStuck = 0

export var path_to_player := NodePath()
#export var path_to_front := NodePath()

var _velocity := Vector2.ZERO

onready var _agent: NavigationAgent2D = $NavigationAgent2D 
onready var _timer := $Timer
onready var _sprite := $Sprite
###
onready var _player := get_node(path_to_player)

func _ready():
	
	$PlayerSprite/BaseLifeCollitionP2.monitoring=false
	$PlayerSprite/BaseLifeCollitionP2.monitorable=false
	
	_timer.connect("timeout", self, "_update_pathfinding")
	_agent.connect("velocity_computed", self, "move")
	
	death = 0
	$AnimationPlayer.play("AnimPlayer")
	$AnimationPlayer2.play("Aura")
	
	$Node2D/Node2D/Light2D.scale.y = 0

func _physics_process(delta: float) -> void:
	
	
	if _agent.is_navigation_finished():
		return

	var target_global_position := _agent.get_next_location()
	var direction := global_position.direction_to(target_global_position)
	var desired_velocity := direction * _agent.max_speed
	var steering := (desired_velocity - _velocity) * delta * 4.0
	_velocity += steering
	_agent.set_velocity(_velocity)


func _process(delta):
#	$PlayerSprite.position.x = $IAKinematic.position.x
#	$PlayerSprite.position.y = $IAKinematic.position.y
	$Node2D.global_position = $CanvasLayer/FakeNode.global_position

	
	$Aura.position.x = $X_Position.position.x
	$Aura.position.y = $Y_Position.position.y
	
	if Input.is_action_pressed("TurnLeftP2") and !Input.is_action_pressed("TurnRightP2"):
		$PlayerSprite.rotation_degrees= -5.5
	if Input.is_action_pressed("TurnRightP2") and !Input.is_action_pressed("TurnLeftP2"):
		$PlayerSprite.rotation_degrees= 5.5

	if !Input.is_action_pressed("TurnLeftP2") and !Input.is_action_pressed("TurnRightP2"):
		$PlayerSprite.rotation_degrees = 0



	if $Node2D/Node2D/Light2D.scale.y >= 0.5:
		if $PlayerSprite/HeavyBreathing.playing == false:
			$PlayerSprite/HeavyBreathing.playing = true
	else:
		if $PlayerSprite/HeavyBreathing.playing == true:
			$PlayerSprite/HeavyBreathing.playing = false

func _on_BaseLifeCollitionP2_area_entered(area):
	if area.get_name() == "BaseLifeCollitionP1":
		wayStuck = 1
		$Y_Position/Icon2.visible = false
		print("DoorStuck")
	else:
		print("hit")
		death = 1
		$AudioStreamPlayer.play()
		$CanvasLayer/Transition/AnimationPlayer.play("Transition")
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
		
	if $Node2D/Node2D/Light2D.scale.y >= 1:
		$AnimationPlayer3.play("ScenesHit")

func _on_AnimationPlayer3_animation_finished(anim_name):
	get_tree().reload_current_scene()

func move(velocity: Vector2) -> void:
	_velocity = move_and_slide(velocity)
	_sprite.rotation = lerp_angle(_sprite.rotation, velocity.angle(), 10.0 * get_physics_process_delta_time())
	

func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)

