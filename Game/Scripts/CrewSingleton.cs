using Godot;
using System;
using System.Collections.Generic;

public class CrewSingleton : Node
{
    public static List<Crewmate> crewmates =new List<Crewmate>{
        new Crewmate("Samantha Davis","Medic","",20,3,2,2,2,1,0,1,true),
        new Crewmate("Eliot Arkins","Professor","",15,2,3,2,3,1,2,3,true)
    };
}
