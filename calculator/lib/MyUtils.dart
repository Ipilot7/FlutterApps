import 'package:flutter/material.dart';

//Стиль Кнопки !

ButtonStyle buttonStyle(
    {Color? color,
    Color? shadowColor,
    double? elevation,
    EdgeInsets? padding,
    double? borderRadius,
    Size? size,
    BorderSide? side}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(color),
    shadowColor: MaterialStateProperty.all(shadowColor),
    elevation: MaterialStateProperty.all(elevation),
    padding: MaterialStateProperty.all(padding),
    minimumSize: MaterialStateProperty.all(size),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          side: side ?? BorderSide.none),
    ),
  );
}

// Стиль Текста !

TextStyle kTextstyle(
    {Color? color,
    double? size = 32,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    double? letterSpasing}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpasing,
      height: height);
}




Color nightBgClr = const Color(0xFF17171C);
Color lightBgClr = const Color(0xFFF1F2F3);
Color actionsClmnnClr = const Color(0xFF4B5EFC);
Color actionsRowColor = const Color(0xFFD2D3DA);
Color numbersClr = const Color(0xFF2E2F38);
Color lastAction = const Color(0xFF4E505F);
Color black = const Color(0xff000000);
Color white = const Color(0xffffffff);
Color buttons3night = const Color(0xFF4E505F);
Color buttons3day = const Color(0xFFD2D3DA);

 
  

final List<String> buttons = [
  'C',
  '-/+',
  '%',
  '/',
  '7',
  '8',
  '9',
  'x',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '.',
  '0',
  'DEL',
  '=',
];
