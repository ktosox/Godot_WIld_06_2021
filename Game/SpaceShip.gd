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
