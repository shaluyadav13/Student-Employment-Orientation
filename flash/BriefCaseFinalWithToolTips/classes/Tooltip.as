/* Customizable  AS3 Tooltip */
/* Developed by Involution Media*/

package classes
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	import flash.text.Font;

	public class Tooltip extends Sprite
	{
		/* Vars */

		var tween:Tween;

		var tooltip:Sprite = new Sprite();
		var bmpFilter:BitmapFilter;

		var textfield:TextField = new TextField();
		var textformat:TextFormat = new TextFormat();
		var font:Font = new Font();

		public function Tooltip(w:int, h:int, cornerRadius:int, txt:String, color:uint, txtColor:uint, alfa:Number, useArrow:Boolean, dir:String, dist:int):void
		{
			/* TextField and TextFormat Properties */

			textfield.selectable = false;

			textformat.align = TextFormatAlign.CENTER;
			textformat.font = font.fontName;
			textformat.size = 10;
			
			textformat.color = txtColor;

			textfield = new TextField();
			textfield.embedFonts = false;
			textfield.width = w;
			textfield.height = h;
			textfield.defaultTextFormat = textformat;
			textfield.text = txt;

			/* Create tooltip */

			tooltip = new Sprite();             
			tooltip.graphics.lineStyle(1,0xF68428);

			tooltip.graphics.beginFill(color, alfa);
			tooltip.graphics.drawRect(0, 0, w, h );

			

			tooltip.graphics.endFill();

			/* Filter */
			
			//Drop Shadow
bmpFilter = new DropShadowFilter(1,90,0x000000,1,2,2,1,15);

			tooltip.filters = [bmpFilter];

			/* Add to Stage */

			tooltip.addChild(textfield);

			addChild(tooltip);
	}
	}
}