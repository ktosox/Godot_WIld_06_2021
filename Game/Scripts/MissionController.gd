extends Control

var steps = []

var currentStep = -1 #represents postion in "steps" Array

var isInCombat = false

var missionStarted = false

var paused = false


func _ready():
	#load_next_step()
	pass # Replace with function body.

func _process(delta):
	if paused :
		return
	if missionStarted:
		if (steps[currentStep].stepType == 1 or steps[currentStep].stepType == 0)  and !isInCombat:
			$MissionScreen/ProgressBar.value+=delta
		else:
			crew_tick(delta)
		if isInCombat :
			enemy_tick(delta)
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

func crew_tick(delta):
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		if c.isAlive :
			c.get_node("Action").value+=delta
			if c.get_node("Action").value == c.get_node("Action").max_value :
				select_action(c)
				c.get_node("Action").value = 0
	pass

func enemy_tick(delta):
	
	for e in $MissionScreen/LayoutH/Background/Layout/Badies.get_children():
		if e.isAlive :
			e.get_node("Action").value+=delta
			if e.get_node("Action").value == e.get_node("Action").max_value :
				enemy_combat(e)
				e.get_node("Action").value = 0
	pass


func animate_attack(start,end,color):
	paused = true
	$FireworksTimer.start()
	$BobTheFireworksNode.fire(start,end,color,3+randi()%2)
	pass

func mission_progress(chara):
	var progress = 1 + randi()%2
#	var keyStat
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
	var damage = round( lerp(0,2,randf())) + CrewSingleton.GetCrewmate(chara.ID).combatProwess

#	$BubbleTextGenerator.addBubble(String(damage),who.rect_global_position+(who.rect_size)/2.0)
	# add modifiers from the attack stack (should be listed on character)
	for i in CrewSingleton.GetCrewmate(chara.ID).GetPerks():
		if i.perkTag == 2 :
			pass
#			print("this effect should be added to dmg ",i)
	# select defender (code below)
	var defender = $MissionScreen/LayoutH/Background/Layout/Badies.get_children()
	var alive = []
	for d in defender :
		if d.isAlive == true :
			alive.push_back(d)
	defender = alive[randi()%alive.size()] #select one defender
	defender.lose_health(damage)
	animate_attack(Vector2(0,40)+chara.rect_global_position+chara.rect_size/2,defender.rect_global_position+defender.rect_size/2,ColorN("green"))



func enemy_combat(attacker):

	var damage = attacker.damage

	var crew = $MissionScreen/LayoutH/Background/Layout/Crew.get_children()
	var alive = []
	for c in crew :
		if c.isAlive == true :
			alive.push_back(c)
	crew = alive[randi()%alive.size()]

	crew.lose_health(damage)
	
	animate_attack(Vector2(0,40)+attacker.rect_global_position+attacker.rect_size/2,crew.rect_global_position+crew.rect_size/2,ColorN("red"))


	pass

func check_for_combat_end():
	var enemiesAlive = 0
	var crewAlive = 0
	for e in $MissionScreen/LayoutH/Background/Layout/Badies.get_children() :
		if e.isAlive :
			enemiesAlive += 1
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children() :
		if c.isAlive :
			crewAlive += 1
	if enemiesAlive == 0 :
		end_encounter()
	if crewAlive == 0 :
		mission_lost()
	pass


func start_mission():
	$MissionScreen/EncounterTimer.start()
	var planetID = GS.selectedPlanet
	if planetID == -1 :
		print("can't start since no planet selected")
		return
	missionStarted = true
	steps = PlanetsSingleton.GetPlanet(planetID).get_children()
	
	$CrewSelection.visible = false
	$MissionScreen.visible = true
	var order = 0
	var selectedCrew = $CrewSelection.get_selected_crew()
	for c in $MissionScreen/LayoutH/Background/Layout/Crew.get_children():
		c.load_character(selectedCrew[order])

		order +=1
	for e in $MissionScreen/LayoutH/Background/Layout/Badies.get_children():
		e.visible = false
	load_next_step()
	
	pass

func start_encounter():
	isInCombat = true
	var enemyStats = steps[currentStep].enemies

	var count = 0
	for b in enemyStats:
		var enemyChar = $MissionScreen/LayoutH/Background/Layout/Badies.get_child(count)
		enemyChar.un_faint()
		enemyChar.get_node("Health").max_value = b[1]
		enemyChar.get_node("Health").value = b[1]
		enemyChar.damage = b[0]
		enemyChar.texture = load(b[2])
		count+=1

	# don't forget to attach the signals from enemies so that the enemy combat function is called
	# plan B - set the controller on each character scene and replace the signals with a call to this scene
	pass

func end_encounter():
	for b in $MissionScreen/LayoutH/Background/Layout/Badies.get_children() :
		b.visible = false
	isInCombat = false

	$MissionScreen/EncounterTimer.start()
	pass

func mission_complete():
	for p in CrewSingleton.crewmates :
		if p.currentHealth < p.maxHealth :
			p.currentHealth = min(p.maxHealth,p.currentHealth + p.maxHealth*0.4 )
	CurrencySingleton.currentCurrency+=100

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
	missionStarted = false
	$AbortScreen.visible = true
	$MissionScreen/EncounterTimer.stop()
	GS.abortReady = false
	missionStarted = false
	pass

func reset_mission_scene():
	$CrewSelection/ConfirmationScreen/StartMission.visible = false

	isInCombat = false
	currentStep = -1
	$CrewSelection.reset_crew()
	$CrewSelection.visible = true
	$MissionScreen.visible = false
	pass


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


func _on_FireworksTimer_timeout():
	paused = false
	check_for_combat_end()
	pass # Replace with function body.
