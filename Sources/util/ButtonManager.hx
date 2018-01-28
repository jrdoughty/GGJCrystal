package util;

import util.Button;
import kha.input.Mouse;

class ButtonManager
{

	public static var the(get, null):ButtonManager;
	public var buttonsActive:Bool = true;

	private static function get_the()
	{
		if(the == null)
		{
			the = new ButtonManager();
		}
		return the;
	}

	public function new(?btns:Array<Button>)
	{
		Mouse.get().notify(down, up, move, scroll);
	}

	public function down(mButton:Int, x:Int, y:Int)
	{
		if(buttonsActive)
		for(i in Button.buttons)
		{
			if(i != null && i.visible && 
			i.x <= x &&i.x + i.width >= x && 
			i.y <= y &&i.y + i.height >= y)
			{
				i.click(mButton, x, y);
				break;
			}
		}
	}
	public function up(mButton:Int, x:Int, y:Int)
	{
	}	
	public function move(x:Int,y:Int,cx:Int,cy:Int)
	{

	}
	public function scroll(scroll:Int)
	{

	}
}