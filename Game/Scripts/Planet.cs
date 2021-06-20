using Godot;
using System;

public class Planet : Node
{
    [Export] public int id;
    [Export] public string name;
    [Export] public string pathToImage;
    [Export(PropertyHint.MultilineText)] public string importantPoints;
    [Export(PropertyHint.MultilineText)] public string planetDescription;
    [Export(PropertyHint.MultilineText)] public string missionDescription;
}
