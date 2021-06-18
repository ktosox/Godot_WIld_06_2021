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
    Crewmate selectedCrewmate;
    bool showOwned=true;
    public override void _Ready()
    {
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
            }
    }
    public void _on_CrewList_item_selected(int index){
        var description = (SelectedCrewmateDesription)GetNode("/root/CrewMainMenu/SelectedCrewmateDesription");
        var correctCrewmateList = CrewSingleton.crewmates.Where(c => c.isOwned==showOwned).ToList();
        description.AssignData(correctCrewmateList[index]);
        selectedCrewmate=correctCrewmateList[index];
        var hireButton = (Button) GetNode(hireButtonPath);
        if(selectedCrewmate.isOwned){
            hireButton.Disabled=true;
        }
        else{
            hireButton.Disabled=false;
        }
        GD.Print(index);
    }
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
