extends Node2D

#default difficulty. But it gets edited in the diferent scenes.
export var difficulty = 1
export var ObstaclesVelocity = 1.0
var rng = RandomNumberGenerator.new()
var my_random_number = rng.randi_range(1, 5)


var ob1Dir
var ob1;

################################################################################################

func _ready():
	if difficulty == 1:
		$Music/L1.play()
	elif difficulty == 2:
		$Music/L2.play()
	elif difficulty == 3:
		$Music/L3.play()
	else:
		$Music/L3.play()
	
	
	add_obstaclesChunks()
	$AnimationPlayer.playback_speed = ObstaclesVelocity
	print("Playback speed ", $AnimationPlayer.get_playing_speed())


################################################################################################

func _on_AnimationPlayer_animation_finished(anim_name):

	#Deletes all Nodes in Obstacles Node
	for n in get_node("Obstacles").get_child_count():
		var x = get_node("Obstacles").get_child(n)
		x.queue_free()


	add_obstaclesChunks()


################################################################################################

func add_obstaclesChunks():
	rng.randomize()
	
	print(my_random_number , " number")
	
	#This chooses what PremadeObstacles will be available in each difficulty
	if difficulty ==1:
		my_random_number = rng.randi_range(1, 10)
	elif difficulty ==2:
		my_random_number = rng.randi_range(5, 15)
	else:
		my_random_number = rng.randi_range(10, 20)

	#This dinamically changes the path where is picking random obstacle chunks
	ob1Dir = ("res://scenes/ObstaclesOnTheRoad/Obstacles" + str(my_random_number) + ".tscn")
	ob1 = load(ob1Dir)
	
	#The ObstacleChunk gets added to the Obstacles Node
	get_node("Obstacles").add_child(ob1.instance())
	
	print(difficulty, "dificulty dsf")
	
	
	
	$AnimationPlayer.play("Obstacles venida")
