package;

import sdg.Screen;
import sdg.Object;
import sdg.manager.Keyboard;
import kha.input.KeyCode;
import kha.audio1.Audio;
import kha.Assets;
import kha.Scheduler;
import util.TextObject;
//import util.Button;
import kha.Assets;
import sdg.graphics.Sprite;
import kha.math.Vector2;
import sdg.graphics.shapes.Polygon;
import kha.Color;
import util.Button;

class CreditsScreen extends Screen
{

	var text:TextObject;
	//var b:Button;
	public override function init ()
	{
		super.init();
		var bg:Object = new Object(0, 0, new Sprite(Assets.images.background));
		add(bg);
		text = new TextObject("Developed by David Drum and John Doughty. You activated the crystals " + PlayScreen.activations + " times and solved 10 sets of notes.",80,30,100,760,null, Color.Black);
		var credits = new TextObject("Additional Credits: ambient sound by inovember: https://soundcloud.com/m-nod   Copyright (c) 2012, TypeSETit, LLC (typesetit@att.net),
with Reserved Font Name \"Lovers Quarrel\"",80,430,45,760,null, Color.Black);
		text.width = 600;
		add(text);
		add(credits);
	}
}