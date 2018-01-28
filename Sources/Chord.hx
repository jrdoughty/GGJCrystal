package;

import sdg.Object;
import util.Button;
import kha.audio1.Audio;
import kha.Assets;
import kha.Scheduler;
import sdg.graphics.Sprite;
import util.ButtonManager;

class Chord extends Button
{
	public var notes:Array<Int>;
	public var difficulty:Int;
	private var tasks:Array<Int> = [];
	public var sprite:Sprite;
	public function new (difficulty:Int = 0)
	{
		this.difficulty = difficulty;
		x = 400;
		y = 100;
		sprite = new Sprite(kha.Assets.images.rainbow);
		graphic = sprite;
		sprite.alpha = .9;
		super(x,y,sprite.width,sprite.height,sprite,"",play);
		width = sprite.width;
		height = sprite.height;
	}

	public override function added():Void 
	{
		reset();
	}

	public override function removed():Void 
	{

	}
	
	public override function destroy()
	{
		super.destroy();	
	}
	
	public function reset()
	{
		for(task in tasks)
		{
			Scheduler.removeTimeTask(task);
		}
		notes = [];
		while(notes.length<difficulty)
		{
			var randomInt = Math.floor(Math.random()*7);
			if(notes.indexOf(randomInt) == -1)
			{
				notes.push(randomInt);
			}
		}
		notes.sort(function(a, b):Int {
			if (a < b) return -1;
			else if (a > b) return 1;
			return 0;
			});
		
		ButtonManager.the.buttonsActive = false;
		
		tasks.push(Scheduler.addTimeTask(function(){
			play();
			tasks.push(Scheduler.addTimeTask(function(){
				ButtonManager.the.buttonsActive = true;
			},1.5,0,0)); 
		},2.25,0,1)); 
	}

	public function play(a:Int=null,b:Int=null,c:Int=null)
	{
		for(task in tasks)
		{
			Scheduler.removeTimeTask(task);
		}
		for(i in notes)
		{
			Audio.play(Reflect.field(Assets.sounds, Crystal.valueToNotes[i]));
			sprite.alpha = 1;
		}
		tasks.push(Scheduler.addTimeTask(function(){
			sprite.alpha = .8;
		},1,5,0)); 
	}

	public override function update()
	{
		super.update();
	}

}