extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music") ,value)
	pass # Replace with function body.


func _on_Effects_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects") ,value)
	pass # Replace with function body.


func _on_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master") ,value)
	pass # Replace with function body.
