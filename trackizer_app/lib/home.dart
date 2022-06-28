import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'utils/constants.dart';
//---------------------------bottomNav bar-------------------------------------

//---------------------------bottomNav bar-------------------------------------

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
                  center: const Text(
                    "70.0%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _cut('adas', 'adasd', Colors.orange),
                    _cut('adas', 'adasd', Colors.orange),
                    _cut('adas', 'adasd', Colors.orange),
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
          // Wrap(
          //   children: [
          //     Container(
          //       width: 104,
          //       margin: const EdgeInsets.only(bottom: 24, top: 8),
          //       padding: const EdgeInsets.all(2),
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //           gradient: _gradient,
          //           borderRadius: BorderRadius.circular(16)),
          //       child: Stack(
          //         children: [
          //           Container(
          //             decoration: BoxDecoration(
          //                 color: const Color(0xff30303c),
          //                 borderRadius: BorderRadius.circular(14)),
          //             alignment: Alignment.center,
          //             child: Row(children: [
          //               Image.asset()
          //             ]),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        bottomBarItems: const [
          BottomBarItemsModel(
            icon: Icon(Icons.home, size: 20),
            iconSelected:
                Icon(Icons.home, color: AppColors.cherryRed, size: 20),
            title: 'Home',
            dotColor: Colors.red,
          ),
          BottomBarItemsModel(
            icon: Icon(Icons.search, size: 20),
            iconSelected:
                Icon(Icons.search, color: AppColors.cherryRed, size: 20),
            dotColor: Colors.red,
          ),
          BottomBarItemsModel(
            icon: Icon(Icons.person, size: 20),
            iconSelected:
                Icon(Icons.person, color: AppColors.cherryRed, size: 20),
            dotColor: Colors.red,
          ),
          BottomBarItemsModel(
            icon: Icon(Icons.settings, size: 20),
            iconSelected:
                Icon(Icons.settings, color: AppColors.cherryRed, size: 20),
            dotColor: Colors.red,
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: AppColors.cherryRed,
          centerIcon: const FloatingCenterButton(
            child: Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          centerIconChild: [
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.home,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.home,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.home,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
          ],
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
                  indent: 20,
                  endIndent: 20,
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
