import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
//Здесь импортируем все окна для перехода

class Routes {
  // Ссылка и прикрепленная переменная на страницу
  static const homePage = '/home';
  static const walletPage = '/auctionPage';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case homePage:
          return MaterialPageRoute(builder: (context) => const Page1());
        case walletPage:
          return MaterialPageRoute(builder: (context) => const Page2());
        default:
          return MaterialPageRoute(builder: (context) => const Page1());

        // Пример для добавки страницы на кейс
        // case subscriptInfoPage:
        //   return MaterialPageRoute(
        //       builder: (context) => const SubscriptInfoPage());
        // case discoverPage:
        //   return MaterialPageRoute(
        //       builder: (context) => DiscoverPage(args?['title'] ?? ''));

      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => const Page1());
    }
  }
}
