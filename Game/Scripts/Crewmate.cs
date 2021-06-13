using Godot;
using System;

public enum Perk{
    Alien,
    Nerd,
    Medic,
    Grenade,
    GoodArmor
}

public class Crewmate
{
    public string name;
    public string pathToImage; //not sure about this one
    public int rank; //might not be used
    public int health;
    public int combatProwess;
    public int alienKnowledge;
    public int technologyKnowledge;
    public int otherStateOne;
    public int otherStatTwo;
    public Perk perkOne;
    public Perk perkTwo;
}
