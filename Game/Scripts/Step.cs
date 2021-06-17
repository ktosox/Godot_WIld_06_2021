using Godot;
using System;

public enum StepType{
    Fight,
    Time,
    Tech,
    Xeno,
    People
}

public class Step : Node
{
    [Export] public StepType stepType;
    [Export] public int amount;
    [Export] public string backgroundType;
    [Export(PropertyHint.MultilineText)] public string description;
    [Export] public int minEnemyAttack;
    [Export] public int maxEnemyAttack;
    [Export] public int minEnemyHealth;
    [Export] public int maxEnemyHealth;
    [Export] public string enemyPortaitPath;
}
