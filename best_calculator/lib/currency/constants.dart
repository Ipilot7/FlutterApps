import 'package:flutter/material.dart';

import 'price_model.dart';

const String currencyBox = 'currency_box';
const String weatherBox = 'weather_box';
const String weeklyBox = 'weekly_box';
const String currencyListKey = 'currency_list_key';
const String dateBox = 'date_box';
const String dateKey = 'date_key';

const scaffoldWeatherGradient = LinearGradient(colors: [Color(0xffFEF7FF), Color(0xffFCEBFF)]);
const textWeatherGradient =
    LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffD2C4FF)], transform: GradientRotation(45));
const containerWeatherGradient =
    LinearGradient(colors: [Color(0xffE662E5), Color(0xff5364F0)], transform: GradientRotation(45));

Color nightBgClr = const Color(0xFF17171C);
Color lightBgClr = const Color(0xFFF1F2F3);
Color actionsClmnnClr = const Color(0xFF4B5EFC);
Color actionsRowColor = const Color(0xFFD2D3DA);
Color actionsLightRowClr = const Color(0xFFD2D3DA);
Color nightactionsClmnClr = const Color(0xFF4E505F);
Color numbersClr = const Color(0xFF2E2F38);
Color lastAction = const Color(0xFF747477);
Color switchBtnBgClr = const Color(0xFF2E2F38);
Color switchBtnClr = const Color(0xFF4E505F);
// Color black = Colors.black;
// Color white = Colors.white;

TextStyle kTextStyle({
  Color? color,
  double size = 14,
  FontWeight fontWeight = FontWeight.w500,
  double? letterSpacing,
  double? height,
}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height);
}


List<PriceModel> listPrices = [
  PriceModel(name: 'Groceries', date: '5:20 PM', price: 678),
  PriceModel(name: 'Shopping', date: '6:25 PM', price: 892),
  PriceModel(name: 'Parking', date: '8:25 PM', price: 200),
];

Map<String, String> wtypes = {
  "ochiq havo": "ic_sunny",
  "bulutli": "ic_mist",
  "yomg'ir": "ic_rain",
};
