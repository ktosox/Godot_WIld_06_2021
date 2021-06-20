using Godot;
using System;
using System.Collections.Generic;

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
    [Export] public Godot.Collections.Array<Godot.Collections.Array> enemies;

    [Export] public string stepFinishedBlurb;
}
