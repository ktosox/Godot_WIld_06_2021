using Godot;
using System;

public class PerkUI : Control
{
    [Export] private NodePath portraitImagePath;
    [Export] private NodePath titleLabelPath;
    [Export] private NodePath descriptionLabelPath;

    public void AssignData(Perk perk){
        var portrait =(NinePatchRect) GetNode(portraitImagePath);
        portrait.Texture = (Texture)GD.Load(perk.imagePath);
        var titleLabel =(Label) GetNode(titleLabelPath);
        titleLabel.Text=perk.name;
        var descriptionLabel =(Label) GetNode(descriptionLabelPath);
        descriptionLabel.Text=perk.description;
    }
}
