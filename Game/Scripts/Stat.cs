using Godot;
using System;

public class Stat : HBoxContainer
{
	[Export] public NodePath dynamicLabelPath;
	[Export] private NodePath staticLabelPath;
	[Export] private string statName;

	public override void _Ready()
	{
		var staticLabel = (Label) GetNode(staticLabelPath);
		staticLabel.Text=statName;
		base._Ready();
	}
	public void SetDynamicLabel(string stat){
		var dynamicLabel = (Label) GetNode(dynamicLabelPath);
		dynamicLabel.Text= stat;
	}
}
