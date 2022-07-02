import 'package:currency_app/currency_page.dart';
import 'package:flutter/material.dart';
// import 'package:lesson1/nft_ui/auction_page.dart';
// import 'package:lesson1/nft_ui/discover_page.dart';
// import 'package:lesson1/trackizer/subscript_info_page.dart';

class Routes {
  static const currencyPage = '/currencyPage';
  // static const auctionPage = '/auctionPage';
  // static const discoverPage = '/discoverPage';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args = routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case currencyPage:
          return MaterialPageRoute(builder: (context) => const CurrencyPage());
        // case auctionPage:
        //   return MaterialPageRoute(builder: (context) => const AuctionPage());
        // case discoverPage:
        //   return MaterialPageRoute(builder: (context) => DiscoverPage(args?['title'] ?? ''));
        default:
          return MaterialPageRoute(builder: (context) => const CurrencyPage());
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => const CurrencyPage());
    }
  }
}
