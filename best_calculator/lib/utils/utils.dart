import 'package:flutter/material.dart';

final List<String> buttons = [
  'xⁿ', //c is delete
  '%',
  '/',
  '⌫',
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
  '( )',
  '=',
];
final List<String> numbers = [
  '7',
  '8',
  '9',
  'DEL',
  '4',
  '5',
  '6',
  'up/d',
  '1',
  '2',
  '3',
  'C',
  ',',
  '0',
  '00',  
];

final List<String> shModButtons = [
  'RAD',
  'sin',
  'cos',
  'tan',
  'π',
  'sinh',
  'cosh',
  'tanh',
  'x¯¹',
  'x²',
  'x³',
  'exp',
  'log',
  'ln',
  'e',
  'eⁿ'
];
final List<String> numbersOfRules = [
  '7',
  '8',
  '9',
  '⌫',
  '4',
  '5',
  '6',
  'C',
  '1',
  '2',
  '3',
  'OK',
  ',',
  '0',
  '00',
  '⩢'
];
final List<String> ruleMenu = [
  'РАССТОЯНИЕ',
  'ПЛОШАДЬ',
  'МАССА',
  'ОБЪЁМ',
  'ТЕМПЕРАТУРА',
  'ТОПЛИВО',
  'КУЛИНАРИЯ',
];

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);

String distance='метр';
 String area='квадратный метр';
 String mass='килограмм'; 
 String volume='кубический м'; 
 String  temperature='Целсия';
  String fuel='км/л';
  String coocking='миллилитр';
   List meashureNames = [distance, area, mass, volume,temperature,fuel,coocking];
String distance2='m';
 String area2='m²';
 String mass2='kg'; 
 String volume2='m³'; 
 String  temperature2='C';
  String fuel2='km / L';
  String coocking2='mL (cc)';
  List meashureNames2=[distance2, area2, mass2, volume2,temperature2,fuel2,coocking2];
