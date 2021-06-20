extends Node2D

var missionsBeaten = 0

var selectedPlanet = -1

var abortReady = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 10.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if $CPUParticles2D.speed_scale < 1 :
		$CPUParticles2D.speed_scale = 1
	else:
		$CPUParticles2D.speed_scale = 0.06
	pass # Replace with function body.


func _on_Return_pressed():

	$CrewInspection.visible = false

	pass # Replace with function body.


func _on_LevelSelection_pressed():
	$LevelSelection.visible = true
	pass # Replace with function body.


func _on_CrewInspection_pressed():
	$CrewInspection.visible = true
	pass # Replace with function body.


func _on_MissionSelection_pressed():
	$MissionController.visible = true
	pass # Replace with function body.


func _on_BackToMenu_pressed():
	$MainMenu.visible = true
	pass # Replace with function body.
