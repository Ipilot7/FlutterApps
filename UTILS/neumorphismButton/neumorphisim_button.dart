import 'package:flutter/material.dart';

import 'src/inset_boxdecoration.dart';
import 'src/inset_boxshadow.dart';

class NeumorphismButton extends StatefulWidget {
  const NeumorphismButton(
      {required this.width,
      required this.heigth,
      required this.text,
      super.key});
  final double width;
  final double heigth;
  final String text;

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool isDarkMode = false;
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    Color bgcolor =
        isDarkMode ? const Color(0xff2e3239) : const Color(0xffe7ecef);
    Offset distance = clicked ? const Offset(10, 10) : const Offset(28, 28);
    double blur = clicked ? 5.0 : 30.0;
    return GestureDetector(
      onTap: () {
        setState(() => clicked = !clicked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: CustomBoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: bgcolor,
            boxShadow: [
              BoxShadows(
                  color: isDarkMode ? const Color(0xff35393f) : Colors.white,
                  blurRadius: blur,
                  offset: -distance,
                  inset: clicked),
              BoxShadows(
                color: isDarkMode
                    ? const Color(0xff23262a)
                    : const Color(0xffa7a9af),
                blurRadius: blur,
                inset: clicked,
                offset: distance,
              ),
            ]),
        child: SizedBox(
          height: widget.heigth,
          width: widget.width,
          child: Center(
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}
