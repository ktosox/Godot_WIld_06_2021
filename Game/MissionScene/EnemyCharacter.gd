extends "res://Scripts/Character.gd"


var damage

# Called when the node enters the scene tree for the first time.
func _ready():
	$Action.max_value-=randf()
	pass # Replace with function body.

func un_faint():
	visible = true
	isAlive = true
	$ColorRect.visible = false
	pass


func _on_DamageTimer_timeout():
	apply_damage()
	pass # Replace with function body.
