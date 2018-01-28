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

		//add(text = new TextObject('test',0,0,100));

		add(new Button(280,500,360,200,new Sprite(Assets.images.button),"Play Again",function(a:Int,b:Int,c:Int){sdg.Sdg.switchScreen('Play');
		Button.clear();}));
	}

	public override function update()
	{
		super.update();
		//text.content = PlayScreen.level+"";
	}

	public function newLevel()
	{

	}
	
	public override function destroy():Void
	{
		super.destroy();
	}	
}