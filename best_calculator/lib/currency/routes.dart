import 'package:best_calculator/about.dart';
import 'package:best_calculator/settings.dart';
import 'package:flutter/material.dart';
import 'package:best_calculator/history.dart';

import 'currency_page.dart';


class Routes {
  
  static const currencyPage = '/currencyPage';
  static const settingPage = "/settingPage";
  static const history='/';
  static const about='/about';


  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args = routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case settingPage:
        return MaterialPageRoute(builder: (context) => Settings(args?['animated_text']));
        case history:
          return MaterialPageRoute(builder: (context) => History());
         case about:
          return MaterialPageRoute(builder: (context) => const About());       
        case currencyPage:
          return MaterialPageRoute(
              builder: (context) => CurrencyPage(args?['list_curreny'], args?['top_cur'], args?['bottom_cur']));
       
        default:
          return MaterialPageRoute(builder: (context) => History());
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => History());
    }
  }
}
