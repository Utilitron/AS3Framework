package framework.commons.scene{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public interface ISceneNode{
		function get bitmap():BitmapData; 
		function get rect():Rectangle;
		function get position():Point;
		function get bitmapAlpha():BitmapData;
		
		function get inuse():Boolean;
		
		function enterFrame(frameCounter:uint):void
	}
}
