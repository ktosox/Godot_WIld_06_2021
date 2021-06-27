extends TextureRect

signal action(ID)

export var isAlive = true

var ID

var manager



func start_action():
	if isAlive and !$AnimateAction.is_playing():
		$AnimateAction.play("Animate")
	pass

func end_action():
	$AnimateAction.stop()
	pass

func faint():
	isAlive = false
	end_action()
	$ColorRect.visible = true
	pass

func action():
	emit_signal("action",self)
