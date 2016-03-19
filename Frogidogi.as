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
			var hitted:Boolean = false;
			for (var i:Number = 0; i < obstacles.length; i++) {
				if (player.hitTestObject(obstacles[i])) {
					hitted = true;
					var hittedObs = obstacles[i];
					player.hit(keyCode);
					player.decreaseHealth();
					if (player.getHealth() == 0) {
						trace("END!!!");
					}
				} else {
					player.hit(0);
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
