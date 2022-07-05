import 'package:html/parser.dart';
import 'package:http/http.dart';

import 'weather_model.dart';

void main(List<String> args) {
  weatherInfo('tashkent');
}

var model = WeatherModel();
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
    ///

    var weekDays = [];
    var days = [];
    var tempDays = [];

    var feelings = [];
    var rainPercs = [];

    model.weekDays = weekDays;
    model.days = days;
    model.tempDay = tempDays;
    model.rainPerc = rainPercs;

    var konteyner2 =
        document.getElementsByClassName('current-forecast-details')[0];
    var vla = konteyner2.getElementsByTagName('div p')[0].text.substring(11);
    var vet = konteyner2.getElementsByTagName('div p~p')[0].text.substring(7);
    var dav = konteyner2.getElementsByTagName('div p~p~p')[0].text.substring(9);
    var lun = konteyner2.getElementsByTagName('div~div p')[0].text.substring(6);
    var vos =
        konteyner2.getElementsByTagName('div~div p~p')[0].text.substring(8);
    var zak =
        konteyner2.getElementsByTagName('div~div p~p~p')[0].text.substring(7);

    //////3 недельный прогноз/////
    ///
    // var veatherTable = document.getElementsByClassName('weather-table')[0];
    //   String text = '.weather-table';
    // var tr = veatherTable.getElementsByTagName('tr').length;

    var weatherList = document
        .getElementsByClassName('weather-table')[0]
        .getElementsByTagName('tr');
    for (var i = 1; i < weatherList.length; i++) {
      weekDays.add(weatherList[i].getElementsByTagName('strong')[1].text);
      days.add(weatherList[i].getElementsByTagName('div')[1].text);
      tempDays
          .add(weatherList[i].getElementsByClassName('forecast-day')[0].text);

      feelings.add(
          weatherList[i].getElementsByClassName('weather-row-desc')[0].text);
      rainPercs.add(weatherList[i]
          .getElementsByClassName('weather-row-pop')[0]
          .text
          .trim());
    }

    print(rainPercs);

    return true;
  }
  return false;
}
