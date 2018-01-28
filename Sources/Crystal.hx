package;

import sdg.Object;
import sdg.graphics.shapes.Polygon;
import kha.math.Vector2;
import kha.audio1.Audio;
import kha.Assets;
import sdg.graphics.Sprite;
import util.Button;
import haxe.Constraints.Function;
import kha.Scheduler;

class Crystal extends Button
{
	public var value:Int = -1;
	public static var valueToNotes:Array<String> = ["C","D","E","F","G","A","B"];
	public var sprite:Sprite;
	public var overlay:Object;
	public function new(value = 0, sprite:Sprite, delegate:Function)
	{
		x = 20 + value * 135;
		y = 600 - Math.abs(value-3)*100;
		
		this.value = value;
		graphic = sprite;
		this.sprite = sprite;
		sprite.scaleX = 100/sprite.width;
		sprite.scaleY = 100/sprite.height;
		this.sprite.color.A = .7;
		super(x,y, 100, 100, sprite,"",function(a:Int, b:Int, c:Int){delegate();});
		height = 100;
		width = 100;
		overlay = new Object(x,y, new Sprite(Assets.images.glint));
		overlay.graphic.alpha =.7;
	}

	public function select()
	{
		this.sprite.color.A = 1;
		sdg.Sdg.screen.add(overlay);
	}

	public function deselect()
	{
		var t:Int;
		t = Scheduler.addTimeTask(function()
		{
			this.sprite.color.A =.7;
			sdg.Sdg.screen.remove(overlay);
			Scheduler.removeTimeTask(t);
		},1,0,0);
	}

	public function play()
	{
		Audio.play(Reflect.field(Assets.sounds, valueToNotes[value]));
	}
}