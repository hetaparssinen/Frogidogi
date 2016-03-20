package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class mcCharacter extends MovieClip {
		var stageHeight:Number;
		var stageWidth:Number;
		var health:Number;
		var hitting:Boolean;

		public function mcCharacter() {
			health = 3;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event) {
			//this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace(this.stage);
			stageHeight = this.stage.stageHeight;
			stageWidth = this.stage.stageWidth;
			this.x = stageWidth / 2;
			this.y = stageHeight - (this.height / 2);
		}
		
		public function decreaseHealth() {
			this.health -= 1;
		}
		
		public function getHealth():Number {
			return this.health;
		}
		
		public function movePlayer(keyCode:Number) {
			// Arrow key left
			if (keyCode == 37) {
				if (this.x - 5 >= this.width / 2) {
					this.x -= 5;
				}
			// Arrow key up
			} else if (keyCode == 38) {
				if (this.y - 5 >= this.height / 2) {
					this.y -= 5;
				}
			// Arrow key right
			} else if (keyCode == 39) {
				if (this.x + 5 <= stageWidth - this.width / 2) {
					this.x += 5;
				}
			// Arrow key down
			} else if (keyCode == 40) {
				if (this.y + 5 <= stageHeight - this.height / 2) {
					this.y += 5;
				}
			}
		}

	}
	
}
