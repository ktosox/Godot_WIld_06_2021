using Godot;
using System;

public class SelectedCrewmateDesription : Panel
{
    [Export] private NodePath nameLabelPath;
    [Export] private NodePath classLabelPath;
    [Export] private NodePath portraitImagePath;
    [Export] private NodePath HPLabelPath;
    [Export] private NodePath combatLabelPath;
    [Export] private NodePath alienKnowledgeLabelPath;
    [Export] private NodePath techKnowledgeLabelPath;
    [Export] private NodePath peopleSkillsLabelPath;
    [Export] private NodePath speedLabelPath;
    [Export] private NodePath perkOneImagePath;
    [Export] private NodePath perkOneTitleLabelPath;
    [Export] private NodePath perkOneDescriptionLabelPath;
    [Export] private NodePath perkTwoImagePath;
    [Export] private NodePath perkTwoTitleLabelPath;
    [Export] private NodePath perkTwoDescriptionLabelPath;

    public void AssignData(Crewmate crewmate){
        var nameLabel =(Label) GetNode(nameLabelPath);
        nameLabel.Text=crewmate.name;
        var classLabel =(Label) GetNode(classLabelPath);
        classLabel.Text = crewmate.characterClass +" lvl "+crewmate.rank;
        var portrait =(NinePatchRect) GetNode(portraitImagePath);
        portrait.Texture = (Texture)GD.Load(crewmate.pathToImage);
        var HPLabel =(Label) GetNode(HPLabelPath);
        HPLabel.Text = "HP: "+crewmate.currentHealth+"/"+crewmate.maxHealth;
        var combatStat =(Stat) GetNode(combatLabelPath);
        combatStat.SetDynamicLabel(crewmate.combatProwess.ToString());
        var alienStat =(Stat) GetNode(alienKnowledgeLabelPath);
        alienStat.SetDynamicLabel(crewmate.alienKnowledge.ToString());
        var techStat =(Stat) GetNode(techKnowledgeLabelPath);
        techStat.SetDynamicLabel(crewmate.technologyKnowledge.ToString());
        var peopleStat =(Stat) GetNode(peopleSkillsLabelPath);
        peopleStat.SetDynamicLabel(crewmate.peopleSkills.ToString());
        var speedStat =(Stat) GetNode(speedLabelPath);
        speedStat.SetDynamicLabel(crewmate.speed.ToString());
    }
}
