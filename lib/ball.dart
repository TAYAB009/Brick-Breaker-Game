import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BallScreen extends StatelessWidget {
  final ballX;
  final ballY;
  final bool isGameOver;
  final bool hasGameStarted;

  const BallScreen(
      {super.key,
      this.ballX,
      this.ballY,
      required this.isGameOver,
      required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            // decoration: BoxDecoration(color: Colors.pink),
            alignment: Alignment(ballX, ballY),
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          )
        : Container(
            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              glowColor: Colors.pink,
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ));
  }
}
