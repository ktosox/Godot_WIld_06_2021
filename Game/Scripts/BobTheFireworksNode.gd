extends Node2D

var starScene = preload("res://MissionScene/Star.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fire(start:Vector2,end:Vector2,color = Color(1,1,1,1),count=5):
	for i in count :
		var newStar = starScene.instance()
		newStar.global_position = start
		newStar.curve = Curve2D.new()
		newStar.curve.add_point(Vector2(0,0),Vector2(),smallRand())
		newStar.curve.add_point(end-start,Vector2(),smallRand())
		for n in 2 :
			var middle = newStar.curve.interpolate_baked(newStar.curve.get_baked_length()*(0.4*n))
			newStar.curve.add_point(middle+Vector2(60,0).rotated(randf()*2*PI),smallRand(),smallRand(),n+1)
		newStar.modulate = color
		add_child(newStar)
	pass

func smallRand():
	return Vector2(lerp(-50,50,randf()),lerp(-50,50,randf()))
	pass


func _on_Debug_gui_input(event:InputEvent):
	if event.is_action_pressed("LMB"):
		var target = get_global_mouse_position()+Vector2(300,0).rotated(randf()*2*PI)
		$Debug/Marker.global_position = target
		fire(get_global_mouse_position(),target)
	pass # Replace with function body.
