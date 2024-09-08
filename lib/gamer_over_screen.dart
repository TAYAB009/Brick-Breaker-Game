import 'package:flutter/material.dart';

class GamerOverScreen extends StatelessWidget {
  final bool isGameOver;

  const GamerOverScreen({super.key, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: const Text(
              'G A M E O V E R',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        : Container();
  }
}
