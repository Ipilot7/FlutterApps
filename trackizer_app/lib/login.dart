import 'package:flutter/material.dart';
import 'package:trackizer_app/home.dart';
import 'package:trackizer_app/register1.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final Color textColorWhite = const Color(0xffffffff);
  final Color textColor = const Color(0xff666680);
  final LinearGradient _gradient = const LinearGradient(
      colors: [Colors.white, Colors.transparent],
      transform: GradientRotation(45));
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c1c23),
      body: ListView(
        padding: const EdgeInsets.only(left: 26, right: 26),
        children: [
          const SizedBox(height: 58),
          Image.asset(
            'assets/logoregister.png',
            width: 146,
            height: 24,
          ),
          const SizedBox(height: 165),
          Text(
            'Login',
            style: kTextStyle(
              color: textColor,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: kTextStyle(),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textColorWhite, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: textColorWhite, width: 2))),
          ),
          const SizedBox(height: 16),
          Text(
            'Password',
            style: kTextStyle(
              color: textColor,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: kTextStyle(),
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textColorWhite, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: textColorWhite, width: 2))),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: (bool? value) {},
                activeColor: textColor,
              ),
              Expanded(
                child: Text(
                  "Remember me",
                  style: kTextStyle(
                    color: textColor,
                  ),
                ),
              ),
              Text(
                'Forgot passoword',
                style: kTextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _buttons('Sign In', const Color(0xffff8868), Home()),
          const SizedBox(height: 130),
          Text(
            'If you don`t have an account yet?',
            textAlign: TextAlign.center,
            style: kTextStyle(),
          ),
          const SizedBox(height: 20),
          _buttons('Sign Un', const Color(0xff333339), Register1()),
        ],
      ),
    );
  }

  _buttons(String text, Color color, Widget widget) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ),
        );
      },
      child: Container(
        width: 120,
        height: 50,
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        padding: const EdgeInsets.all(1),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: color, offset: Offset(0, 3))
              ]),
          alignment: Alignment.center,
          child: Text(
            text,
            style: kTextStyle(
                color: textColorWhite, size: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
