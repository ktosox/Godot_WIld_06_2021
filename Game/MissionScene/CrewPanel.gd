extends ColorRect

var ID

var manager

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func select():
	selected = true
	color = ColorN("white")
	pass

func deselect():
	selected = false
	color = ColorN("black")
	pass

func load_crew(ID):
	self.ID = ID
	var crew = CrewSingleton.crewmates[ID]
	$HBoxContainer/Picture.texture = load(crew.pathToImage)
	$HBoxContainer/Label.text = crew.name
	pass

func _on_Panel_gui_input(event):
	if(event.is_action("LMB") and event.is_pressed()):
		manager.toggleCrew(self)
	pass # Replace with function body.
