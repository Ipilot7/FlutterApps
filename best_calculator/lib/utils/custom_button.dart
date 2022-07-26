import 'package:best_calculator/currency/constants.dart';
import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final color;
  final textColor;
  final buttonText;
  final buttontapped;

  MyCustomButton(
      {this.color, this.textColor, this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.symmetric(vertical: 27,),
        decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
        child: Center(
          child: Text(
            buttonText,
            style: kTextStyle(
                color: textColor, size: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
