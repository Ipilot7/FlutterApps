import 'package:flutter/material.dart';

import '../weather_model.dart';

List<Color> gradient = const [
  Color(0xffE662E5),
  Color(0xff5364F0),
];
List<Color> scafoldGradient = const [Color(0xfffef7ff), Color(0xfffcebff)];
var textColorBlack = const Color(0xff25272E);
var textColorGrey = const Color(0xffCBCBCB);
var colorGreen = const Color(0xff2DBE8D);
var colorRed = const Color(0xffFF7676);
LinearGradient textGradient = const LinearGradient(
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFFD2C4FF),
  ],
);

const String weatherBox = 'weather_box';
const String dateBox = 'date_box';


WeatherModel model = WeatherModel();


var linkToCity = 'ferghana';

int? isActiveIndex;
var newCity = 'Tashkent';

List<String> cityRu = [
  'Ташкент',
  'Андижан',
  'Бухара',
  'Гулистан',
  'Джизак',
  'Зарафшан',
  'Карши',
  'Навои',
  'Наманган',
  'Нукус',
  'Самарканд',
  'Термез',
  'Ургенч',
  'Фергана',
  'Хива'
];
var cityUz = [
  'Tashkent',
  'Andijan',
  'Bukhara',
  'Gulistan',
  'Jizzakh',
  'Zarafshan',
  'Karshi',
  'Navoi',
  'Namangan',
  'Nukus',
  'Samarkand',
  'Termez',
  'Urgench',
  'Ferghana',
  'Khiva'
];
Map citys = {
  'Ташкент': 'Tashkent',
  'Андижан': 'Andijan',
  'Бухара': 'Bukhara',
  'Гулистан': 'Gulistan',
  'Джизак': 'Jizzakh',
  'Зарафшан': 'Zarafshan',
  'Карши': 'Karshi',
  'Навои': 'Navoi',
  'Наманган': 'Namangan',
  'Нукус': 'Nukus',
  'Самарканд': 'Samarkand',
  'Термез': 'Termez',
  'Ургенч': 'Urgench',
  'Фергана': 'Ferghana',
  'Хива': 'Khiva'
};
