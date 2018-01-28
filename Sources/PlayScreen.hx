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

class PlayScreen extends Screen
{
	var selectedCrystals:Array<Int>;
	var crystals:Array<Crystal>;
	var chord:Chord;
	var text:TextObject;
	var bg:Object;
	//var b:Button;
	public static var level:Int = 0;
	public override function init ()
	{
		level = 0;
		super.init();
		bg = new Object(0, 0, new Sprite(Assets.images.background));//
		add(bg);
		crystals = [];
		selectedCrystals = [];
		var imgs = Assets.images;
		var assets = [imgs.indigo3,
			imgs.cyan3,
			imgs.green1,
			imgs.yellow2,
			imgs.amber3,
			imgs.orange1, 
			imgs.red1];
		for(i in 0...7)
		{
			crystals.push(new Crystal(i, new Sprite(assets[i]),function(){selectCrystal(i);}));
			add(crystals[crystals.length-1]);
		}
		add(chord = new Chord(1));
		Scheduler.addTimeTask(function(){
			for(i in selectedCrystals)
			{
				crystals[i].play();
			}
		},2,5,0);
		add(text = new TextObject('1',50,50,100));
		//add(b = new Button(50,50,50,50,new sdg.graphics.Sprite(Assets.images)));
	}

	public override function update()
	{
		super.update();
		text.content = level+"";
		bg.graphic.color.B = .5 + ((level+1)/20);
		bg.graphic.color.R = .5 + ((level+1)/20);
		bg.graphic.color.G = .5 + ((level+1)/20);
		if(util.ButtonManager.the.buttonsActive)
		{
			if(Keyboard.isPressed(KeyCode.One))
			{
				selectCrystal(0);
			}
			if(Keyboard.isPressed(KeyCode.Two))
			{
				selectCrystal(1);				
			}
			if(Keyboard.isPressed(KeyCode.Three))
			{
				selectCrystal(2);				
			}
			if(Keyboard.isPressed(KeyCode.Four))
			{
				selectCrystal(3);			
			}
			if(Keyboard.isPressed(KeyCode.Five))
			{
				selectCrystal(4);			
			}
			if(Keyboard.isPressed(KeyCode.Six))
			{
				selectCrystal(5);			
			}
			if(Keyboard.isPressed(KeyCode.Seven))
			{
				selectCrystal(6);			
			}
			
			if(Keyboard.isPressed(KeyCode.T))
			{
				trace('selected' + selectedCrystals);
				trace('chord' + chord.notes);
			}
		}
	}

	public function selectCrystal(index:Int)
	{
		if(selectedCrystals.indexOf(index) == -1)
		{
			selectedCrystals.push(index);
			for(crystal in selectedCrystals)
			{
				crystals[crystal].play();
				crystals[index].select();
			}
		}
		selectedCrystals.sort(function(a, b):Int {
					if (a < b) return -1;
					else if (a > b) return 1;
					return 0;
					});
		
		var bWin:Bool = selectedCrystals.length == chord.notes.length;
		for(j in selectedCrystals)
		{
			if(chord.notes.indexOf(j) == -1)
			{
				bWin = false;
				for(i in selectedCrystals)
				{
					crystals[i].deselect();
				}
				selectedCrystals = [];
			}
		}
		if(bWin)
		{
			newLevel();
		}
	}

	public function newLevel()
	{
		if(level < 9)
		{
			for(i in selectedCrystals)
			{
				crystals[i].deselect();
			}
			chord.difficulty = Math.floor(level/3)+1;
			if(chord.difficulty > 3)
				chord.difficulty = 3;
			chord.reset();
			selectedCrystals = [];
			level++;
		}
		else
		{
			sdg.Sdg.switchScreen('Credits');
			Button.clear();
		}
	}
	
	public override function destroy():Void
	{
		super.destroy();
	}	
}