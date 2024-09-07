import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/cover_screen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  // -----Step03---Let's add motion to the ball, create var for it
  double ballX = 0;
  double ballY = 0;
  var ballDirection = Direction.DOWN;

// player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

// Game Settings
  bool hasGameStarted = false;

  // Start game function on tap

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // update direction
      updateDirection();

      // move ball
      moveBall();
    });
  }

// update direction
  void updateDirection() {
    setState(() {
      if (ballY >= 0.9) {
        ballDirection = Direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = Direction.DOWN;
      }
    });
  }

// Move Ball
  void moveBall() {
    setState(() {
      if (ballDirection == Direction.DOWN) {
        //
        ballY += 0.01;
      } else if (ballDirection == Direction.UP) {
        //
        ballY -= 0.01;
      }
    });
  }

  // Movements of player

// Move left
  void moveLeft() {
    setState(() {
      // Allow moving left if the next move will not cause the player to skid off the screen
      if (!(playerX - 0.2 <= -1)) {
        playerX -= 0.3;
      }
    });
  }

// Move Right
  void moveRight() {
    setState(() {
      if (!(playerX + 0.32 >= 1)) {
        playerX += 0.3;
      }
    });
  }
  // 10:30 sec----resume

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
          backgroundColor: Colors.deepOrange,
          body: Center(
            child: Stack(
              children: [
                // Add tap to play text
                CoverScreen(hasGameStarted: hasGameStarted),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
