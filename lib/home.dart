import 'dart:async';
import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/brick.dart';
import 'package:brick_breaker/cover_screen.dart';
import 'package:brick_breaker/gamer_over_screen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// 20:10--------Resume

enum Direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  // -----Step03---Let's add motion to the ball, create var for it
  double ballX = 0;
  double ballY = 0;
  double ballXIncrements = 0.009;
  double ballYIncrements = 0.009;
  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

// player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

// Game Settings
  bool hasGameStarted = false;
  bool isGameOver = false;

// Brick variables
  static double firstBrickX = -0.5 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.08;
  static int numberOfBricksInEachRow = 4;

  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInEachRow * brickWidth -
          (numberOfBricksInEachRow - 1) * brickGap);
  bool brickBroken = false;

  List myBricks = [
    [firstBrickX, firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];

  // Start game function on tap
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // update direction
      updateDirection();

      // move ball
      moveBall();

      // check if the game is over

      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      // if brick is broken
      checkForBrokenBrick();
    });
  }

  void checkForBrokenBrick() {
    for (int i = 0; i < myBricks.length; i++) {
      // Check if the ball hits an unbroken brick
      if (!myBricks[i][2] && // if the brick is not broken
          ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY >= myBricks[i][1] &&
          ballY <= myBricks[i][1] + brickHeight) {
        setState(() {
          // Mark this brick as broken
          myBricks[i][2] = true;

          // Calculate the distances from the ball to each side of the brick
          double leftSideDist = (ballX - myBricks[i][0]).abs();
          double rightSideDist = (ballX - (myBricks[i][0] + brickWidth)).abs();
          double topSideDist = (ballY - myBricks[i][1]).abs();
          double bottomSideDist =
              (ballY - (myBricks[i][1] + brickHeight)).abs();

          // Determine which side was hit based on the smallest distance
          if (topSideDist < bottomSideDist &&
              topSideDist < leftSideDist &&
              topSideDist < rightSideDist) {
            // Hit from the top
            ballYDirection = Direction.UP;
          } else if (bottomSideDist < topSideDist &&
              bottomSideDist < leftSideDist &&
              bottomSideDist < rightSideDist) {
            // Hit from the bottom
            ballYDirection = Direction.DOWN;
          } else if (leftSideDist < rightSideDist &&
              leftSideDist < topSideDist &&
              leftSideDist < bottomSideDist) {
            // Hit from the left
            ballXDirection = Direction.LEFT;
          } else if (rightSideDist < leftSideDist &&
              rightSideDist < topSideDist &&
              rightSideDist < bottomSideDist) {
            // Hit from the right
            ballXDirection = Direction.RIGHT;
          }
        });
      }
    }
  }

// Plyer dead
  bool isPlayerDead() {
    // check if the ball move out of the screen
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

// update direction
  void updateDirection() {
    setState(() {
      // goes up when hit the player
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.UP;
        // goes down when hit the top of the screen
      } else if (ballY <= -1) {
        ballYDirection = Direction.DOWN;
      }
      // goes left when hit right wall
      if (ballX >= 1) {
        ballXDirection = Direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = Direction.RIGHT;
      }

      // goes right when hit left wall
    });
  }

  // rest game
  void resetGame() {
    setState(() {
      // Reset the ball's position
      ballX = 0;
      ballY = 0;

      // Reset the ball's direction
      ballXDirection = Direction.LEFT;
      ballYDirection = Direction.DOWN;

      // Reset the player's position
      playerX = -0.2;

      // Reset bricks - mark them all as unbroken
      for (int i = 0; i < myBricks.length; i++) {
        myBricks[i][2] = false; // false indicates the brick is not broken
      }

      // Reset game states
      hasGameStarted = false;
      isGameOver = false;
    });
  }

// Move Ball
  void moveBall() {
    setState(() {
      // move horizantally
      if (ballXDirection == Direction.LEFT) {
        ballX -= ballXIncrements;
      } else if (ballXDirection == Direction.RIGHT) {
        ballX += ballXIncrements;
      }

      // move vertivally
      if (ballYDirection == Direction.DOWN) {
        ballY += ballYIncrements;
      } else if (ballYDirection == Direction.UP) {
        ballY -= ballYIncrements;
      }
    });
  }

  // Movements of player

// Move left
  void moveLeft() {
    setState(() {
      // Allow moving left if the next move will not cause the player to skid off the screen
      if (!(playerX - 0.2 <= -1)) {
        playerX -= 0.4;
      }
    });
  }

// Move Right
  void moveRight() {
    setState(() {
      if (!(playerX + 0.4 >= 1)) {
        playerX += 0.4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 248, 172, 149),
          body: Center(
            child: Stack(
              children: [
                // Add tap to play text
                CoverScreen(
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                ),
                // Game Over Screen
                GamerOverScreen(
                  isGameOver: isGameOver,
                  function: resetGame,
                ),
                // Creating a ball
                BallScreen(
                  ballX: ballX,
                  ballY: ballY,
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                ),
                // Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                // Bricks
                MyBrick(
                  brickBroken: myBricks[0][2],
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[0][0],
                  brickY: myBricks[0][1],
                ),
                MyBrick(
                  brickBroken: myBricks[1][2],
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[1][0],
                  brickY: myBricks[1][1],
                ),
                MyBrick(
                  brickBroken: myBricks[2][2],
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[2][0],
                  brickY: myBricks[2][1],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
