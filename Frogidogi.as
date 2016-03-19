package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Frogidogi extends MovieClip {
		
		var obstacles:Array;
		var keyCode:Number;

		public function Frogidogi() {
			
			obstacles = new Array();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			addEventListener(Event.ENTER_FRAME, gameLoop);

			var timer:Timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, addObstacle);
			timer.start();
		}

		function gameLoop(event:Event) {
			checkKeyboard();
			checkObstacleHit();
			obstacleOffScreen();
		}
		
		function checkKeyboard() {
			// Arrow key left
			if (keyCode == 37) {
				if (mcPlayer.x - 5 >= 0) {
					mcPlayer.x -= 5;
				}
			// Arrow key up
			} else if (keyCode == 38) {
				if (mcPlayer.y - 5 >= 0) {
					mcPlayer.y -= 5;
				}
			// Arrow key right
			} else if (keyCode == 39) {
				// fix this later
				if (mcPlayer.x + 5 <= stage.stageWidth) {
					mcPlayer.x += 5;
				}
			// Arrow key down
			} else if (keyCode == 40) {
				// fix this later
				if (mcPlayer.y + 5 <= stage.stageHeight) {
					mcPlayer.y += 5;
				}
			}
		}
		
		function checkObstacleHit() {
			for (var i:Number = 0; i < obstacles.length; i++) {
				if (mcPlayer.hitTestObject(obstacles[i])) {
					trace("HIIIIT");
				}
			}
		}
		
		function addObstacle(event:TimerEvent) {
			trace("Timer");
			var obstacle:MovieClip = new mcObstacle();
			obstacles.push(obstacle);
			trace(obstacles.length);
			addChild(obstacle);
		}
		
		function obstacleOffScreen() {
			for (var i:Number = 0; i < obstacles.length; i++){
				if (obstacles[i].x > (stage.stageWidth + obstacles[i].width / 2)) {
					// Remove obstacle from array and stage
					obstacles[i].removeObstacle();
					obstacles.splice(i, 1);
				}
			}
		}
		
		function keyDown(event:KeyboardEvent) {
			keyCode = event.keyCode;
		}

		function keyUp(event:KeyboardEvent) {
			
		}
		
		/* The randomRange function */ 
		function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}
}
