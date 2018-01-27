package;

import sdg.Object;
import sdg.graphics.shapes.Polygon;
import kha.math.Vector2;
import kha.audio1.Audio;
import kha.Assets;
import sdg.graphics.Sprite;

class Crystal extends Object
{
	public var value:Int = -1;
	public static var valueToNotes:Array<String> = ["C","D","E","F","G","A","B"];
	public var sprite:Sprite;
	public function new(value = 0, sprite:Sprite)
	{
		super();
		x = value * 100;
		height = 100;
		width = 100;
		this.value = value;
		graphic = sprite;
		this.sprite = sprite;
		sprite.scaleX = 100/sprite.width;
		sprite.scaleY = 100/sprite.height;
		this.sprite.color.B = .9;
		this.sprite.color.R = .9;
		this.sprite.color.G = .9;
		this.sprite.color.A = .7;
	}

	public function select()
	{
		if(this.sprite.color.A != 1)
			this.sprite.color.A = 1;
		else
			this.sprite.color.A =.7;
	}

	public function play()
	{
		Audio.play(Reflect.field(Assets.sounds, valueToNotes[value]));
		this.sprite.color.B = 1;
		this.sprite.color.R = 1;
		this.sprite.color.G = 1;
		kha.Scheduler.addTimeTask(function(){
			this.sprite.color.B = .9;
			this.sprite.color.R = .9;
			this.sprite.color.G = .9;
			},.5,0,0);
	}
}