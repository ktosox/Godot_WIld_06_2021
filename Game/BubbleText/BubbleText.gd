extends Node2D

export var lifeTime = 2.0
export var targetText = "Lorem Ipsum"
export var fillColor = Color(1.0,1.0,1.0)
export var borderColor = Color(0.0,0.0,0.0)

func _ready():
	var newSpeed = $AnimationPlayer.get_animation("bubble").length/lifeTime
	$AnimationPlayer.playback_speed = newSpeed
	$Text.set_text(targetText)
	$Text.set_indexed("custom_colors/font_color", fillColor)
	$Text.set_indexed("custom_colors/font_color_shadow", borderColor)

func pop():
	self.queue_free()
