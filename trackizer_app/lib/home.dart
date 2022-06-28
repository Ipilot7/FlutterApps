import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'utils/constants.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: 375,
            height: 429,
            alignment: Alignment.center,
            color: const Color(0xff292932),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 23, top: 40),
                    child: Image.asset(
                      'assets/settings.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: 0.7,
                    center: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Image.asset('assets/logo.png'),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            '\$1,235',
                            style: kTextStyle(size: 40),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'This month bills',
                            style:
                                kTextStyle(color: Color(0xff83839C), size: 12),
                          ),
                          _seeBudgetButton(),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _cut('Active subs', '12', const Color(0xffffa799)),
                    _cut('Highest subs', '\$19.99', const Color(0xffad7bff)),
                    _cut('Lowest subs', '\$5.99', const Color(0xff7dffee)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 21, left: 43, right: 43, bottom: 16),
            child: Container(
              width: 328,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xff0e0e12),
                  borderRadius: BorderRadius.circular(14)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Wrap(
                    children: [
                      Container(
                        width: 155,
                        height: 36,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff353542)),
                            color: const Color(0xff1b1b22),
                            borderRadius: BorderRadius.circular(14)),
                        alignment: Alignment.center,
                        child: Text(
                          'Upcoming bills',
                          style: kTextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff0e0e12),
                        borderRadius: BorderRadius.circular(14)),
                    alignment: Alignment.center,
                    child: Text(
                      'Your subscriptions',
                      style: kTextStyle(color: const Color(0xffA2A2B5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              _endButton('assets/littlespotify.png', 'Spotify', '\$5.99'),
              _endButton('assets/yt.png', 'YouTube Premium', '\$18.99'),
              _endButton(
                  'assets/onedrive.png', 'Microsoft OneDrive', '\$29.99'),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 23, right: 23),
        child: Container(
          height: 64,
          margin: const EdgeInsets.only(bottom: 24, top: 8),
          padding: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: _gradient, borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xff30303c),
                borderRadius: BorderRadius.circular(14)),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/Home.png'),
                    Image.asset('assets/Budgets.png'),
                    SizedBox(
                      width: 80,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Color(0xffff8a71),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                    Image.asset('assets/Calendar.png'),
                    Image.asset('assets/Credit Cards.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _seeBudgetButton() {
    return Container(
      width: 120,
      height: 32,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: _gradient, borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff3e3e47),
            borderRadius: BorderRadius.circular(14)),
        alignment: Alignment.center,
        child: Text(
          'See your budget',
          style: kTextStyle(
              color: Colors.white, size: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

//----------------------------------------------------------------------------

  Padding _endButton(String src, String text, String text2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: 328,
        height: 64,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff353542)),
            color: const Color(0xff1c1c23),
            borderRadius: BorderRadius.circular(14)),
        alignment: Alignment.center,
        child: ListTile(
          leading: Image.asset(
            src,
            width: 39,
            height: 39,
          ),
          title: Text(
            text,
            style: kTextStyle(),
          ),
          trailing: Text(
            text2,
            style: kTextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Wrap _cut(String text1, String text2, Color colored) {
    return Wrap(
      children: [
        Container(
          width: 104,
          margin: const EdgeInsets.only(bottom: 24, top: 8),
          padding: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: _gradient, borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xff30303c),
                    borderRadius: BorderRadius.circular(14)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Text(
                            text1,
                            style: kTextStyle(
                                color: const Color(0xff83839c),
                                size: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            text2,
                            style: kTextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Divider(
                  color: colored,
                  height: 0,
                  thickness: 2,
                  indent: 23,
                  endIndent: 23,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
//----------------------------------------------------------------------------
