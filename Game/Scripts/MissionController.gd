extends Control

var characterScene = preload("res://MissionScene/Character.tscn")

var steps = [1,2]

var currentStep = 0

var isInCombat = false

func _ready():
	load_next_step()
	pass # Replace with function body.

func _process(delta):
	if !isInCombat :
		$MissionScreen/ProgressBar.value += delta
	if $MissionScreen/ProgressBar.value >= $MissionScreen/ProgressBar.max_value :
		load_next_step()


func load_next_step():
	$MissionScreen/ProgressBar.value = 0
	if(currentStep+1 > steps.size()):
		print("mission complete")
		return
	# call #start_action() on Crew if is needed
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		c.start_action()
	print("starting step "+String(currentStep))
	#logic for loading mission data goes here
	#set background
	#update description
	#set maxValue on PrgressBar
	
	currentStep+=1 #add one once step is loaded

		
	pass



func select_action(chara): 
	# check isInCombat to determine if this should be a mission or a combat action
	if isInCombat :
		pass
	else:
		mission_progress(chara)
	# next - pick an action from the action stack based on random number * weight
	pass

func mission_progress(chara):
	var progress = 1
	#add some code here that increases progress based on character skills

	$MissionScreen/ProgressBar.value += progress
	$BubbleTextGenerator.addBubble(String(progress),chara.rect_global_position+(chara.rect_size)/2.0)
	pass

func crew_combat(who):
	# calculate attack dmg - take character base dmg, calculate rand number, end up with a number
	var damage = round( lerp(0,5,randf()))
	print(damage)
#	$BubbleTextGenerator.addBubble(String(damage),who.rect_global_position+(who.rect_size)/2.0)
	# add modifiers from the attack stack (should be listed on character)
	# select defender (code below)
	var defender = $MissionScreen/LayoutH/Background/Layout/Badies.get_children()
	if defender.size() == 0 :
		print ("error, no defenedrs present, quiting combat")
		return
	else:
		defender = defender[randi()%defender.size()] #select one defender
	# check defender for possible defense modifiers
	# deal damage (apply_damage(dmg,defender))
	# clean up
	pass
func enemy_combat(who):
	pass

func apply_damage(dmg, target):
	pass

func start_encounter():
	isInCombat = true
	$MissionProgressTimer.stop()
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		c.start_action()
	#add badies
	# get the encounter description from the step scene
	# create characterScene scenes for each enemy, set them as described in step
	# don't forget to attach the signals from enemies so that the enemy combat function is called
	# plan B - set the controller on each character scene and replace the signals with a call to this scene
	pass

func end_encounter():
	for b in $MissionScreen/LayoutH/Background/Layout/Badies.get_children() :
		b.queue_free()
	isInCombat = false
	pass

func _on_Character1_action(chara):
	select_action(chara)
	pass # Replace with function body.


func _on_Character2_action(chara):
	select_action(chara)
	pass # Replace with function body.


func _on_Character3_action(chara):
	select_action(chara)
	pass # Replace with function body.

