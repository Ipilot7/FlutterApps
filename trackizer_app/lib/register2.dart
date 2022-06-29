import 'package:flutter/material.dart';
import 'package:trackizer_app/home.dart';
import 'package:trackizer_app/login.dart';
import 'package:trackizer_app/register1.dart';
import 'utils/constants.dart';

class Register2 extends StatefulWidget {
  const Register2({Key? key}) : super(key: key);

  @override
  State<Register2> createState() => _Register2();
}

class _Register2 extends State<Register2> {
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
          const SizedBox(height: 58),
          Image.asset(
            'assets/logoregister.png',
            width: 146,
            height: 24,
          ),
          const SizedBox(height: 165),
          Text(
            'E-mail address',
            style: kTextStyle(
              color: Color(0xff666680),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: false,
            style: kTextStyle(),
            maxLength: 25,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2))),
          ),
          const SizedBox(height: 16),
          Text(
            'Password',
            style: kTextStyle(
              color: const Color(0xff666680),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: true,
            style: kTextStyle(),
            maxLength: 25,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2))),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _progressBar(),
              _progressBar(),
              _progressBar(),
              _progressBar(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Use 8 or more characters with a mix of letters, numbers & symbols.',
            style: kTextStyle(size: 12, color: const Color(0xff666680)),
          ),
          const SizedBox(height: 40),
          _buttons(
              'Get started, it’s free!', const Color(0xffff8868), Register1()),
          const SizedBox(height: 130),
          Text(
            'Do you have already an account?',
            textAlign: TextAlign.center,
            style: kTextStyle(),
          ),
          const SizedBox(height: 20),
          _buttons('Sign In', const Color(0xff333339), Login()),
        ],
      ),
    );
  }

  Expanded _progressBar() {
    return const Expanded(
      child: Divider(
        thickness: 5,
        endIndent: 5,
        color: Color(0xff353542),
      ),
    );
  }

  InkWell _buttons(String text, Color color, Widget widget) {
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
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: _gradient, borderRadius: BorderRadius.circular(999)),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(999)),
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
