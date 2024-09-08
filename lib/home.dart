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
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.05;
  bool brickBroken = false;

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
    // check for when ball hits the bottom of bricks
    if (ballX >= brickX &&
        ballX <= brickX + brickWidth &&
        ballY <= brickY + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
        ballYDirection = Direction.DOWN;
      });
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
          backgroundColor: const Color.fromARGB(255, 246, 149, 120),
          body: Center(
            child: Stack(
              children: [
                // Add tap to play text
                CoverScreen(hasGameStarted: hasGameStarted),
                // Game Over Screen
                GamerOverScreen(isGameOver: isGameOver),
                // Creating a ball
                BallScreen(
                  ballX: ballX,
                  ballY: ballY,
                ),
                // Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                // Bricks
                MyBrick(
                  brickBroken: brickBroken,
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: brickX,
                  brickY: brickY,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
