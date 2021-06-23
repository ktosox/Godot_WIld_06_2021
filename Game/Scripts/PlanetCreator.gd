extends Control




func _ready():
	print(PlanetsSingleton.planets)


func load_planet(ID):
	var planet = PlanetsSingleton.GetPlanet(ID)
	$Layout/ID/Data.text = String(planet.id)
	$Layout/Name/Data.text = String(planet.name)
	$Layout/Points/Data.text = String(planet.importantPoints)
	$Layout/MissionDescription/Data.text = String(planet.missionDescription)
	$Layout/PlanetDescription/Data.text = String(planet.planetDescription)
	pass

func _on_LoadPlanet_text_entered(new_text):
	var matches = 0
	for p in PlanetsSingleton.planets:
		if p.id == int(new_text) :
			matches+=1
			load_planet(int(new_text))
	if matches==0:
		print("no planets match ID :",new_text)

		pass # Replace with function body.
