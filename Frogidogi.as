package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Frogidogi extends MovieClip {
		
		var obstacles:Array;
		var keyCode:Number = 0;
		var player:mcCharacter;
		public var hitted:Boolean = false;
		var hittedObs:mcObstacle;
		
		var timerHitted:Timer;

		public function Frogidogi() {
			
			obstacles = new Array();
			
			player = new mcCharacter();
			addChild(player);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);

			var timer:Timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, addObstacle);
			timer.start();
			
			timerHitted = new Timer(1000);
			timerHitted.addEventListener(TimerEvent.TIMER, releaseHit);
		}

		function gameLoop(event:Event) {
			checkKeyboard();
			checkObstacleHit();
			checkObstacleOffScreen();
		}
		
		function checkKeyboard() {
			player.movePlayer(keyCode);
		}
		
		function checkObstacleHit() {
			if (!hitted) {
				for (var i:Number = 0; i < obstacles.length; i++) {
					if (player.hitTestObject(obstacles[i])) {
						hitted = true;
						timerHitted.start();
						hittedObs = obstacles[i];
						player.decreaseHealth();
						if (player.getHealth() == 0) {
							trace("END!!!");
						}
					}
				}
			} else {
				if (player.x >= hittedObs.x + hittedObs.width / 2) {
					player.x = hittedObs.x + hittedObs.width / 2 + player.width / 2;
				} else if (player.y + player.height/2 >= hittedObs.y + hittedObs.height/2) {
					player.y = hittedObs.y + hittedObs.height/2 + player.height/2 + 1;
				}			
			}
		}
		
		function releaseHit(event:TimerEvent) {
			if (player.x >= hittedObs.x + hittedObs.width / 2) {
				player.x = hittedObs.x;
				player.y = hittedObs.y + hittedObs.height/2 + player.height/2 + 1;
			} else if (player.y >= hittedObs.y + hittedObs.height/2 + player.height/2) {
				trace("allaaaaa");
				player.y = hittedObs.y + hittedObs.height/2 + player.height/2 + 1;
			}
			hitted = false;
			stopTimer();
		}
		
		function stopTimer() {
			timerHitted.stop();
		}
		
		function addObstacle(event:TimerEvent) {
			trace("Timer");
			var obstacle:MovieClip = new mcObstacle();
			obstacles.push(obstacle);
			trace(obstacles.length);
			addChild(obstacle);
		}
		
		function checkObstacleOffScreen() {
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
