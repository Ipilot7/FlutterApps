import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'register1.dart';
import 'login.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Welcome(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  final Color textColorWhite = const Color(0xffffffff);
  final Color textColor1 = const Color(0xffA2A2B5);
  final LinearGradient _gradient = const LinearGradient(
      colors: [Colors.white24, Colors.transparent],
      transform: GradientRotation(45));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c1c23),
      body: ListView(
        padding: const EdgeInsets.only(left: 26, right: 26),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Image.asset(
              'assets/logoregister.png',
              width: 146,
              height: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300, bottom: 40),
            child: Text(
              'Congue malesuada in ac justo, a tristique leo massa. Arcu leo leo urna risus.',
              textAlign: TextAlign.center,
              style: kTextStyle(),
            ),
          ),
          _buttons('Get started', const Color(0xffff8868), Register1()),
          _buttons('I have an account', const Color(0xff333339), Login()),
        ],
      ),
    );
  }

  InkWell _buttons(String text, Color color, Widget function) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => function,
          ),
        );
      },
      child: Container(
        width: 120,
        height: 50,
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: _gradient, borderRadius: BorderRadius.circular(999)),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: color, offset: const Offset(0, 3))
              ]),
          alignment: Alignment.center,
          child: Text(
            text,
            style: kTextStyle(
                color: Colors.white, size: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
