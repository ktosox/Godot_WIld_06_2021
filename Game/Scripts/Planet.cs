using Godot;
using System;


public enum PlanetType{
	craters,
	desolate,
	ice,
	jungle,
	ocean,
	red,
	sandy
}

public class Planet : Node
{
	[Export] public int id;
	[Export] public string name;
	[Export] public string pathToImage;
	[Export] public PlanetType planetType;
	[Export(PropertyHint.MultilineText)] public string importantPoints;
	[Export(PropertyHint.MultilineText)] public string planetDescription;
	[Export(PropertyHint.MultilineText)] public string missionDescription;
}
