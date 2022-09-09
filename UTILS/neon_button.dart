import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
class NeoButton extends StatefulWidget {
  const NeoButton({Key? key}) : super(key: key);

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Color shadowColor = Colors.blue;
    Color backgroundColor = shadowColor.withOpacity(0.7);
    return Listener(
      onPointerDown: (_) => setState(() {
        isPressed = true;
      }),
      onPointerUp: (_) => setState(() {
        isPressed = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
            color: isPressed ? backgroundColor : null,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              for (double i = 1; i < 5; i++)
                BoxShadow(
                    color: shadowColor,
                    blurRadius: (isPressed ? 5 : 3) * i,
                    inset: true),
              for (double i = 1; i < 5; i++)
                BoxShadow(
                    color: shadowColor,
                    spreadRadius: -1,
                    blurRadius: (isPressed ? 5 : 3) * i,
                    blurStyle: BlurStyle.outer),
            ]),
        child: TextButton(
          onHover: (hovered) => setState(() {
            this.isPressed = hovered;
          }),
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Neon Button',
            style: TextStyle(color: Colors.white, shadows: [
              for (double i = 1; i < (isPressed ? 8 : 4); i++)
                Shadow(color: shadowColor, blurRadius: 5 * i),
            ]),
          ),
        ),
      ),
    );
  }
}
