// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'constants.dart';
import 'utils.dart';

void main() {
  runApp(const MaterialApp(
    home: WeatherApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final Color textColor1 = const Color(0xff25272E);
  final Color textColor2 = const Color(0xffCBCBCB);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: scafoldGradient)),
        child: SafeArea(
          child: Column(
            children: [
              _appBar(),
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: [
                    const WeatherMainBox(),
                    const WeatherInfoBox(),
                    Text(
                      'Недельный прогноз',
                      style: kTextstyle(
                          size: 22,
                          fontWeight: FontWeight.w700,
                          color: textColorBlack),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        scrollDirection: Axis.horizontal,
                        children: [
                          WeeklyItem(
                            isActive: true,
                            textColor1: textColor1,
                            textColor2: textColor2,
                          ),
                          WeeklyItem(
                            isActive: false,
                            textColor1: textColor1,
                            textColor2: textColor2,
                          ),
                          WeeklyItem(
                            isActive: false,
                            textColor1: textColor1,
                            textColor2: textColor2,
                          ),
                          WeeklyItem(
                            isActive: false,
                            textColor1: textColor1,
                            textColor2: textColor2,
                          ),
                          WeeklyItem(
                            isActive: false,
                            textColor1: textColor1,
                            textColor2: textColor2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 2, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF9A60E5).withOpacity(0.16),
                      blurRadius: 30,
                      offset: const Offset(0, 5)),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/settings.png',
                width: 5,
                height: 5,
              ),
            ),
          ),
          Column(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/Vector.png',
                  width: 20,
                  height: 20,
                ),
                label: Text(
                  'Фергана',
                  style: kTextstyle(
                      size: 20,
                      color: textColorBlack,
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                child: Container(
                  width: 69,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: gradient,
                    ),
                  ),
                  child: Text(
                    'Updating°',
                    style: kTextstyle(
                      size: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/avatar.png',
              width: 45,
              height: 45,
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfoBox extends StatelessWidget {
  const WeatherInfoBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff5555555).withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(5, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/kach.png',
                width: 29,
                height: 29,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Качество воздуха',
                  style: kTextstyle(
                      size: 22,
                      fontWeight: FontWeight.w700,
                      color: textColorBlack),
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff9a60e5).withOpacity(0.16),
                          blurRadius: 30,
                          offset: const Offset(0, 5))
                    ],
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: textColorBlack,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemAboutWeather('dav', 'Давление', '753 мм рт. ст.'),
                  _itemAboutWeather('vet', 'Ветер', 'ЗСЗ, 5.4 м/c'),
                  _itemAboutWeather('vos', 'Восход', '04:46')
                ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _itemAboutWeather('vla', 'Влажность', '10%'),
            _itemAboutWeather('lun', 'Луна', 'Растущая Луна'),
            _itemAboutWeather('zak', 'Закат', '19:46')
          ])
        ],
      ),
    );
  }
}

_itemAboutWeather(String iconName, String title, String subtitle) {
  return Row(
    children: [
      Image.asset(
        'assets/${iconName}.png',
        width: 25,
        height: 25,
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: kTextstyle(
                  size: 10, fontWeight: FontWeight.w700, color: textColorGrey)),
          Text(
            subtitle,
            style: kTextstyle(
                size: 10, fontWeight: FontWeight.w700, color: textColorBlack),
          ),
        ],
      ),
    ],
  );
}

class WeatherMainBox extends StatelessWidget {
  const WeatherMainBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradient),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff5264f0).withOpacity(0.31),
                blurRadius: 30,
                offset: const Offset(10, 15),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Text(
                  'Ясно \n Baxtiyor',
                  style: kTextstyle(size: 26),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '21°',
                    style: kTextstyle(size: 75),
                  ),
                  Text(
                    'Очищается 26°',
                    style: kTextstyle(size: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          child: Image.asset(
            'assets/ic_rain.png',
            height: 160,
            width: 160,
          ),
        ),
        Positioned(
          top: 45,
          right: 20,
          child: Text(
            'Сегодня \n2 июля',
            style: kTextstyle(size: 16),
          ),
        ),
      ],
    );
  }
}

class WeeklyItem extends StatelessWidget {
  WeeklyItem({
    required this.isActive,
    required this.textColor1,
    required this.textColor2,
    Key? key,
  }) : super(key: key);

  bool isActive = false;
  final Color textColor1;
  final Color textColor2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        gradient: isActive ? LinearGradient(colors: gradient) : null,
        borderRadius: BorderRadius.circular(35),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xff5F68ED).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(2, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Text(
            'Пнд',
            style: kTextstyle(
                size: 12,
                color: isActive ? null : textColor1,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '03 Июл',
            style: kTextstyle(
                size: 10,
                color: isActive ? null : textColor2,
                fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Image.asset(
              'assets/ic_mist.png',
              height: 40,
              width: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 3),
            child: Text(
              '23°',
              style: kTextstyle(
                  size: 20,
                  color: isActive ? null : textColor1,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              minWidth: 30,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2DBE8D),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '10%',
              style: kTextstyle(size: 10, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
