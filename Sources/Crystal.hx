package;

import sdg.Object;
import sdg.graphics.shapes.Polygon;
import kha.math.Vector2;
import kha.audio1.Audio;
import kha.Assets;
import sdg.graphics.Sprite;
import util.Button;
import haxe.Constraints.Function;

class Crystal extends Button
{
	public var value:Int = -1;
	public static var valueToNotes:Array<String> = ["C","D","E","F","G","A","B"];
	public var sprite:Sprite;
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
		super(x,y, width, height, sprite,"",function(a:Int, b:Int, c:Int){delegate();});
		height = 100;
		width = 100;
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
	}
}