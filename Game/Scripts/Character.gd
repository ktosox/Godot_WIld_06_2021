extends ColorRect

signal action(ID)

var isAlive = true

var ID


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func load_character(ID):
	ID = ID
	#set character sprite
	#set HP
	#$AnimateAction.playback_speed = 1.0/crew.speed #adjust the speed of the attack timer
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
	pass

func action():
	emit_signal("action",self)
	print("pow")
	pass