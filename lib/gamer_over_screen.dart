import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamerOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;
  static var gameFonts = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 20));
  const GamerOverScreen({super.key, required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  'GAME OVER',
                  style: gameFonts,
                ),
              ),
              Container(
                alignment: Alignment(0, 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.purple,
                      child: Text(
                        'Play Again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}
