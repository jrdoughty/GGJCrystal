package;

import sdg.Screen;
import sdg.Object;
import sdg.manager.Keyboard;
import kha.input.KeyCode;
import kha.audio1.Audio;
import kha.Assets;
import kha.Scheduler;


class PlayScreen extends Screen
{
	var selectedCrystals:Array<Int>;
	var crystals:Array<Crystal>;
	var chord:Chord;
	var player:Player;
	public static var level:Int = 0;
	public override function init ()
	{
		super.init();
		crystals = [];
		selectedCrystals = [];
		for(i in 0...7)
		{
			crystals.push(new Crystal(i));
			add(crystals[crystals.length-1]);
		}
		
		add(chord = new Chord(Math.floor(level/3)+1));
		add(player = new Player());
		Scheduler.addTimeTask(function(){
			for(i in selectedCrystals)
			{
				crystals[i].play();
			}
		},2,5,0);
	}

	public override function update()
	{
		super.update();
		if(Keyboard.isPressed(KeyCode.Space))
		{
			for(i in crystals)
			{
				if(doObjectsOverlap(i, player))
				{
					selectCrystal(i.value);
				}
			}
		}
		else if(Keyboard.isPressed(KeyCode.One))
		{
			selectCrystal(0);
		}
		else if(Keyboard.isPressed(KeyCode.Two))
		{
			selectCrystal(1);				
		}
		else if(Keyboard.isPressed(KeyCode.Three))
		{
			selectCrystal(2);				
		}
		else if(Keyboard.isPressed(KeyCode.Four))
		{
			selectCrystal(3);			
		}
		else if(Keyboard.isPressed(KeyCode.Five))
		{
			selectCrystal(4);			
		}
		else if(Keyboard.isPressed(KeyCode.Six))
		{
			selectCrystal(5);			
		}
		else if(Keyboard.isPressed(KeyCode.Seven))
		{
			selectCrystal(6);			
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
			else
			{
				trace('selected' + selectedCrystals);
				trace('chord' + chord.notes);
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
			}
		}
		else
		{
			selectedCrystals.remove(index);
		}
		crystals[index].select();
	}

	public function newLevel()
	{
		trace('i win');
		for(i in selectedCrystals)
		{
			crystals[i].select();
		}
		chord.destroy();
		add(chord = new Chord(Math.floor(level/3)+1));
		selectedCrystals = [];
		level++;
	}
}