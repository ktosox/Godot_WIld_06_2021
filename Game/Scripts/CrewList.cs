using Godot;
using System;
using System.Linq;

public class CrewList : ItemList
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	[Export] private NodePath hireButtonPath;
	[Export] private NodePath currencyLabelPath;
	[Export] private NodePath costLabelPath;
	Crewmate selectedCrewmate;
	bool showOwned=true;
	public override void _Ready()
	{
		var currencyLabel = (Label) GetNode(currencyLabelPath);
		currencyLabel.Text=CurrencySingleton.currentCurrency.ToString();
		PopulateCrewList(showOwned);
		Select(0);
		_on_CrewList_item_selected(0);
	}
    private void PopulateCrewList(bool showOwned){
        Clear();
        foreach(var crew in CrewSingleton.crewmates){
            if(crew.isOwned==showOwned){
            AddItem(crew.name);
            GD.Print(crew.name);
            }
        }
    }
    public void _on_ButtonOwned_pressed(){
        GD.Print("Owned");
        showOwned=true;
        PopulateCrewList(showOwned);
    }
    public void _on_ButtonToBuy_pressed(){
        GD.Print("To Buy");
        showOwned=false;
        PopulateCrewList(showOwned);
    }
    public void _on_HireButton_pressed(){
            if(selectedCrewmate.cost<=CurrencySingleton.currentCurrency && selectedCrewmate.isOwned==false){
                CurrencySingleton.currentCurrency=CurrencySingleton.currentCurrency-selectedCrewmate.cost;
                selectedCrewmate.isOwned=true;
                var currencyLabel = (Label) GetNode(currencyLabelPath);
                currencyLabel.Text=CurrencySingleton.currentCurrency.ToString();
                var hireButton = (Button) GetNode(hireButtonPath);
                hireButton.Disabled=true;
                PopulateCrewList(showOwned);
            }
    }
    public void _on_CrewList_item_selected(int index){
        var description = (SelectedCrewmateDesription)GetNode("/root/SpaceShip/CrewInspection/CrewMainMenu/SelectedCrewmateDesription");
        var correctCrewmateList = CrewSingleton.crewmates.Where(c => c.isOwned==showOwned).ToList();
        description.AssignData(correctCrewmateList[index]);
        selectedCrewmate=correctCrewmateList[index];
        var hireButton = (Button) GetNode(hireButtonPath);
        var costLabel = (Label) GetNode(costLabelPath);
        if(selectedCrewmate.isOwned){
            hireButton.Disabled=true;
            costLabel.Text=0.ToString();
        }
        else{
            hireButton.Disabled=false;
            costLabel.Text=selectedCrewmate.cost.ToString();
        }
        GD.Print(index);
    }
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
