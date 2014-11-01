package framework.commons.Events{
	import flash.events.Event;

	public class TicEvent extends Event{
		
		/** tic event type */
		public static const TIC:String = 'tic';
		
		public function TicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
		/**
		 * clones the instance of the event
		 * 
		 * @return cloned event
		 **/
		override public function clone():Event{
			
			return new TicEvent(this.type, this.bubbles, this.cancelable);
		}
		
	}
}
