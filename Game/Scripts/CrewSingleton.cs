using Godot;
using System;
using System.Collections.Generic;

public class CrewSingleton : Node
{
    [Export] public string charactersDirPath;
    public static List<Crewmate> crewmates = new List<Crewmate>();

    public override void _Ready()
    {
        var dir = new Directory();
        if(dir.Open(charactersDirPath)==Error.Ok){
            dir.ListDirBegin();
            var filename = dir.GetNext();

            while(filename!=""){
                if(!dir.CurrentIsDir()){
                    var path = charactersDirPath + "/" + filename;
                    var crewmate = (PackedScene)GD.Load(path);
                    crewmates.Add((Crewmate)crewmate.Instance());
                }
                filename=dir.GetNext();
            }
        }
        base._Ready();
    }
}
