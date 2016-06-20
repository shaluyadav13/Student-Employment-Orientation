﻿/*
 *************************************
 * ToolTip
 * http://www.FlepStudio.org         
 * © Author: Filippo Lughi           
 * version 1.0                       
 *************************************
 */
package org.FlepStudio
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import caurina.transitions.Tweener;
	
	public class ToolTip extends MovieClip
	{
		private var BG_COLOR:uint;
		private var TEXT_COLOR:uint;
		private var TEXT_SIZE:int;
		private var FONT:String;
		private var TOOL_TEXT:String;
		
		private var field_txt:TextField;
		
		private var ratio:int=10;
		
		private var holder_mc:MovieClip;
		private var bg_mc:MovieClip;
		private var father:MovieClip;
		
		private var left_point:Number;
		private var top_point:Number;
		private var right_point:Number;
		private var bottom_point:Number;
		
		public function ToolTip(bc:uint,tc:uint,ts:int,f:String,tt:String)
		{
			BG_COLOR=bc;
			TEXT_COLOR=tc;
			TEXT_SIZE=ts;
			FONT=f;
			TOOL_TEXT=tt;
			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
			mouseEnabled=false;
			alpha=0;
		}
		
		private function init(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			father=parent as MovieClip;
			
			left_point=0;
			top_point=0;
			right_point=stage.stageWidth;
			bottom_point=stage.stageHeight;
			
			createHolder();
			createTextField();
			createBackground();
			fixPosition();
			fadeIn();
			addEventListener(Event.ENTER_FRAME,addMovement);
		}
		
		private function createHolder():void
		{
			holder_mc=new MovieClip();
			addChild(holder_mc);
		}
		
		private function createTextField():void
		{
			field_txt=new TextField();
			field_txt.multiline=true;
			field_txt.selectable=false;
			field_txt.embedFonts=true;
			field_txt.antiAliasType=AntiAliasType.ADVANCED;
			field_txt.autoSize=TextFieldAutoSize.LEFT;
			field_txt.defaultTextFormat=getFormat();
			field_txt.htmlText=TOOL_TEXT+"  ";
			field_txt.width=field_txt.textWidth+10;
			field_txt.height=field_txt.textHeight+20;
			holder_mc.addChild(field_txt);
		}
		
		private function getFormat():TextFormat
		{
			var format:TextFormat=new TextFormat();
			format.font=FONT;
			format.size=TEXT_SIZE;
			format.color=TEXT_COLOR;
			return format;
		}
		
		private function createBackground():void
		{
			bg_mc=new MovieClip();
			bg_mc.graphics.beginFill(BG_COLOR,1);
			bg_mc.graphics.drawRoundRect(-ratio,-ratio,field_txt.width+ratio*2,field_txt.height+ratio*2,ratio,ratio);
			holder_mc.addChild(bg_mc);
			
			holder_mc.swapChildren(field_txt,bg_mc);
		}
		
		private function fixPosition():void
		{
			if(father.mouseX<stage.stageWidth/2)
				x=father.mouseX;
			else
				x=father.mouseX-width;
			if(father.mouseY<stage.stageHeight/2)
				y=father.mouseY+height-ratio*2;
			else
				y=father.mouseY-height;
		}
		
		private function fadeIn():void
		{
			Tweener.addTween(this,{alpha:1,time:1,transition:"regular"});
		}
		
		private function addMovement(evt:Event):void
		{
			if(father.mouseX<stage.stageWidth/2)
				x=father.mouseX;
			else
				x=father.mouseX-width+ratio*2;
			if(father.mouseY<stage.stageHeight/2)
				y=father.mouseY+height-ratio*2;
			else
				y=father.mouseY-height;
				
			if(x>stage.stageWidth-width)
				x=stage.stageWidth-width;
			if(x<ratio*2)
				x=ratio*2;
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME,addMovement);
			father.removeChild(this);
		}
	}
}