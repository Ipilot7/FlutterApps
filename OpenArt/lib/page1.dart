import 'package:flutter/material.dart';
import 'constant.dart';

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
    const String data =
        'Together with my design team, we designed this futuristic Cyberyacht concept artwork. We wanted to create something that has not been created yet, so we started to collect ideas of how we imagine the Cyberyacht could look like in the future.';
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
            icon: const Icon(Icons.menu, color: Colors.black),
            color: scafoldColor,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/Rectangle.png',
              width: double.infinity,
              height: 430,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Silent Color',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_outline,
                      color: textColor,
                      size: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: textColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffff9c80),
                          Color(0xffffd803),
                        ],
                        transform: GradientRotation(50),
                      ),
                    ),
                    child: Text(
                      'H',
                      style: kTextstyle(
                        size: 20,
                      ),
                    ),
                  ),
                  label: Text(
                    '@openart',
                    style: kTextstyle(
                        size: 16,
                        color: textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: buttonStyle(
                      color: Colors.white,
                      shadowColor: Colors.black12,
                      elevation: 10,
                      padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
                      borderRadius: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              data,
              style: kTextstyle(color: textColor, size: 13, height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                _itemTip('#color'),
                _itemTip('#circle'),
                _itemTip('#black'),
                _itemTip('#art'),
              ],
            ),
          ),
          _ItemView(Icons.wb_incandescent, 'View on Etherscan'),
          _ItemView(Icons.star_border, 'View on Etherscan'),
          _ItemView(Icons.auto_graph, 'View on Etherscan'),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Curent Bid',
                  style: kTextstyle(
                    color: textColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        '0.50 ETH',
                        style: kTextstyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            size: 24),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '\$2.683.73',
                        style: kTextstyle(
                            size: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Auction ending in',
                  style: kTextstyle(size: 20, color: textColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _itemView('12', 'hours'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: _itemView('30', 'minutes'),
                        ),
                        _itemView('25', 'seconds'),
                      ]),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: _gradient),
                  child: Text(
                    'Place a bid',
                    style: kTextstyle(size: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Text(
            'Activity',
            style: kTextstyle(size: 20, color: textColor),
          ),
          const SizedBox(
            height: 30,
          ),
          _itemActivity(),
          _itemActivity(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
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
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: const EdgeInsets.only(bottom: 10, top: 29),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: _gradient),
                child: Text(
                  'Earn now',
                  style: kTextstyle(size: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: const EdgeInsets.only(
                  bottom: 60,
                ),
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
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

//-----------------------------------------------------------------------------
  Text _textEnd(String text, FontWeight fontWeight) {
    return Text(
      text,
      style:
          TextStyle(color: Colors.black, fontSize: 26, fontWeight: fontWeight),
    );
  }

  Padding _itemActivity() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: Colors.white,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Image.asset('assets/image.png'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bid place by @pawel09',
              style: kTextstyle(fontWeight: FontWeight.bold, color: textColor),
            ),
            Text(
              'June 06, 2021 at 12:00am',
              style: kTextstyle(fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '1.50 ETH',
                style: kTextstyle(
                    fontWeight: FontWeight.bold, color: textColor, size: 16),
              ),
              Text(
                '\$2,683.73',
                style: kTextstyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    size: 13),
              ),
            ],
          ),
        ),
        trailing: Column(
          children: const [
            Icon(
              Icons.launch,
              color: Colors.black54,
              size: 24,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
      ),
    );
  }

  Column _itemView(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextstyle(
              size: 24, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        Text(
          subtitle,
          style: kTextstyle(
              size: 13, color: Colors.black54, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Container _ItemView(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: textColor,
          size: 30,
        ),
        title: Text(
          title,
          style: kTextstyle(
              size: 16, color: textColor, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.launch,
          color: Colors.black54,
          size: 24,
        ),
      ),
    );
  }

  Widget _itemTip(String text) {
    return TextButton(
      style: buttonStyle(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        borderRadius: 20,
        side: const BorderSide(color: Colors.black26),
        size: const Size(50, 30),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: kTextstyle(size: 13, color: Colors.black54),
      ),
    );
  }
}
