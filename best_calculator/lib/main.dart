import 'package:best_calculator/currency/currency_model.dart';
import 'package:best_calculator/history.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'currency/routes.dart';

void main() async {
  await Hive.initFlutter('');
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  // HiveHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
      home: const History(),
    );
  }
}
// class HiveHelper {
//   static void init() async {
//     final dir = await getApplicationDocumentsDirectory();
//     Hive.init(dir.path);
//   }
// }
