import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  final playerWidth; // out of 2, because aligement is from -1 to 1, which is 2
  const MyPlayer({super.key, this.playerX, this.playerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 10.0,
          width: MediaQuery.of(context).size.width * playerWidth / 2,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
