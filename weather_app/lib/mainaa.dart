import 'package:flutter/material.dart';
import 'constants.dart';
import 'utils.dart';

void main() {
  runApp(const MaterialApp(
    home: Weather(),
    debugShowCheckedModeBanner: false,
  ));
}

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var dropDownActive = list[0];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF9A60E5).withOpacity(0.50),
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
                      )),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/Vector.png',
                          width: 15,
                          height: 17,
                        ),
                        Text(
                          'Фергана',
                          style: kTextstyle(
                              size: 20,
                              color: textColorBlack,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
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
          ),
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: 340,
                  height: 220,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 340,
                          height: 202,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xFF9A60E5).withOpacity(0.50),
                                  blurRadius: 30,
                                  offset: const Offset(0, 5)),
                            ],
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: gradient,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Text(
                                  'Ясно',
                                  style: kTextstyle(size: 26),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, top: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Сегодня \n2 июля',
                                      style: kTextstyle(size: 16),
                                    ),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/ic_rain.png',
                            width: 150,
                            height: 140,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              width: 340,
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset(
                            'assets/kach.png',
                            width: 29,
                            height: 29,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 66),
                          child: Text(
                            'Качество воздуха',
                            style: kTextstyle(
                                size: 22,
                                fontWeight: FontWeight.w600,
                                color: textColorBlack),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.refresh,
                            color: textColorBlack,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _itemAboutWeather(
                              'assets/dav.png', 'Давление', '753 мм рт. ст.'),
                          _itemAboutWeather(
                              'assets/vet.png', 'Ветер', 'ЗСЗ, 5.4 м/c'),
                          _itemAboutWeather('assets/vos.png', 'Восход', '04:46')
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _itemAboutWeather(
                              'assets/vla.png', 'Влажность', '10%'),
                          _itemAboutWeather(
                              'assets/lun.png', 'Луна', 'Растущая Луна'),
                          _itemAboutWeather('assets/zak.png', 'Закат', '19:46')
                        ])
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'Недельный прогноз',
              style: kTextstyle(
                  size: 22, fontWeight: FontWeight.w700, color: textColorBlack),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _itemWeekListGradient(),
                // _itemWeekListGradient(),
                // _itemWeekListGradient(),
                // _itemWeekListGradient(),
                _itemWeekList(),
                _itemWeekList(),
                _itemWeekList(),
                _itemWeekList(),
                _itemWeekList(),
              ],
            ),
          ),
          // DropdownButton(value: value, items:list.map(buildMenuItem).toList(), onChanged: (value)=>setState(()=>this.value=value),)
        ],
      ),
    );
  }

  _itemWeekList() {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Container(
        width: 66,
        height: 190,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Пнд',
              style: kTextstyle(size: 12, color: textColorBlack),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 13),
              child: Text(
                '03 Июл',
                style: kTextstyle(size: 10, color: textColorGrey),
              ),
            ),
            Image.asset('assets/sun.png'),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 13),
              child: Text(
                '23°',
                style: kTextstyle(size: 22, color: textColorBlack),
              ),
            ),
            Container(
              width: 30,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorGreen,
              ),
              child: Text(
                '10%',
                style: kTextstyle(size: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _itemWeekListGradient() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 66,
      height: 190,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF9A60E5).withOpacity(0.50),
              blurRadius: 30,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Пнд',
            style: kTextstyle(size: 12),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 13),
            child: Text(
              '03 Июл',
              style: kTextstyle(size: 10),
            ),
          ),
          Image.asset('assets/cloud.png'),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 13),
            child: Text(
              '23°',
              style: kTextstyle(
                size: 22,
              ),
            ),
          ),
          Container(
            width: 30,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorGreen,
            ),
            child: Text(
              '10%',
              style: kTextstyle(size: 10),
            ),
          ),
        ],
      ),
    );
  }

  _itemAboutWeather(String icon, String title, String subtitle) {
    return Row(
      children: [
        Image.asset(
          'assets/${icon}.png',
          width: 28,
          height: 22,
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: kTextstyle(
                    size: 10,
                    fontWeight: FontWeight.w700,
                    color: textColorGrey)),
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
  // DropdownMenuItem<String> buildMenuItem(String text)=>DropdownMenuItem(child: text, )
}
