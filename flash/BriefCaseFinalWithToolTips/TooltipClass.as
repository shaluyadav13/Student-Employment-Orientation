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
		
		    public class Tooltip extends Sprite  
    		{  
				    var tween:Tween; //A tween object to animate the tooltip at start  
      
    var tooltip:Sprite = new Sprite(); //The Sprite containing the tooltip graphics  
    var bmpFilter:BitmapFilter; //This will handle the drop shadow filter  
      
    var textfield:TextField = new TextField(); //The textfield inside the tooltip  
    var textformat:TextFormat = new TextFormat(); //The format for the textfield  
    var font:Harmony = new Harmony(); //An embedded font  
	
	    public function Tooltip(w:int, h:int, cornerRadius:int, txt:String, color:uint, txtColor:uint, alfa:Number, useArrow:Boolean, dir:String, dist:int):void  
    	{  
			    textfield.selectable = false; //You cannot select the text in the tooltip  
      
    textformat.align = TextFormatAlign.CENTER; //Center alignment  
    textformat.font = font.fontName; //Use the embedded font  
    textformat.size = 8; //Size of the font  
      
    textformat.color = txtColor; //Color of the text, taken from the parameters  
      
    textfield = new TextField(); //A new TextField object  
    textfield.embedFonts = true; //Specify the embedding of fonts  
    textfield.width = w;  
    textfield.height = h;  
    textfield.defaultTextFormat = textformat; //Apply the format  
    textfield.text = txt; //The content of the TextField, taken from the parameters  
	
	    tooltip = new Sprite();  
      
    tooltip.graphics.beginFill(color, alfa);  
    tooltip.graphics.drawRoundRect(0, 0, w, h, cornerRadius, cornerRadius);  
	
	    if (useArrow && dir == "up")  
    {  
        tooltip.graphics.moveTo(tooltip.width / 2 - 6, tooltip.height);  
        tooltip.graphics.lineTo(tooltip.width / 2, tooltip.height + 4.5);  
        tooltip.graphics.lineTo(tooltip.width / 2 + 6, tooltip.height - 4.5);  
    }  
      
    if (useArrow && dir == "down")  
    {  
        tooltip.graphics.moveTo(tooltip.width / 2 - 6, 0);  
        tooltip.graphics.lineTo(tooltip.width / 2, -4.5);  
        tooltip.graphics.lineTo(tooltip.width / 2 + 6, 0);  
    }  
      
    tooltip.graphics.endFill(); // This line will finish the drawing no matter if the arrow is used or not.  
	
	    bmpFilter = new DropShadowFilter(1,90,color,1,2,2,1,15);  
      
    tooltip.filters = [bmpFilter];  
	
	    tooltip.addChild(textfield); //Adds the TextField to the Tooltip Sprite  
      
    addChild(tooltip); //Adds the Tooltip to Stage  
	
	
	