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

class TitleScreen extends Screen
{

	var text:TextObject;
	//var b:Button;
	public override function init ()
	{
		super.init();
		var bg:Object = new Object(0, 0, new Sprite(Assets.images.background));
		add(bg);

		//add(text = new TextObject('test',0,0,100));

		add(new Button(280,500,360,200,new Sprite(Assets.images.button),"  Play",function(a:Int,b:Int,c:Int){sdg.Sdg.switchScreen('Play');
		Button.clear();}));
		text = new TextObject("Touch the Crystals to match the notes of the Center Crystal",30,30,60,800,null, Color.Black);
		text.width = 600;
		add(text);
	}
}