extends TextureRect

export var isAlive = true



func faint():
	isAlive = false
	$ColorRect.visible = true
	pass

