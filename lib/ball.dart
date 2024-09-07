import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BallScreen extends StatelessWidget {
  final ballX;
  final ballY;

  const BallScreen({super.key, this.ballX, this.ballY});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
