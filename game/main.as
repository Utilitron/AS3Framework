package {
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import framework.commons.Events.TicEvent;
	import framework.core.video.VideoBase;
	public class main extends Sprite{
		public function main(){

			addChild(VideoBase.Instance)
			
			VideoBase.Instance.addEventListener(TicEvent.TIC, update);
			
            doDrawCircle( 0x336699 );
            doDrawCircle( 0x993333 );
            doDrawCircle( 0x339933 );
		}

		public function update(event:TicEvent):void{
			//This is the game loop updated every tic (1 second)
			trace("Tic");
			
		}

		private function doDrawCircle( color:uint ):void
        {
            var child:Shape = new Shape();
            child.graphics.beginFill( color );
            child.graphics.lineStyle( 2, 0xCCCCCC );
            child.graphics.drawCircle( 30, 40, 30);
            child.graphics.endFill();
            child.x = (this.numChildren * 65) + 10;
            child.y = 0;
            addChild(child);
        }

	}
}
