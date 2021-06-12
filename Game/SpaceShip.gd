extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
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
	$LevelSelection.visible = false
	$CrewInspection.visible = false
	$MissionSelection.visible = false
	pass # Replace with function body.


func _on_LevelSelection_pressed():
	$LevelSelection.visible = true
	pass # Replace with function body.


func _on_CrewInspection_pressed():
	$CrewInspection.visible = true
	pass # Replace with function body.


func _on_MissionSelection_pressed():
	$MissionSelection.visible = true
	pass # Replace with function body.
