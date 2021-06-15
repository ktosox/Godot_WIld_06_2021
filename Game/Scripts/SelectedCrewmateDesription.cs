using Godot;
using System;

public class SelectedCrewmateDesription : Panel
{
    [Export] private NodePath nameLabelPath;
    public void AssignData(Crewmate crewmate){
        var nameLabel =(Label) GetNode(nameLabelPath);
        nameLabel.Text=crewmate.name;
    }
}
