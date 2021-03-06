extends "res://Scripts/Character.gd"

var ID

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func load_character(ID):
	$ColorRect.visible = false
	self.ID = ID
	var crew = CrewSingleton.crewmates[ID]
	texture = load(crew.pathToImage)
	$Health.max_value = crew.maxHealth
	$Health.value = crew.currentHealth
	$Action.max_value = crew.speed + randf()*0.5


func _on_DamageTimer_timeout():
	apply_damage()
	pass # Replace with function body.
