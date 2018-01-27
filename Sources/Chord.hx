package;

import sdg.Object;
import kha.audio1.Audio;
import kha.Assets;
import kha.Scheduler;

class Chord extends Object
{
	public var notes:Array<Int>;
	private var difficulty:Int;
	public function new (difficulty:Int = 1)
	{
		super();
		this.difficulty = difficulty;
	}

	public override function added():Void 
	{
		notes = [];
		while(notes.length<difficulty)
		{
			var randomInt = Math.floor(Math.random()*7);
			if(notes.indexOf(randomInt) == -1)
			{
				notes.push(randomInt);
				Scheduler.addTimeTask(function(){
					Audio.play(Reflect.field(Assets.sounds, Crystal.valueToNotes[randomInt]));
				},1,5,0);
			}
		}
		notes.sort(function(a, b):Int {
			if (a < b) return -1;
			else if (a > b) return 1;
			return 0;
			});

	}
	public override function removed():Void 
	{

	}
	
	public override function destroy()
	{
		super.destroy();	
	}
	
	public override function update()
	{
		super.update();
	}

}