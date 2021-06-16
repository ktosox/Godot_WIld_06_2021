using Godot;
using System;

public class Crewmate
{
    public string name;
    public string characterClass;
    public string pathToImage; //not sure about this one
    public int rank; //might not be used
    public int currentHealth;
    public int maxHealth;
    public int combatProwess;
    public int alienKnowledge;
    public int technologyKnowledge;
    public int peopleSkills;
    public float speed;
    public int perkOne;
    public int perkTwo;
    public bool isOwned;

    public Crewmate(string name,string characterClass,string pathToImage,int maxHealth,int combatProwess,int alienKnowledge,int technologyKnowledge,int peopleSkills,float speed,int perkOne, int perkTwo,bool isOwned=false,int rank=1){
        this.name=name;
        this.characterClass = characterClass;
        this.pathToImage=pathToImage;
        this.maxHealth=maxHealth;
        this.currentHealth=maxHealth;
        this.combatProwess=combatProwess;
        this.alienKnowledge=alienKnowledge;
        this.technologyKnowledge=technologyKnowledge;
        this.peopleSkills=peopleSkills;
        this.speed=speed;
        this.perkOne=perkOne;
        this.perkTwo=perkTwo;
        this.rank=rank;
        this.isOwned=isOwned;
    }
}
