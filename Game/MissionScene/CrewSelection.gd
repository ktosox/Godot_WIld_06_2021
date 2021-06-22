extends HBoxContainer

var crewPanel = preload("res://MissionScene/CrewPanel.tscn")

var selectedCrew = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_selected_crew():
	return selectedCrew
	pass

func reset_crew():
	selectedCrew = []
	pass

func load_crew_selection():
	if GS.selectedPlanet == -1:
		$ConfirmationScreen/Label.text = "please first select a mission"
		return
	else:
		$ConfirmationScreen/Label.text = "please select 3 crewmates \n to send on this mission"
		
	if($CrewBox/VBoxContainer.get_child_count()<2):
		for p in CrewSingleton.crewmates.size() :
			if CrewSingleton.crewmates[p].isOwned:
				var newPanel = crewPanel.instance()
				newPanel.load_crew(p)
				newPanel.manager = self
				$CrewBox/VBoxContainer.add_child(newPanel)
				$CrewBox/VBoxContainer.move_child($CrewBox/VBoxContainer.get_node("EmptySpace"),$CrewBox/VBoxContainer.get_child_count())
	pass

func toggleCrew(who):
	if who.selected == false and selectedCrew.size()<3:
		who.select()
		selectedCrew.push_back(who.ID)
	elif who.selected == true :
		who.deselect()
		selectedCrew.erase(who.ID)
		$ConfirmationScreen/StartMission.visible = false
	if selectedCrew.size() == 3 :
		$ConfirmationScreen/StartMission.visible = true
	pass


func _on_StartMission_pressed():
	if get_parent().has_method("start_mission") :
		get_parent().start_mission()
	else:
		print("error, cant start mission as parent scene has no 'start_mission' method")
	pass # Replace with function body.
