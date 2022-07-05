import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'constants.dart';
import 'utils.dart';
import 'weather_model.dart';

void main() {
  runApp(const MaterialApp(
    home: MyWidget(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List weatherList = [];
  String city = "Ташкент";

  WeatherModel model = WeatherModel();

  Future<bool> weatherInfo(String city) async {
    var response = await get(
      Uri.parse('https://pogoda.uz/$city'),
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var block1 = document.getElementsByClassName("grid-1 cont-block")[0];
      //to today list//
      var today = document
          .getElementsByClassName('current-day')[0]
          .text; //Сегодня, 4 июля
      model.today?.add(today);
      var tempDay = block1.getElementsByTagName("strong")[0].text; //+21
      model.today?.add(tempDay);

      var oshushayetsa = document
          .getElementsByTagName('span~span~span')[0]
          .text; //ошушается 26 градус
      model.today?.add(oshushayetsa);

      var yasno = document
          .getElementsByClassName("current-forecast-desc")[0]
          .text; //yasno
      model.today?.add(yasno);
      // model.today = [today, tempDay, oshushayetsa, yasno];

      ////// to block 2 list/////
      var konteyner2 =
          document.getElementsByClassName('current-forecast-details')[0];
      var vla = konteyner2.getElementsByTagName('div p')[0].text;
      var vet = konteyner2.getElementsByTagName('div p~p')[0].text;
      var dav = konteyner2.getElementsByTagName('div p~p~p')[0].text;
      var lun = konteyner2.getElementsByTagName('div~div p')[0].text;
      var vos = konteyner2.getElementsByTagName('div~div p~p')[0].text;
      var zak = konteyner2.getElementsByTagName('div~div p~p~p')[0].text;
      model.block2 = [vla];

      //////3 недельный прогноз/////
      var veatherTable = document.getElementsByClassName('weather-table')[0];
      String text = '.weather-table';

      var tr = veatherTable.getElementsByTagName('tr').length;
      // var day2 = veatherTable.getElementsByTagName('tr~tr')[0].text;
      List weekdays =
          veatherTable.querySelectorAll("${text} tr~tr td~td strong"); //sr
      List day = veatherTable
          .querySelectorAll("${text} tr~tr td~td strong~div"); //6-iyul
      List tempday = veatherTable
          .querySelectorAll("${text} tr~tr td~td~td~td span"); //23 gradus
      var osadki = veatherTable
          .querySelectorAll("${text} tr~tr td~td~td~td~td~td "); //0%

      // for (int i = 0; 0 < tr - 1; i++) {
      //   var model = WeatherModel();

      //   model.weekDays = weekdays[i].text;
      //   model.days = day[i].text;
      //   model.tempDay = tempday[i].text;
      //   model.feeling = osadki[i].text;
      // }
      weatherList.add(model);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: scafoldGradient)),
        child: FutureBuilder(
          future: Weather().weatherInfo("tashkent"),
          builder: ((ctx, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  _appBar(),
                  _ItemWeatherBox(),
                  _itemBoxInfo(),
                  Text('ddss${model.block2?[0]}'),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Недельный прогноз',
                      style: kTextstyle(
                          size: 22,
                          fontWeight: FontWeight.w700,
                          color: textColorBlack),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 34, left: 25, right: 25, bottom: 25),
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
                ],
              );
            }
            return ListView(
              children: [
                _appBar(),
                _ItemWeatherBox(),
                _itemBoxInfo(),
                Text('ddss${model.block2?[0]}'),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Недельный прогноз',
                    style: kTextstyle(
                        size: 22,
                        fontWeight: FontWeight.w700,
                        color: textColorBlack),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 34, left: 25, right: 25, bottom: 25),
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
              ],
            );
          }),
        ),
      ),
    );
  }

  _showMessage(String text, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green[400],
        content: Text(
          text,
          style: kTextstyle(size: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Padding _appBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
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
    );
  }

  Padding _ItemWeatherBox() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Stack(
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
                      '21',
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
      ),
    );
  }

  Container _itemBoxInfo() {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.only(left: 20, right: 20),
      width: 340,
      height: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff5555555).withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(5, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/kach.png',
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _itemAboutWeather('dav', 'Давление', '753 мм рт. ст.'),
            _itemAboutWeather('vet', 'Ветер', 'ЗСЗ, 5.4 м/c'),
            _itemAboutWeather('vos', 'Восход', '04:46')
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemAboutWeather('vla', 'Влажность', '10%'),
              _itemAboutWeather('lun', 'Луна', 'Растущая Луна'),
              _itemAboutWeather('zak', 'Закат', '19:46')
            ],
          ),
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
          width: 25,
          height: 25,
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
}

class Weather {
  var model = WeatherModel();

  var date = DateTime.now();

  String? city = "Ташкент";
  weatherInfo(String city) async {
    WeatherModel model = WeatherModel();
    var response = await get(
      Uri.parse('https://pogoda.uz/$city'),
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var block1 = document.getElementsByClassName("grid-1 cont-block")[0];
      //to today list//
      var today = document
          .getElementsByClassName('current-day')[0]
          .text; //Сегодня, 4 июля
      var tempDay = block1.getElementsByTagName("strong")[0].text; //+21
      var oshushayetsa = document
          .getElementsByTagName('span~span~span')[0]
          .text; //ошушается 26 градус
      var yasno = document
          .getElementsByClassName("current-forecast-desc")[0]
          .text; //yasno
      model.today = [today, tempDay, tempDay, oshushayetsa, yasno];

      ////// to block 2 list/////
      var konteyner2 =
          document.getElementsByClassName('current-forecast-details')[0];
      var vla = konteyner2.getElementsByTagName('div p')[0].text;
      var vet = konteyner2.getElementsByTagName('div p~p')[0].text;
      var dav = konteyner2.getElementsByTagName('div p~p~p')[0].text;
      var lun = konteyner2.getElementsByTagName('div~div p')[0].text;
      var vos = konteyner2.getElementsByTagName('div~div p~p')[0].text;
      var zak = konteyner2.getElementsByTagName('div~div p~p~p')[0].text;
      model.block2 = [vla, vet, dav, lun, vos, zak];
      print(model.block2?[0]);
      //////3 недельный прогноз/////

      var veatherTable = document.getElementsByClassName('weather-table')[0];
      String text = '.weather-table';

      var tr = veatherTable.getElementsByTagName('tr').length;
      // var day2 = veatherTable.getElementsByTagName('tr~tr')[0].text;
      List weekdays =
          veatherTable.querySelectorAll("${text} tr~tr td~td strong"); //sr
      List day = veatherTable
          .querySelectorAll("${text} tr~tr td~td strong~div"); //6-iyul
      List tempday = veatherTable
          .querySelectorAll("${text} tr~tr td~td~td~td span"); //23 gradus
      var osadki = veatherTable
          .querySelectorAll("${text} tr~tr td~td~td~td~td~td "); //0%

      // for (int i = 0; 0 < tr - 1; i++) {
      //   var model = WeatherModel();

      //   model.weekDays = weekdays[i].text;
      //   model.days = day[i].text;
      //   model.tempDay = tempday[i].text;
      //   model.feeling = osadki[i].text;
      // }
    }
  }
}
