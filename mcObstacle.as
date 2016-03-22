package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class mcObstacle extends MovieClip {

		public function mcObstacle() {
			this.gotoAndStop(randomRange(0, 4));
			this.x = -(this.width / 2);
			//this.x = 50;
			this.y = 150;
			addEventListener(Event.ENTER_FRAME, loopObstacle);
		}
		
		function loopObstacle(event:Event) {
			this.x += 5;
		}
		
		function stopObstacle() {
			removeEventListener(Event.ENTER_FRAME, loopObstacle);
		}
		
		public function removeObstacle() {
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, loopObstacle);
		}
		
		/* The randomRange function */ 
		function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}

	}
	
}
