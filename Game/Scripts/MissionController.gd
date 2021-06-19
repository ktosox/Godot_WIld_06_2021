extends Control

var characterScene = preload("res://MissionScene/Character.tscn")

var crewPanel = preload("res://MissionScene/CrewPanel.tscn")

var steps = [1,2]

var currentStep = -1 #represents postion in "steps" Array

var isInCombat = false

var missionStarted = false

var selectedCrew = []

var enemyStats = []

func _ready():
	#load_next_step()
	pass # Replace with function body.

func _process(delta):
	if missionStarted:
		if !isInCombat :
			$MissionScreen/ProgressBar.value += delta
		if $MissionScreen/ProgressBar.value >= $MissionScreen/ProgressBar.max_value :
			load_next_step()


func load_next_step():
	$MissionScreen/ProgressBar.value = 0
	if(currentStep+1 > steps.size()):
		mission_complete()
		return
	# call #start_action() on Crew if is needed
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		c.start_action()
	print("starting step "+String(currentStep))
	#logic for loading mission data goes here
	#$MissionScreen/LayoutH/Background.texture = load(steps[currentStep].backgroundType)
	#$MissionScreen/LayoutH/DetailMenu/Layout/Label.text = steps[currentStep].description
	#$MissionScreen/ProgressBar.max_value = steps[currentStep].amount
	
	currentStep+=1 #add one once step is loaded

		
	pass

func mission_complete():
	missionStarted = false
	pass

func select_action(chara): 
	# check isInCombat to determine if this should be a mission or a combat action
	if isInCombat :
#		CrewSingleton.GetCrewmate(chara.ID).GetPerks()
# next - pick an action from the action stack based on random number * weight
		crew_combat(chara)
	else:
		mission_progress(chara)

	pass

func mission_progress(chara):
	var progress = 1 + randi()%2
	var keyStat
	match steps[currentStep].stepType:
		"Time":
			progress = 0
			pass
		"Tech":
			progress += CrewSingleton.GetCrewmate(chara).technologyKnowledge
			pass
		"Xeno":
			progress +=  CrewSingleton.GetCrewmate(chara).alienKnowledge
			pass
		"People":
			progress +=  CrewSingleton.GetCrewmate(chara).peopleSkills
			pass
	 

	$MissionScreen/ProgressBar.value += progress
	if progress !=0 :
		$BubbleTextGenerator.addBubble(String(progress),chara.rect_global_position+(chara.rect_size)/2.0)
	pass

func crew_combat(chara):
	# calculate attack dmg - take character base dmg, calculate rand number, end up with a number
	var damage = round( lerp(0,5,randf())) + CrewSingleton.GetCrewmate(chara.ID).combatProwess
	print(damage)
#	$BubbleTextGenerator.addBubble(String(damage),who.rect_global_position+(who.rect_size)/2.0)
	# add modifiers from the attack stack (should be listed on character)
	for i in CrewSingleton.GetCrewmate(chara.ID).GetPerks:
		if i.PerkTag == "Attack" :
			print("this effect should be added to dmg ",i)
	# select defender (code below)
	var defender = $MissionScreen/LayoutH/Background/Layout/Badies.get_children()
	if defender.size() == 0 :
		print ("error, no defenedrs present, quiting combat")
		return
	else:
		defender = defender[randi()%defender.size()] #select one defender
	defender.get_node("Health").value-=damage
	if defender.get_node("Health").value <= 0 :
		defender.queue_free()
	# deal damage (apply_damage(dmg,defender))
	# clean up
	pass
func enemy_combat(who):
	
	pass


func start_encounter():
	isInCombat = true
	$MissionProgressTimer.stop()
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		c.start_action()
	#add badies
	enemyStats = steps[currentStep].enemies
	for b in enemyStats:
		var enemyChar = characterScene.instance()
		enemyChar.get_node("Action").visible = false
		enemyChar.get_node("Health").max_value = b[0]
		$MissionScreen/LayoutH/Background/Layout/Badies.add_child(enemyChar)
	# get the encounter description from the step scene
	# create characterScene scenes for each enemy, set them as described in step
	# don't forget to attach the signals from enemies so that the enemy combat function is called
	# plan B - set the controller on each character scene and replace the signals with a call to this scene
	pass

func load_crew_selection():
	$MissionScreen.visible = false
	$CrewSelection.visible = true
	if get_parent().selectedPlanet == -1:
		$CrewSelection/ConfirmationScreen/Label.text = "please first select a mission"
		return
	else:
		$CrewSelection/ConfirmationScreen/Label.text = "please select 3 crewmates \n to send on this mission"
		

	for p in CrewSingleton.crewmates.size() :

		var newPanel = crewPanel.instance()
		newPanel.load_crew(p)
		newPanel.manager = self
		$CrewSelection/CrewBox/VBoxContainer.add_child(newPanel)
		$CrewSelection/CrewBox/VBoxContainer.move_child($CrewSelection/CrewBox/VBoxContainer.get_node("EmptySpace"),$CrewSelection/CrewBox/VBoxContainer.get_child_count())
	pass

func toggleCrew(who):
	if who.selected == false and selectedCrew.size()<3:
		who.select()
		selectedCrew.push_back(who.ID)
	elif who.selected == true :
		who.deselect()
		selectedCrew.erase(who.ID)
		$CrewSelection/ConfirmationScreen/StartMission.visible = false
	if selectedCrew.size() == 3 :
		$CrewSelection/ConfirmationScreen/StartMission.visible = true
	pass

func start_mission():
	print(selectedCrew)
	var planetID = get_parent().selectedPlanet
	if planetID == -1 :
		return
		print("can't start since no planet selected")
	missionStarted = true
	steps = PlanetsSingleton.GetPlanet(planetID).get_children()
	print(steps)
	$CrewSelection.visible = false
	$MissionScreen.visible = true
	var order = 0
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		c.load_character(selectedCrew[order])
		order +=1
	load_next_step()
	
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



func _on_StartMission_pressed():
	start_mission()
	pass # Replace with function body.


func _on_MissionController_visibility_changed():
	if !missionStarted :
		load_crew_selection()
	else:
		$CrewSelection.visible = true
		$MissionScreen.visible = false
	pass # Replace with function body.


func _on_Return_pressed():
	visible = false
	pass # Replace with function body.
