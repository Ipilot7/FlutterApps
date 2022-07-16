import 'package:flutter/material.dart';

import 'page1.dart';
import 'page2.dart';

void main() {
  runApp(const Page1());
  // runApp(const LessonApp());
}

class LessonApp extends StatelessWidget {
  const LessonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page1(),
    );
  }
}
