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

class PlayScreen extends Screen
{
	var selectedCrystals:Array<Int>;
	var crystals:Array<Crystal>;
	var chord:Chord;
	var text:TextObject;
	//var b:Button;
	public static var level:Int = 0;
	public override function init ()
	{
		super.init();
		var bg:Object = new Object(0, 0, Polygon.createRectangle(960,720,Color.fromString("#856f37")));//
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
		add(text = new TextObject('test',0,0,16));
		//add(b = new Button(50,50,50,50,new sdg.graphics.Sprite(Assets.images)));
	}

	public override function update()
	{
		text.content = level+"";
		super.update();
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
		selectedCrystals.sort(function(a, b):Int {
					if (a < b) return -1;
					else if (a > b) return 1;
					return 0;
					});
		if(selectedCrystals.length == chord.notes.length)
		{
			var bWin:Bool = selectedCrystals.length >= 1;
			for(j in selectedCrystals)
			{
				if(chord.notes.indexOf(j) == -1)
				{
					bWin = false;
				}
			}
			if(bWin)
			{
				newLevel();
			}
		}
	}

	public function doObjectsOverlap(object1:Object, object2:Object):Bool
	{
		var topLeftX1:Float = object1.width >= 0 ? object1.x : object1.x + object1.width;
		var topLeftY1:Float = object1.height >= 0 ? object1.y : object1.y + object1.height;
		var bottomRightX1:Float = object1.width >= 0 ? object1.x + object1.width : object1.x;
		var bottomRightY1:Float = object1.height >= 0 ? object1.y + object1.height : object1.y;
		

		var topLeftX2:Float = object2.width >= 0 ? object2.x : object2.x + object2.width;
		var topLeftY2:Float = object2.height >= 0 ? object2.y : object2.y + object2.height;
		var bottomRightX2:Float = object2.width >= 0 ? object2.x + object2.width : object2.x;
		var bottomRightY2:Float = object2.height >= 0 ? object2.y + object2.height : object2.y;
		
		if (topLeftX1 > bottomRightX2 || topLeftX2 > bottomRightX1 || topLeftY1 > bottomRightY2 || topLeftY2 > bottomRightY1)
		{
			return false;
		}
		return true;
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
		if(chord.notes.indexOf(index) == -1)
		{
			for(i in selectedCrystals)
			{
				crystals[i].select();
			}
			selectedCrystals = [];
		}
	}

	public function newLevel()
	{
		for(i in selectedCrystals)
		{
			crystals[i].select();
		}
		chord.difficulty = Math.floor(level/3)+1;
		if(chord.difficulty > 3)
			chord.difficulty = 3;
		if(level < 9)
		{
			chord.reset();
			selectedCrystals = [];
			level++;
		}
		else
		{
			trace('i win');
		}
	}
}