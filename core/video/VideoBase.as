package framework.core.video{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import framework.commons.Events.TicEvent;
	import framework.commons.managers.SceneManager;

	/** 
	 * VideoBase 
	 * 		- double buffer
	 * 		- frame rate
	 */
	public class VideoBase extends MovieClip{
		
		// static instance 
		protected static var instance:VideoBase = null;
		
		static public function get Instance():VideoBase{
			if ( instance == null )
				instance = new VideoBase();
				
			return instance;
		}
		
		/**
		 * Counter incremented in the enterFrame event callback. Used to determine 
		 * which frame of an animation needs to be displayed.
		 *
		 * @access private
		 * @var frameCounter uint Unsigned integer storing the frame number.
		 */
		private var frameCounter:uint = 0;
		
		/**
		 * The frame buffer is the large bitmap, the size of the entire stage, 
		 * that is getting updated on each frame.
		 *
		 * @access private
		 * @var frameBuffer BitmapData 
		 */
		private var frameBuffer:BitmapData;
		
		/**
		 * FPS Meter related.
		 */
		private var frames:uint = 0;
        private var last:uint = getTimer();
        public var fps:Number = 0;
		
		private var tic:TicEvent = new TicEvent(TicEvent.TIC);
		
		/**
		 * Class constructor.
		 *
		 * @access public
		 * @return void
		 */
		public function VideoBase(){
			if ( instance != null )
				throw new Error( "Only one Singleton instance should be instantiated" ); 
			
			// Used to manipulate the stage properties
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Add the enterFrame event listener.
			addEventListener(Event.ENTER_FRAME, renderFrame);
			
		}
		

		/*----------------------------------------------------------
		 * HANDLERS
		 *----------------------------------------------------------*/
		 
		private function renderFrame(evt:Event):void{
			// FPS Meter related
			frames++
			
			SceneManager.Instance.enterFrame(frameCounter, stage.stageWidth, stage.stageHeight)
			
			// Build the frame buffer.
			SceneManager.Instance.copyToBuffer(frameBuffer);
			
			if (frameBuffer){
				
				// Draw the render buffer into the document class' graphics using the BitmapFill.
				// Since we're already dealing with bitmap data, no need to create heavy objects such as flash.display.Bitmap.
				this.graphics.clear();
				this.graphics.beginBitmapFill(frameBuffer);
				this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				this.graphics.endFill();
				
				// Destroy the frame buffer.
				//frameBuffer.dispose();
			} //else 
				//throw new Error( "The FrameBuffer is NULL!" ); 
			
			
			// FPS Meter related
			var now:uint = getTimer();
			var delta:uint = now - last;



			// FPS Meter related
			if (delta >= 1000) {
				fps = frames / delta * 1000;
				trace(fps.toString());
				frames = 0;
				last = now;
				
				this.dispatchEvent(tic.clone());
			}
			
			// Increment the frame index.
			frameCounter++;
		}
		
		/**
		 * Callback used to set the stage options.
		 * Options: no scale, aligned top left.
		 * Also adding the KeyboardEvent event listener that will trigger the pause.
		 *
		 * @access private
		 * @param evt Event Event triggered by the ADDED_TO_STAGE event dispatch.
		 * @return void
		 */
		private function onAddedToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		/*----------------------------------------------------------
		 * END OF HANDLERS
		 *----------------------------------------------------------*/

	}
}
