package util;
import kha.graphics2.Graphics;
import kha.Color;
import kha.Font;
import kha.Assets;
import sdg.Object;
import sdg.graphics.text.Text;

class TextObject extends Object
{
	public static var texts:Array<TextObject> = [];
	public var fontSize:Int;
	public var content:String;
	public var font:Font;
	public var color:Color;

	public function new(text:String, x:Float = 0, y:Float = 0, size:Int = 16, ?font:Font, ?color:Color)
	{
		content = text;
		fontSize = size;

		texts.push(this);


		if(font != null)
		{
			this.font = font;
		}
		else
		{
			this.font = Assets.fonts.OAG;
		}
		super(x,y, new Text(content, this.font, fontSize));
		if(color != null)
		{
			this.color = color;
		}
		else
		{
			this.color = Color.fromValue(0xffffffff);
		}
	}

	public override function update()
	{
		super.update();

		var t = cast(graphic, Text);

		t.text = content;
		t.color = color;
		t.fontSize = fontSize;
	}

	public function kill()
	{
		x = null;
		y = null;
		fontSize = null;
		content = null;
		font = null;
		color = null;
		texts.splice(texts.indexOf(this),1);
	}

	public static function clear()
	{
		trace("clear");
		for(i in texts)
		{
			i.kill();
		}
		texts = [];
	}
}