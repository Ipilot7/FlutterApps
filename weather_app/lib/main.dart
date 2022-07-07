import 'dart:io';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'utils/constants.dart';
import 'utils/utils.dart';
import 'weather_model.dart';
import 'utils/hive_util.dart';
import 'package:intl/intl.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<WeatherModel>(WeatherModelAdapter());
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

class _MyWidgetState extends State<MyWidget> with HiveUtil {
  List<WeatherModel> listweather = [];

  Future<bool?> weatherInfo(String city) async {
    if (await loadLocalData()) {
      try {
        listweather.clear();

        var response = await get(
          Uri.parse('https://pogoda.uz/$city'),
        );
        if (response.statusCode == 200) {
          var document = parse(response.body);
          var block1 = document.getElementsByClassName("grid-1 cont-block")[0];
          //to today list//
          var today = document
              .getElementsByClassName('current-day')[0]
              .text
              .substring(9); //Сегодня, 4 июля

          var tempDay = block1.getElementsByTagName("strong")[0].text; //+21

          var oshushayetsa = document
              .getElementsByTagName('span~span~span')[0]
              .text; //ошушается 26 градус

          var yasno = document
              .getElementsByClassName("current-forecast-desc")[0]
              .text; //yasno
          model.today = [today, tempDay, oshushayetsa, yasno];
          // model.today = [today, tempDay, oshushayetsa, yasno];

          ////// to block 2 list/////
          var konteyner2 =
              document.getElementsByClassName('current-forecast-details')[0];
          var vla =
              konteyner2.getElementsByTagName('div p')[0].text.substring(11);
          var vet =
              konteyner2.getElementsByTagName('div p~p')[0].text.substring(7);
          var dav =
              konteyner2.getElementsByTagName('div p~p~p')[0].text.substring(9);
          var lun =
              konteyner2.getElementsByTagName('div~div p')[0].text.substring(6);
          var vos = konteyner2
              .getElementsByTagName('div~div p~p')[0]
              .text
              .substring(8);
          var zak = konteyner2
              .getElementsByTagName('div~div p~p~p')[0]
              .text
              .substring(7);
          model.block2 = [vla, vet, dav, lun, vos, zak];

          //////3 недельный прогноз/////
          var weekDays = [];
          var days = [];
          var tempDays = [];

          var feelings = [];
          var rainPercs = [];

          var weatherList = document
              .getElementsByClassName('weather-table')[0]
              .getElementsByTagName('tr');
          for (var i = 1; i < weatherList.length; i++) {
            weekDays.add(weatherList[i].getElementsByTagName('strong')[1].text);
            days.add(weatherList[i].getElementsByTagName('div')[1].text);
            tempDays.add(
                weatherList[i].getElementsByClassName('forecast-day')[0].text);

            feelings.add(weatherList[i]
                .getElementsByClassName('weather-row-desc')[0]
                .text);
            rainPercs.add(weatherList[i]
                .getElementsByClassName('weather-row-pop')[0]
                .text
                .trim());
          }

          model.weekDays = weekDays;
          model.days = days;
          model.tempDay = tempDays;
          model.rainPerc = rainPercs;

          listweather.add(model);
          await saveBox<String>(dateBox,
              DateFormat('dd.MM.yyyy').format(DateTime.now()).toString());
          await saveBox<List<WeatherModel>>(weatherBox, listweather);

          return true;
        } else {
          _showMessage('Unknown Error');
        }
      } on SocketException {
        _showMessage('Connection Error');
      } catch (e) {
        _showMessage(e.toString());
      }
    }
    return null;
  }

  @override
  void initState() {
    isActiveIndex = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: scafoldGradient)),
        child: FutureBuilder(
          // future: model == null ? weatherInfo(linkToCity) : null,
          future: weatherInfo(linkToCity),
          builder: ((ctx, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _appBar(),
                  _ItemWeatherBox(),
                  _itemBoxInfo(),
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return _itemWeek(
                          '${model.weekDays?[index]}',
                          '${model.days?[index]}',
                          '${model.feeling?[index]}',
                          '${model.tempDay?[index]}',
                          '${model.rainPerc?[index]}',
                          (isActiveIndex ?? 0) == index,
                          () {
                            setState(
                              () {
                                isActiveIndex = index;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center();
          }),
        ),
      ),
    );
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String>(dateBox);
      if (date ==
          DateFormat('dd.MM.yyyy')
              .format(DateTime.now().add(const Duration(days: -1)))) {
        listweather = await getBox(weatherBox) ?? [];
        return false;
      } else {
        return true;
      }
    } catch (e) {
      _showMessage(e.toString());
    }

    return true;
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
                  DropdownButton(
                    value: newCity,
                    items: cityUz
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: kTextstyle(
                                color: textColorBlack,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        newCity = newValue!;
                        linkToCity = newValue.toLowerCase();
                      });
                    },
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
      padding: const EdgeInsets.all(25),
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
                    model.today?[3],
                    style: kTextstyle(size: 26),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientText(
                      model.today?[1],
                      gradient: textGradient,
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ощушается ${model.today?[2]}',
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
              'Сегодня\n${model.today?[0]}',
              style: kTextstyle(size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Container _itemBoxInfo() {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: 340,
      height: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff555555).withOpacity(0.05),
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
              const SizedBox(
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
                onTap: () {
                  setState(() {
                    listweather.clear();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: textColorBlack,
                  size: 20,
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _itemAboutWeather('dav', 'Давление', model.block2?[2]),
            _itemAboutWeather(
                'vet', 'Ветер', '${model.block2?[1].toString().split(',')[1]}'),
            _itemAboutWeather('vos', 'Восход', model.block2?[4])
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemAboutWeather('vla', 'Влажность', model.block2?[0]),
              _itemAboutWeather('lun', 'Луна', model.block2?[3]),
              _itemAboutWeather('zak', 'Закат', model.block2?[5])
            ],
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

Widget _itemWeek(String shortWeek, String shortDate, String feeling,
    String temp, String perc, bool grd, void Function()? onClick) {
  return InkWell(
    onTap: onClick,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 66,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        gradient: grd
            ? const LinearGradient(
                colors: [
                  Color(0xffE662E5),
                  Color(0xff5364F0),
                ],
                transform: GradientRotation(2 * pi / 13),
              )
            : null,
      ),
      child: Column(
        children: [
          const SizedBox(height: 17),
          Text(
            shortWeek,
            style: kTextstyle(
                size: 12,
                fontWeight: FontWeight.w600,
                color: grd ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 5),
          Text(
            shortDate,
            style: kTextstyle(
                size: 12,
                fontWeight: FontWeight.w600,
                color: grd ? Colors.white : Colors.grey),
          ),
          const SizedBox(height: 13),
          SizedBox(
            width: 40,
            height: 40,
            child: Image(
              image: _weatherIcon(feeling.trim()),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10),
            child: Text(
              temp,
              style: kTextstyle(
                  size: 22,
                  fontWeight: FontWeight.w600,
                  color: grd ? Colors.white : Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 30,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff2DBE8D),
            ),
            child: Text(
              perc,
              style: kTextstyle(size: 10, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ),
  );
}

AssetImage _weatherIcon(String? position) {
  if (position!.trim().contains('ochiq havo')) {
    return const AssetImage('assets/ic_sunny.png');
  } else if (position.trim().contains('bulutli')) {
    return const AssetImage('assets/ic_mist.png');
  } else if (position.trim().contains("yomg'ir")) {
    return const AssetImage('assets/ic_drizzle.png');
  } else if (position.trim().contains("chaqmoq")) {
    return const AssetImage('assets/ic_storm.png');
  } else if (position.trim().contains("qor")) {
    return const AssetImage('assets/ic_snow.png');
  }
  return const AssetImage('assets/ic_cloudy.png');
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    Key? key,
    required this.gradient,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
