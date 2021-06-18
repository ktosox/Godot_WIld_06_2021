extends Node2D


export var fillColor = Color(1.0,1.0,1.0)
export var borderColor = Color(0.0,0.0,0.0)


var BubbleTextScene = preload("./BubbleText.tscn")

func addBubble(targetText = "Lorem Ipsum", targetPosition = Vector2(), duration = 2.0):
	var newBubble=BubbleTextScene.instance()
	newBubble.targetText = targetText
	newBubble.position = targetPosition
	newBubble.lifeTime = duration
	newBubble.fillColor = fillColor
	newBubble.borderColor = borderColor
	add_child(newBubble)


func _on_LineEdit_text_entered(new_text):
	addBubble(new_text,$Position2D.global_position)
	pass # Replace with function body.
