extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func select_level(nr):
	print(nr)
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
