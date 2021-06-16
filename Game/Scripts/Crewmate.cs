using Godot;
using System;
public class Crewmate : Node
{
    [Export] public string name;
    [Export] public string characterClass;
    [Export] public string pathToImage; //not sure about this one
    [Export] public int rank=1; //might not be used
    [Export] public int currentHealth=20;
    [Export] public int maxHealth=20;
    [Export] public int combatProwess=1;
    [Export] public int alienKnowledge=1;
    [Export] public int technologyKnowledge=1;
    [Export] public int peopleSkills=1;
    [Export] public float speed=1f;
    [Export] public bool isOwned=true;
}
