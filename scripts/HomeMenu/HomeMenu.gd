extends Node2D

var currentScreen = 0
var humanP2active = 0
var diffSlection = 1

var rng = RandomNumberGenerator.new()
var my_random_number = rng.randi_range(1, 5)

func _ready():
	$MainMenuMusic.play()
	
	$"1Screen".visible = true
	$"2Screen".visible = false
	$"3Screen".visible = false
	
	if OS.window_fullscreen == true:
		$FullScreenPressed.visible = true
	if OS.window_fullscreen == false:
		$FullScreenPressed.visible = false



func _process(delta):
	if Input.is_action_just_pressed("EscBack") and currentScreen > 1:
		currentScreen -= 1

	if currentScreen == 1:
		$"1Screen".visible = true
		$"2Screen".visible = false

	if currentScreen == 2:
		$"1Screen".visible = false
		$"2Screen".visible = true

	if currentScreen == 3:
		$"1Screen".visible = false
		$"2Screen".visible = false
		$"3Screen".visible = true

func _physics_process(delta):
	$Niebla3MainMenu.rotation_degrees += 0.07


func _on_Play_pressed():
	currentScreen = 2
#	get_tree().change_scene("res://scenes/Level1.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_TextureButton_pressed():
	OS.window_fullscreen = ! OS.window_fullscreen
	if OS.window_fullscreen == true:
		$FullScreenPressed.visible = true
	if OS.window_fullscreen == false:
		$FullScreenPressed.visible = false


func _on_Multiplayer_pressed():
	currentScreen = 3
	humanP2active = 1


func _on_SinglePlayer_pressed():
	currentScreen = 3
	humanP2active = 0


func _on_Normal_pressed():
	if humanP2active == 0:
		get_tree().change_scene("res://scenes/IAScenes/Level1_IA.tscn")
	else:
		get_tree().change_scene("res://scenes/Level1.tscn")
	diffSlection = 1

func _on_Hard_pressed():
	if humanP2active == 0:
		get_tree().change_scene("res://scenes/IAScenes/Level2_IA.tscn")
	else:
		get_tree().change_scene("res://scenes/Level2.tscn")
	diffSlection = 2

func _on_KAIBIL_pressed():
	if humanP2active == 0:
		get_tree().change_scene("res://scenes/IAScenes/Level3_IA.tscn")
	else:
		get_tree().change_scene("res://scenes/Level3.tscn")
	diffSlection = 3


########################################Calling Random song to be played
func _on_Play_mouse_entered():
	playRamdonSong()
func _on_Exit_mouse_entered():
	playRamdonSong()
########################################Calling Random song to be played
func _on_SinglePlayer_mouse_entered():
	playRamdonSong()
func _on_Multiplayer_mouse_entered():
	playRamdonSong()
########################################Calling Random song to be played
func _on_Normal_mouse_entered():
	playRamdonSong()
func _on_Hard_mouse_entered():
	playRamdonSong()
func _on_KAIBIL_mouse_entered():
	playRamdonSong()

func playRamdonSong():
	rng.randomize()
	my_random_number = rng.randi_range(1, 5)
	if my_random_number == 1:
		$ButtomSounds/ButtonSound.play()
	elif my_random_number == 2:
		$ButtomSounds/ButtonSound2.play()
	elif my_random_number == 3:
		$ButtomSounds/ButtonSound3.play()
	elif my_random_number == 4:
		$ButtomSounds/ButtonSound4.play()
	else:
		$ButtomSounds/ButtonSound5.play()


func _on_Cinematica_mouse_entered():
	playRamdonSong()


func _on_Cinematica_pressed():
	get_tree().change_scene("res://scenes/Cinematic.tscn")
	pass # Replace with function body.
