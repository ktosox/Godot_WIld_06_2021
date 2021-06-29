extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 5.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Return_pressed():

	$CrewInspection.visible = false
	if $ButtonSFX.playing == false :
		$ButtonSFX.play()

	pass # Replace with function body.


func _on_LevelSelection_pressed():
	$LevelSelection.visible = true
	if $ButtonSFX.playing == false :
		$ButtonSFX.play()
	pass # Replace with function body.


func _on_CrewInspection_pressed():
	$CrewInspection.visible = true
	if $ButtonSFX.playing == false :
		$ButtonSFX.play()
	pass # Replace with function body.


func _on_MissionSelection_pressed():
	$MissionController.visible = true
	if $ButtonSFX.playing == false :
		$ButtonSFX.play()
	pass # Replace with function body.


func _on_BackToMenu_pressed():
	$MainMenu.visible = true
	if $ButtonSFX.playing == false :
		$ButtonSFX.play()
	pass # Replace with function body.
