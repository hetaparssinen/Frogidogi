package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.sampler.NewObjectSample;
	
	public class Frogidogi extends MovieClip {
		
		var obstacles:Array;
		var keyCode:Number = 0;
		var player:mcCharacter;
		public var hitted:Boolean = false;
		var hittedObs:mcObstacle;
		var pressed:Boolean = false;
		
		var firstRowY = 80;
		var secondRowY = 180;
		var thirdRowY = 285;
		
		var timerHitted:Timer;

		public function Frogidogi() {
			
			obstacles = new Array();
			
			initialize();
			
			player = new mcCharacter();
			addChild(player);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
			
			var timer:Timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, addFirstRow);
			timer.start();
			
			var secTimer:Timer = new Timer(2500);
			secTimer.addEventListener(TimerEvent.TIMER, addSecondRow);
			secTimer.start();
			
			var thiTimer:Timer = new Timer(3000);
			thiTimer.addEventListener(TimerEvent.TIMER, addThirdRow);
			thiTimer.start();
			
			//timerHitted = new Timer(1000);
			//timerHitted.addEventListener(TimerEvent.TIMER, releaseHit);
		}

		function gameLoop(event:Event) {
			checkKeyboard();
			checkObstacleHit();
			checkObstacleOffScreen();
			checkFinish();
		}
		
		function checkKeyboard() {
			player.movePlayer(keyCode);
		}
		
		function checkObstacleHit() {
			if (!hitted) {
				for (var i:Number = 0; i < obstacles.length; i++) {
					if (player.hitTestObject(obstacles[i])) {
						trace("HIT");
						hitted = true;
						//timerHitted.start();
						hittedObs = obstacles[i];
						player.decreaseHealth();
						if (player.getHealth() == 0) {
							mcLostScreen.x = stage.stageWidth / 2;
							mcLostScreen.y = stage.stageHeight / 2;
							addChild(mcLostScreen);
							player.preventMoving();
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
		
		function checkFinish() {
			if (player.hitTestObject(mcGoal)) {
				mcWinScreen.x = stage.stageWidth / 2;
				mcWinScreen.y = stage.stageHeight / 2;
				addChild(mcWinScreen);
				for (var i:Number = 0; i < obstacles.length; i++) {
					obstacles[i].stopObstacle();
				}
			}
		}
		
		/*
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
		*/
		
		function stopTimer() {
			timerHitted.stop();
		}
		
		function addFirstRow(event:TimerEvent) {
			addObstacle(firstRowY);
		}
		
		function addSecondRow(event:TimerEvent) {
			addObstacle(secondRowY);
		}
		
		function addThirdRow(event:TimerEvent) {
			addObstacle(thirdRowY);
		}
		
		function addObstacle(y:Number, x:Number=-1) {
			var obstacle:MovieClip = new mcObstacle();
			obstacles.push(obstacle);
			obstacle.y = y;
			if (x != -1) {
				obstacle.x = x;
			}
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
			hitted = false;
			keyCode = event.keyCode;
		}

		function keyUp(event:KeyboardEvent) {
			
		}
		
		function initialize() {
			mcGoal.y = 0;
			mcGoal.x = stage.stageWidth / 2;
			
			for (var i:Number = 0; i < 3; i++) {			
					if (i == 0) {
						addObstacle(firstRowY, stage.stageWidth - 70);
						addObstacle(firstRowY, stage.stageWidth - 370);
						addObstacle(firstRowY, -150);
					} else if (i == 1) {
						addObstacle(secondRowY, stage.stageWidth - 170);
						addObstacle(secondRowY, stage.stageWidth - 470);
						addObstacle(secondRowY, -150);
					} else {
						addObstacle(thirdRowY, stage.stageWidth - 100);
						addObstacle(thirdRowY, stage.stageWidth - 400);
						addObstacle(thirdRowY, -150);
					}
			}
		}
		
		/* The randomRange function */ 
		function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}
}
