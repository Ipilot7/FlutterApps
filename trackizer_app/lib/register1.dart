import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'register2.dart';

class Register1 extends StatefulWidget {
  const Register1({Key? key}) : super(key: key);

  @override
  State<Register1> createState() => _Register1();
}

class _Register1 extends State<Register1> {
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
          const SizedBox(height: 320),
          _socialButtons('Sign up with Apple', const Color(0xff1c1c23),
              Colors.white, 'assets/apple.png', _gradient),
          _socialButtons('Sign up with Google', Colors.white, Colors.black,
              'assets/google.png', _gradient),
          _socialButtons('Sign up with Facebook', Colors.blue, Colors.white,
              'assets/facebook.png', _gradient),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Text(
              'or',
              style: kTextStyle(),
            ),
          ),
          const SizedBox(height: 40),
          _seeBudgetButton(),
          const SizedBox(height: 24),
          const Text(
            'By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff666680),
            ),
          )
        ],
      ),
    );
  }

  Container _socialButtons(String text, Color bgcolor, Color textcolor,
      String imagesrc, Gradient gradient) {
    return Container(
      width: 120,
      height: 50,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(999)),
      child: Container(
        decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, color: bgcolor, offset: const Offset(0, 3))
            ]),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagesrc,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: kTextStyle(
                  color: textcolor, size: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _seeBudgetButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register2(),
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
              color: const Color(0xff3e3e47),
              borderRadius: BorderRadius.circular(999)),
          alignment: Alignment.center,
          child: Text(
            'Sign up with E-mail',
            style: kTextStyle(
                color: Colors.white, size: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
