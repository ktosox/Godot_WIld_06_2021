extends Control


onready var currentState = $VBoxContainer/SelectionCards

var selectedPlanet = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_card_data():
	#get all of the relevant data to cards from 1 to 3 
	pass

func select_level(nr):
	selectedPlanet = nr # + 3 for each planet already beaten by the player
	change_to_confirmation(nr)
	pass

func confirm_selection():
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
	currentState.visible = false
	currentState = $VBoxContainer/LevelDetails
	currentState.visible = true
	$VBoxContainer/TitleText/ConfirmSelection.visible = true
	$VBoxContainer/TitleText/CancelSelection.visible = true
	$VBoxContainer/TitleText/Label.text = "You have selected planet "+String(nr)+",\n should we start the engines?"
	#loading level details for the given level goes here
	pass

func _on_Card1_gui_input(event:InputEvent):
	if(event.is_class("InputEventMouseButton") and event.is_pressed()):
		select_level(1)

func _on_Card2_gui_input(event):
	if(event.is_class("InputEventMouseButton") and event.is_pressed()):
		select_level(2)
	pass # Replace with function body.

func _on_Card3_gui_input(event):
	if(event.is_class("InputEventMouseButton") and event.is_pressed()):
		select_level(3)
	pass # Replace with function body.


func _on_ConfirmSelection_pressed():
	confirm_selection()
	pass # Replace with function body.



func _on_CancelSelection_pressed():
	change_to_selection()
	pass # Replace with function body.
