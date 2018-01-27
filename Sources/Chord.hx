package;

import sdg.Object;
import kha.audio1.Audio;
import kha.Assets;
import kha.Scheduler;
import sdg.graphics.Sprite;

class Chord extends Object
{
	public var notes:Array<Int>;
	private var difficulty:Int;
	private var tasks:Array<Int> = [];
	public var sprite:Sprite;
	public function new (difficulty:Int = 1)
	{
		super();
		this.difficulty = difficulty;
		x = 400;
		y = 100;
		sprite = new Sprite(kha.Assets.images.rainbow);
		graphic = sprite;
		sprite.alpha = .9;
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
				tasks.push(Scheduler.addTimeTask(function(){
					Audio.play(Reflect.field(Assets.sounds, Crystal.valueToNotes[randomInt]));
					sprite.alpha = 1;
					Scheduler.addTimeTask(function(){
					this.sprite.alpha = .9;
					},.5,0,0);
				},1,5,0)); 
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
		for(task in tasks)
		{
			Scheduler.removeTimeTask(task);
		}
		super.destroy();	
		sdg.Sdg.screen.remove(this);
	}
	
	public override function update()
	{
		super.update();
	}

}