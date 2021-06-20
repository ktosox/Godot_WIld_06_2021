using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public class PlanetsSingleton : Node
{
	[Export] public string PlanetsDirPath;
	public static List<Planet> planets = new List<Planet>();
		public override void _Ready()
	{
		var dir = new Directory();
		if(dir.Open(PlanetsDirPath)==Error.Ok){
			dir.ListDirBegin();
			var filename = dir.GetNext();

			while(filename!=""){
				if(!dir.CurrentIsDir()){
					var path = PlanetsDirPath + "/" + filename;
					var planet = (PackedScene)GD.Load(path);
					planets.Add((Planet)planet.Instance());
				}
				filename=dir.GetNext();
			}
		}
		base._Ready();
	}
	public static Planet GetPlanet(int id){
		if(id>=planets.Count){
			throw new Exception("You went out of bounds of the planet list!");
		}
		return planets.Where(p => p.id==id).FirstOrDefault();
	}
}
