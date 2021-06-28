extends "res://Scripts/Character.gd"


var damage

# Called when the node enters the scene tree for the first time.
func _ready():
	$Action.max_value-=randf()
	pass # Replace with function body.

