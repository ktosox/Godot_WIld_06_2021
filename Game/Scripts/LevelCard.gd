extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_card(ID):
	#$LayoutV/Name.text = #get name
	#$LayoutV/Planet.texture = #get the planet texture
	#$LayoutV/Control3/Minutes.text = # get minutes
	pass


func _on_LevelCard_mouse_entered():
	modulate = ColorN("darkseagreen")
	pass # Replace with function body.


func _on_LevelCard_mouse_exited():
	modulate = ColorN("White")
	pass # Replace with function body.
