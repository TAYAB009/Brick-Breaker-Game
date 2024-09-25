import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;
  static var gameFonts = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 20));
  const CoverScreen(
      {super.key, required this.hasGameStarted, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: const Alignment(0, -0.5),
            child: Text(
              isGameOver ? '' : 'BRICK BREAKER',
              style: gameFonts.copyWith(
                  color: const Color.fromARGB(255, 95, 67, 77)),
            ),
          )
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.5),
                child: Text(
                  'BRICK BREAKER',
                  style: gameFonts,
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.1),
                child: const Text('tap to play'),
              )
            ],
          );
  }
}
