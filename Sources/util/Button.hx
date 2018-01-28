package util;

import kha.Font;
import sdg.Graphic;
import sdg.graphics.Sprite;
import sdg.Sdg;
import sdg.Object;

class Button extends Object
{
	public static var buttons:Array<Button> = [];
	public var background:Graphic;
	public var text:TextObject;
	//public var clickRegion:FlxSprite;
	
	public var click:Int->Int->Int->Void;

	public function new(x:Float, y:Float, width:Int, height:Int, backgroundSprite:Graphic, textString:String, click:Int->Int->Int->Void,?fontSize:Int)
	{
		background = backgroundSprite;
		super(x,y,background);
		this.width = width;
		this.height = height;
		if(Type.getClass(backgroundSprite) == Sprite)
		{
			var s = cast(backgroundSprite, Sprite);
			s.scaleX = width/s.width;
			s.scaleY = height/s.height;
		}
		text = new TextObject(textString, x+Math.round(width/10), y+Math.round(height/2),Math.round(height*.25));
		Sdg.screen.add(this);
		Sdg.screen.add(text);
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