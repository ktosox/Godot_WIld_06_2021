extends NinePatchRect


var planetID


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_card(ID):
	planetID = ID
	$LayoutV/Name.text = PlanetsSingleton.GetPlanet(ID).name
	$LayoutV/Planet.texture = load(PlanetsSingleton.GetPlanet(ID).pathToImage)
	$LayoutV/Control3/Minutes.text = PlanetsSingleton.GetPlanet(ID).importantPoints
	pass


func _on_LevelCard_mouse_entered():
	modulate = ColorN("darkseagreen")
	pass # Replace with function body.


func _on_LevelCard_mouse_exited():
	modulate = ColorN("White")
	pass # Replace with function body.
