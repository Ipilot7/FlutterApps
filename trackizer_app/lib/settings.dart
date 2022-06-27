import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MaterialApp(
    home: SubscriptInfoPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class SubscriptInfoPage extends StatelessWidget {
  const SubscriptInfoPage({Key? key}) : super(key: key);
  final Color textColorWhite = const Color(0xffffffff);
  final Color textColor1 = const Color(0xffA2A2B5);
  final LinearGradient _gradient = const LinearGradient(
      colors: [Colors.white24, Colors.transparent],
      transform: GradientRotation(45));
  final bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: kTextStyle(color: const Color(0xffA2A2B5), size: 16),
        ),
        leading: Image.asset(
          'assets/Back.png',
        ),
        backgroundColor: const Color(0xff1c1c23),
      ),
      backgroundColor: const Color(0xff1c1c23),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          Column(
            children: [
              Image.asset(
                'assets/Avatar.png',
                width: 72,
                height: 72,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'John Doe',
                style: kTextStyle(
                    color: Colors.white, size: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'j.doe@gmail.com',
                style: kTextStyle(color: const Color(0xffA2A2B5), size: 12),
              ),

              Container(
                width: 87,
                height: 40,
                margin: const EdgeInsets.only(bottom: 24, top: 16),
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: _gradient,
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff26262f),
                      borderRadius: BorderRadius.circular(14)),
                  alignment: Alignment.center,
                  child: Text(
                    'Edit profile',
                    style: kTextStyle(
                        color: Colors.white,
                        size: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              ///----------------------------------------------------------------
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'General',
                  style: kTextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 24, top: 8),
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: _gradient,
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff26262f),
                      borderRadius: BorderRadius.circular(14)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      _itemButton('assets/FaceID.png', 'Security', 'FaceID'),
                      _itemButton2('assets/iCloud.png', 'iCloud Sync'),
                    ],
                  ),
                ),
              ),

              ///---------------------------------------------------------------

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'My subscriptions',
                  style: kTextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 24, top: 8),
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: _gradient,
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff26262f),
                      borderRadius: BorderRadius.circular(14)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      _itemButton('assets/sorting.png', 'Sorting', 'Date'),
                      _itemButton('assets/chart.png', 'Summary', 'Average'),
                      _itemButton(
                          'assets/money.png', 'Default currency', 'USD (\$)'),
                    ],
                  ),
                ),
              ),

              ///---------------------------------------------------------------
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Appearance',
                  style: kTextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15, top: 8),
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: _gradient,
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff26262f),
                      borderRadius: BorderRadius.circular(14)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      _itemButton('assets/app_icon.png', 'App icon', 'Default'),
                      _itemButton('assets/light_theme.png', 'Theme', 'Dark'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  InkWell _itemButton(String src, String text, String text2) {
    return InkWell(
      child: ListTile(
          leading: Image.asset(
            src,
            color: Colors.white,
            width: 20,
            height: 20,
          ),
          title: Text(
            text,
            style: kTextStyle(color: Colors.white),
          ),
          trailing: Wrap(
            children: [
              Text(
                text2,
                style: kTextStyle(
                    color: const Color(0xffA2A2B5),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset('assets/right_medium.png'),
            ],
          )),
    );
  }

  InkWell _itemButton2(String src, String text) {
    return InkWell(
      child: ListTile(
        leading: Image.asset(
          src,
          color: Colors.white,
          width: 24,
          height: 24,
        ),
        title: Text(
          text,
          style: kTextStyle(color: Colors.white),
        ),
        trailing: CupertinoSwitch(
          value: _switchValue,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
