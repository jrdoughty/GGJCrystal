package;

import sdg.Object;
import sdg.graphics.shapes.Polygon;
import kha.math.Vector2;
import kha.audio1.Audio;
import kha.Assets;

class Crystal extends Object
{
	public var value:Int = -1;
	public static var valueToNotes:Array<String> = ["C","D","E","F","G","A","B"];

	public function new(value = 0)
	{
		super();
		x = value * 40;
		height = 20;
		width = 20;
		this.value = value;
		graphic = new Polygon([new Vector2(20,20),new Vector2(0,20),new Vector2(0,0)],kha.Color.Green,true,value/10+.3);
	}

	public override function added():Void 
	{
		trace(value);
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

	public function select()
	{
		var p = cast(graphic, Polygon);
		var tempX = p.points[1].x;
		p.points[1].x = p.points[1].y;
		p.points[1].y = tempX;
	}

	public function play()
	{
		Audio.play(Reflect.field(Assets.sounds, valueToNotes[value]));
		var p = cast(graphic, Polygon);
		p.color = kha.Color.Magenta;
		kha.Scheduler.addTimeTask(function(){p.color = kha.Color.Green;},.5,0,0);
	}
}