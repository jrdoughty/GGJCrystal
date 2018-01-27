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
		
		add(chord = new Chord());
		add(player = new Player());
		Scheduler.addTimeTask(function(){for(i in selectedCrystals)Audio.play(Reflect.field(Assets.sounds, Crystal.valueToNotes[i]));},2,5,0);
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
					if(selectedCrystals.indexOf(i.value) == -1)
					{
						selectedCrystals.push(i.value);
					}
					else
					{
						selectedCrystals.remove(i.value);
					}
					i.select();
					selectedCrystals.sort(function(a, b):Int {
								if (a < b) return -1;
								else if (a > b) return 1;
								return 0;
								});
					if(selectedCrystals.length == chord.notes.length)
					{
						var bWin:Bool = true;
						for(j in selectedCrystals)
						{
							if(chord.notes.indexOf(j) == -1)
							{
								bWin = false;
							}
						}
						if(bWin)
						{
							trace('i win');
						}
					}
				}
			}
			trace(selectedCrystals);
			trace(chord.notes);
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
}