extends Control


onready var currentState = $VBoxContainer/SelectionCards

var selectedPlanet = -1

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func load_card_data():
	var cardID = GS.missionsBeaten*3
	for z in $VBoxContainer/SelectionCards.get_children() :
		cardID+=1
		z.load_card(cardID)
		


func select_level(nr):
	selectedPlanet = nr
	change_to_confirmation(nr)
	pass

func confirm_selection():
	print("player selected planet "+String(selectedPlanet))
	GS.selectedPlanet = selectedPlanet
	$VBoxContainer/TitleText/ConfirmSelection.visible = false
	$VBoxContainer/TitleText/CancelSelection.visible = false
	$VBoxContainer/TitleText/Label.text = "Course set! Please go to the mission screen"
	#whatever call to the global singleton needs to be made to mave the machine forward should go here
	pass

func change_to_selection():
	currentState.visible = false
	currentState = $VBoxContainer/SelectionCards
	currentState.visible = true
	$VBoxContainer/TitleText/ConfirmSelection.visible = false
	$VBoxContainer/TitleText/CancelSelection.visible = false
	$VBoxContainer/TitleText/Label.text = "please select the next planet"
	pass

func change_to_confirmation(nr):
	$VBoxContainer/LevelDetails/LevelCard.load_card(nr)
	currentState.visible = false
	currentState = $VBoxContainer/LevelDetails
	currentState.visible = true
	$VBoxContainer/TitleText/ConfirmSelection.visible = true
	$VBoxContainer/TitleText/CancelSelection.visible = true
	$VBoxContainer/TitleText/Label.text = "Should we set a course to "+PlanetsSingleton.GetPlanet(nr).name+", Captain?"
	$VBoxContainer/LevelDetails/Control/Label.text = PlanetsSingleton.GetPlanet(nr).planetDescription
	pass

func _on_Card1_gui_input(event:InputEvent):
	if(event.is_class("InputEventMouseButton") and event.is_pressed()):
		$VBoxContainer/SelectionCards/Card1.emit_signal("mouse_exited")
		select_level($VBoxContainer/SelectionCards/Card1.planetID)

func _on_Card2_gui_input(event):
	if(event.is_class("InputEventMouseButton") and event.is_pressed()):
		$VBoxContainer/SelectionCards/Card2.emit_signal("mouse_exited")
		select_level($VBoxContainer/SelectionCards/Card2.planetID)
	pass # Replace with function body.

func _on_Card3_gui_input(event):
	if(event.is_class("InputEventMouseButton") and event.is_pressed()):
		$VBoxContainer/SelectionCards/Card3.emit_signal("mouse_exited")
		select_level($VBoxContainer/SelectionCards/Card3.planetID)
	pass # Replace with function body.


func _on_ConfirmSelection_pressed():
	confirm_selection()
	pass # Replace with function body.



func _on_CancelSelection_pressed():
	change_to_selection()
	pass # Replace with function body.


func _on_Return_pressed():
	visible = false
	pass # Replace with function body.


func _on_LevelSelection_visibility_changed():

	if visible == true :
		load_card_data()
		if GS.selectedPlanet != selectedPlanet:
			change_to_selection()
	pass # Replace with function body.
