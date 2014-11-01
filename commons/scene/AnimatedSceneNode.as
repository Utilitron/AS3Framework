package framework.commons.scene{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class AnimatedSceneNode extends MovieClip implements ISceneNode{
		private var _inuse:Boolean = false;
		public function set inuse(value:Boolean):void{ this._inuse = value; } 
		public function get inuse():Boolean{ return this._inuse; }

		private var _position:Point = new Point(0,0);
		public function set position(value:Point):void{ this._position = value; } 
		public function get position():Point{ return this._position; }

		private var _zOrder:int = 0;
		public function set zOrder(value:int):void{ this._zOrder = value; } 
		public function get zOrder():int{ return this._zOrder; }
		
				
		public function set bitmap(value:BitmapData):void{ this.bitmap = value; }  
		public function get bitmap():BitmapData{ return this.bitmap; }
		
		public function set rect(value:Rectangle):void{ this.rect = value; } 
		public function get rect():Rectangle{ return this.rect; }
		
		public function set bitmapAlpha(value:BitmapData):void{ this.bitmapAlpha = value; } 
		public function get bitmapAlpha():BitmapData{ return this.bitmapAlpha; }
		
		public function AnimatedSceneNode(image:DisplayObject){
			this.bitmap = createBitmapData(image);
			this.bitmapAlpha = createAlphaBitmapData(image);

			this.rect = bitmap.rect;
		}
		
		protected function createBitmapData(image:DisplayObject):BitmapData{
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image);
			return bitmap;
		}
		
		protected function createAlphaBitmapData(image:DisplayObject):BitmapData{
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image, null, null, flash.display.BlendMode.ALPHA);
			return bitmap;
		}
		
		public function enterFrame(dt:uint):void{
		
		}

	}
}
