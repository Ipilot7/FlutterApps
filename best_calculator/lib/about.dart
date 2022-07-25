import 'package:best_calculator/utils/theme_colors.dart';

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _SettingsState();
}

class _SettingsState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bodyBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/about.png',
              width: double.infinity,
              height: 150,
            ),
            const SizedBox(height: 40),
            const Text(
              'Best Calculator ver 1.0',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 5),
            const Text('Creator: Botiraliyev Baxtiyor',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.email_outlined,
                color: Colors.white,
                size: 30,
              ),
              label: const Text(
                'Baxtiyor98@yandex.ru',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
