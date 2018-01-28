package; 
import sdg.Screen;
import sdg.Sdg;
import util.Button;
import sdg.graphics.Sprite;

class TitleScreen extends Screen
{
	public override function init()
	{
		super.init();
		
		var sprite:Sprite = new Sprite(kha.Assets.images.cyan3);
		var button:Button = new Button(50,50,100,200,sprite,'Play',play);
		button.width = sprite.width;
		button.height = sprite.height;
		add(button);

	}

	public function play(x:Int,y:Int,b:Int)
	{
		//Sdg.switchScreen(play)
	}	

}