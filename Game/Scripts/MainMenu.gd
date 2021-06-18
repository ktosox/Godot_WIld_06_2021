extends ColorRect


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
	if $TestEffect.playing == false :
		$TestEffect.play()
	pass # Replace with function body.


func _on_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master") ,value)
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().free()
	pass # Replace with function body.


func _on_Credits_pressed():
	print("game made by Ktosox and Ikuti")
	pass # Replace with function body.


func _on_Start_pressed():
	$LayoutV/LayoutH/Buttons/Start.text = "CONTINUE"
	visible = false
	pass # Replace with function body.
