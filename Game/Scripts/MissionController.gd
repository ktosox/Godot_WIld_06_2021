extends Control


var characterScene = preload("res://MissionScene/Character.tscn")



var steps = [1,2]

var currentStep = -1 #represents postion in "steps" Array

var isInCombat = false

var missionStarted = false



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
	if GS.abortReady :
		$MissionScreen/LayoutH/DetailMenu/Recall.visible = true
	else:
		$MissionScreen/LayoutH/DetailMenu/Recall.visible = false
	currentStep+=1 
	$MissionScreen/ProgressBar.value = 0
	if(currentStep+1 > steps.size()):
		mission_complete()
		return
	# call #start_action() on Crew if is needed
		
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		if steps[currentStep].stepType == 1 :
			c.end_action()
		else:
			c.start_action()
	print("starting step "+String(currentStep))
	
	#logic for loading mission data goes here
	$MissionScreen/LayoutH/Background.texture = load(steps[currentStep].backgroundType)
	$MissionScreen/LayoutH/DetailMenu/Layout/Label.text = steps[currentStep].description
	$MissionScreen/ProgressBar.max_value = steps[currentStep].amount
	if steps[currentStep].stepType == 0 :
		start_encounter()
	#add one once step is loaded
		
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
		1:
			progress = 0
			pass
		2:
			progress += CrewSingleton.GetCrewmate(chara).technologyKnowledge
			pass
		3:
			progress +=  CrewSingleton.GetCrewmate(chara).alienKnowledge
			pass
		4:
			progress +=  CrewSingleton.GetCrewmate(chara).peopleSkills
			pass
	 

	$MissionScreen/ProgressBar.value += progress
	if progress !=0 :
		$BubbleTextGenerator.addBubble(String(progress),chara.rect_global_position+(chara.rect_size)/2.0)
	pass

func crew_combat(chara):
	# calculate attack dmg - take character base dmg, calculate rand number, end up with a number
	var damage = round( lerp(0,5,randf())) + CrewSingleton.GetCrewmate(chara.ID).combatProwess
	#print(damage)
#	$BubbleTextGenerator.addBubble(String(damage),who.rect_global_position+(who.rect_size)/2.0)
	# add modifiers from the attack stack (should be listed on character)
	for i in CrewSingleton.GetCrewmate(chara.ID).GetPerks():
		if i.perkTag == 2 :
			print("this effect should be added to dmg ",i)
	# select defender (code below)
	var defender = $MissionScreen/LayoutH/Background/Layout/Badies.get_children()
	if defender.size() == 0 :
		check_for_combat_end()
		return
	else:
		defender = defender[randi()%defender.size()] #select one defender
	defender.get_node("Health").value-=damage
	if defender.get_node("Health").value <= 0 :
		defender.queue_free()
		call_deferred("check_for_combat_end")


func enemy_combat(who):
	var damage = who.enemyDmg
	var c = $MissionScreen/LayoutH/Background/Layout/Crew.get_children()
	c = c[randi()%c.size()]
	CrewSingleton.GetCrewmate(c.ID).currentHealth-=damage
	c.get_node("Health").value-=damage
	if c.get_node("Health").value <1 :
		c.faint()
	var crewAlive = 0
	for b in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		if b.isAlive :
			crewAlive+=1
	if crewAlive <1:
		mission_lost()
	#acceess the crew hp by the singleton
	# updated hp on crew panel
	# check for crew death
	pass

func check_for_combat_end():

	if  $MissionScreen/LayoutH/Background/Layout/Badies.get_child_count()<2:
		end_encounter()
	pass


func start_mission():
	$MissionScreen/EncounterTimer.start()
	var planetID = GS.selectedPlanet
	if planetID == -1 :
		return
		print("can't start since no planet selected")
	missionStarted = true
	steps = PlanetsSingleton.GetPlanet(planetID).get_children()
	
	$CrewSelection.visible = false
	$MissionScreen.visible = true
	var order = 0
	var selectedCrew = $CrewSelection.get_selected_crew()
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		c.load_character(selectedCrew[order])
		order +=1
	load_next_step()
	
	pass

func start_encounter():
	isInCombat = true
	#$MissionProgressTimer.stop()
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		c.start_action()
	#add badies
	enemyStats = steps[currentStep].enemies
	for b in enemyStats:
		var enemyChar = characterScene.instance()
#		enemyChar.get_node("Action").visible = false
		enemyChar.start_action()
		enemyChar.get_node("AnimateAction").playback_speed = 0.35 + randf() * 0.25
		enemyChar.get_node("Health").max_value = b[1]
		enemyChar.enemyDmg = b[0]
		enemyChar.texture = load(b[2])
		enemyChar.manager = self
		$MissionScreen/LayoutH/Background/Layout/Badies.add_child(enemyChar)

	# don't forget to attach the signals from enemies so that the enemy combat function is called
	# plan B - set the controller on each character scene and replace the signals with a call to this scene
	pass

func end_encounter():
#	for b in $MissionScreen/LayoutH/Background/Layout/Badies.get_children() :
#		b.queue_free()
	isInCombat = false

	if steps[currentStep].stepType == 1 :
			for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
				c.end_action()
		
	$MissionScreen/EncounterTimer.start()
	pass

func mission_complete():
	for p in CrewSingleton.crewmates :
		if p.currentHealth < p.maxHealth :
			p.currentHealth = min(p.maxHealth,p.currentHealth + p.maxHealth*0.4 )
	CurrencySingleton.currentCurrency+=100
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		c.end_action()
	GS.abortReady = true
	GS.missionsBeaten += 1
	GS.selectedPlanet = -1
	$MissionScreen/EncounterTimer.stop()
	missionStarted = false
	$WinScreen.visible = true
	pass

func mission_lost():
	$LoseScreen.visible = true
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		c.end_action()
	pass

func abort_mission():
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		c.end_action()
	missionStarted = false
	$AbortScreen.visible = true
	$MissionScreen/EncounterTimer.stop()
	GS.abortReady = false
	missionStarted = false
	pass

func reset_mission_scene():
	$CrewSelection/ConfirmationScreen/StartMission.visible = false
	for z in $CrewSelection/CrewBox/VBoxContainer.get_children():
		if z.name != "EmptySpace":
			z.queue_free()
	
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		c.end_action()
	isInCombat = false
	currentStep = -1
	$CrewSelection.reset_crew()
	$CrewSelection.visible = true
	$MissionScreen.visible = false
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




func _on_MissionController_visibility_changed():
	if !missionStarted :
		$CrewSelection.load_crew_selection()
		$CrewSelection.visible = true
		$MissionScreen.visible = false
	pass # Replace with function body.



func _on_EncounterTimer_timeout():
	if !isInCombat:
		start_encounter()
	pass # Replace with function body.


func _on_Button_pressed():
	$WinScreen.visible = false
	reset_mission_scene()
	visible = false
	pass # Replace with function body.


func _on_Abort_pressed():
	$AbortScreen.visible = false
	reset_mission_scene()
	visible = false
	pass # Replace with function body.


func _on_Recall_pressed():
	abort_mission()
	pass # Replace with function body.


func _on_GameOver_pressed():
	get_tree().change_scene("res://SpaceShip.tscn")
	pass # Replace with function body.
