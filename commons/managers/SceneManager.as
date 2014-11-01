package framework.commons.managers{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import framework.commons.scene.ISceneNode;
	
	
	public class SceneManager {
		// double buffer
		public var backBuffer:BitmapData;
		
		// colour to use to clear backbuffer with 
		public var clearColor:uint = 0xFF849AA5;
		
		private var nodes:Array = new Array();
		
		// static instance 
		protected static var instance:SceneManager = null;
		
		static public function get Instance():SceneManager{
			if ( instance == null )
			instance = new SceneManager();
			return instance;
		}
		
		public function SceneManager(){
			if ( instance != null )
				throw new Error( "Only one Singleton instance should be instantiated" ); 
				
		}

		public function enterFrame(frameCounter:uint, stageWidth:int, stageHeight:int):void{
	    	// now allow objects to update themselves
			for each (var node:ISceneNode in nodes)
				if (node.inuse) 
					node.enterFrame(frameCounter);
	    	
	    	backBuffer = new BitmapData(stageWidth, stageHeight, false); 
	    	
	    	drawAll();
		}

		protected function drawAll():void{
			backBuffer.fillRect(backBuffer.rect, clearColor);
			
			// draw the objects
			for each (var node:ISceneNode in nodes)
				backBuffer.copyPixels(node.bitmap, node.rect, node.position, node.bitmapAlpha, new Point(0, 0), true);

		}

		public function copyToBuffer(db:BitmapData):void{
			db = backBuffer.clone();
			
			// Destroy the back buffer.
			backBuffer.dispose();
		}	
	}
}
