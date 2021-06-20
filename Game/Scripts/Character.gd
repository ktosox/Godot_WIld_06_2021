extends TextureRect

signal action(ID)

var isAlive = true

var ID

var manager

var enemyDmg = 0


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func load_character(ID):
	$ColorRect.visible = false
	ID = ID
	var crew = CrewSingleton.crewmates[ID]
	texture = load(crew.pathToImage)
	$Health.max_value = crew.maxHealth
	$Health.value = crew.currentHealth
	$AnimateAction.playback_speed = 1.0/crew.speed #adjust the speed of the attack timer
	pass


func start_action():
	if isAlive and !$AnimateAction.is_playing():
		$AnimateAction.play("Animate")
	pass

func end_action():
	$AnimateAction.stop()
	pass

func faint():
	#I guess modualte the portrati?
	isAlive = false
	$AnimateAction.stop()
	$ColorRect.visible = true
	pass

func action():
	if manager!= null :
		manager.enemy_combat(self)
	else:
		emit_signal("action",self)
	pass
