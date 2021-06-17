using Godot;
using System;

public enum PerkTag{
    Passive,
    Action,
    Attack,
    Defense
}

public class Perk : Node
{
    [Export] public int id;
    [Export] public string name;
    [Export] public string imagePath;
    [Export] public string description;
    [Export] public int perkWeight;
    [Export] public PerkTag perkTag;
}
