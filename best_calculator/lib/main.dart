import 'package:best_calculator/currency/currency_model.dart';

import 'package:flutter/material.dart';


import 'package:hive_flutter/hive_flutter.dart';
import 'currency/routes.dart';

late Box box;
late Box box2;

void main() async {
  await Hive.initFlutter('');
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  box=await Hive.openBox('calculatorBox');
  box2=await Hive.openBox('settingsBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
      
    );
  }
}
