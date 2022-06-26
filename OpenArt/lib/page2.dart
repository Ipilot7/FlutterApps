import 'package:flutter/material.dart';
import 'package:page3/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final scafoldColor = const Color(0xfff8f8f8);
  final textColor = const Color(0xff333333);
  final _gradient = const LinearGradient(
    colors: [Color(0xff0038f5), Color(0xff9f03ff)],
    transform: GradientRotation(45),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scafoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scafoldColor,
        title: Image.asset('assets/Logo.png', height: 37),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/Search.png',
                width: 18,
                height: 18,
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
            color: scafoldColor,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add wallet to pay',
                    style: kTextstyle(size: 24, color: textColor)),
                const SizedBox(
                  height: 4,
                ),
                Text('Easy to sell your Digital Art with 3 step',
                    style: kTextstyle(
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: textColor)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 36, bottom: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    _circles('1', Colors.white, _gradient),
                    Text('Sellect'),
                  ],
                ),
                Image.asset(
                  'assets/line.png',
                  width: 68,
                ),
                Column(
                  children: [
                    _circles('2', Colors.black45),
                    const Text(
                      'Scan',
                      style: TextStyle(color: Color(0xff888888)),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/line.png',
                  width: 68,
                ),
                Column(
                  children: [
                    _circles('3', Colors.black45),
                    const Text('Confirm',
                        style: TextStyle(color: Color(0xff888888))),
                  ],
                ),
              ],
            ),
          ),
          _itemWallet('Bank wallet'),
          const SizedBox(
            height: 15,
          ),
          _itemWallet('Coin wallet'),
          const SizedBox(
            height: 15,
          ),
          _itemWallet('Wallet connect'),
          Padding(
            padding: const EdgeInsets.only(top: 143),
            child: Image.asset(
              'assets/biglogo.png',
              width: 177,
              height: 46,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textEnd('The ', FontWeight.w200),
              _textEnd('New ', FontWeight.w300),
              _textEnd('Creative ', FontWeight.w500),
              _textEnd('Economy', FontWeight.w900),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin:
                const EdgeInsets.only(bottom: 15, top: 29, left: 15, right: 15),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), gradient: _gradient),
            child: Text(
              'Earn now',
              style: kTextstyle(size: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: const EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0038F5),
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            child: Text(
              'Discover more',
              style: kTextstyle(
                  size: 20, fontWeight: FontWeight.w800, color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

//------------------------------------------------------------------------
  Text _textEnd(String text, FontWeight fontWeight) {
    return Text(
      text,
      style:
          TextStyle(color: Colors.black, fontSize: 30, fontWeight: fontWeight),
    );
  }

  Container _circles(String text, Color? color, [Gradient? gradient]) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: gradient, color: Color(0xffDCDCDC)),
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }

  Container _itemWallet(String text) {
    return Container(
      alignment: Alignment.center,
      width: 343,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 13),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xff14142B),
                  size: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff555555),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
