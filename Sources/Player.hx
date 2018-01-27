package;

import sdg.Object;
import sdg.graphics.shapes.Polygon;
import kha.math.Vector2;
import sdg.manager.Keyboard;
import kha.input.KeyCode;

class Player extends Object
{
	
	public override function added():Void 
	{
		x = 50;
		y = 50;
		height = 10;
		width = 10;
		graphic = new Polygon([new Vector2(10,10),new Vector2(0,10),new Vector2(0,0)],kha.Color.Blue,true,1);
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
		if(Keyboard.isHeld(KeyCode.D))
		{
			x += 1;
		}
		if(Keyboard.isHeld(KeyCode.A))
		{
			x -= 1;
		}
		if(Keyboard.isHeld(KeyCode.W))
		{
			y -= 1;
		}
		if(Keyboard.isHeld(KeyCode.S))
		{
			y += 1;
		}
	}

}