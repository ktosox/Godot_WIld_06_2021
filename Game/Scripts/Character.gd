extends TextureRect

export var isAlive = true

var savedDamage = 0

func lose_health(health):
	savedDamage = health
	$DamageTimer.start()
	pass

func apply_damage():
	$Health.value -= savedDamage
	if $Health.value <= 0.0:
		faint()
	pass


func faint():
	isAlive = false
	$ColorRect.visible = true
	pass

