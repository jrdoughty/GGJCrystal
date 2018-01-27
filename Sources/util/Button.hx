package util;

import kha.Font;
import sdg.graphics.Sprite;
import sdg.Sdg;
import sdg.Object;

class Button extends Object
{
	public static var buttons:Array<Button> = [];
	public var background:Sprite;
	public var text:TextObject;
	//public var clickRegion:FlxSprite;
	
	public var click:Int->Int->Int->Void;

	public function new(x:Float, y:Float, width:Int, height:Int, backgroundSprite:Sprite, textString:String, click:Int->Int->Int->Void,?fontSize:Int)
	{
		background = backgroundSprite;
		super(x,y,background);
		
		text = new TextObject(textString, Math.round(x + background.width/10), Math.round(y + background.height/10),Math.round(height*.66));
		Sdg.screen.add(this);
		this.click = click;
		var t = new haxe.Timer(1000);
		t.run = function(){buttons.push(this);t.stop();};
		
	}

	public function kill()
	{
		trace('kill');
		Sdg.screen.remove(this);
		background = null;
		text.kill();
	}

	public static function clear()
	{
		for(i in buttons)
		{
			i.kill();
		}
		buttons = [];
	}

	
/*
	public function over(sprite:FlxSprite)
	{
		
	}

	public function out(sprite:FlxSprite)
	{
		
	}
	public function update():Void 
	{
		//super.update();
	}
*/	
}