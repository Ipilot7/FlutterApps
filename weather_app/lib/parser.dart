import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'weather_model.dart';

void main(List<String> arguments) async {
  // print('Hello world: ${dart_application_1.calculate()}!');

  Weather().weatherInfo("tashkent");
}

class Weather {
  var model = WeatherModel();

  var date = DateTime.now();

  String? city = "Ташкент";
  Future<bool> weatherInfo(String city) async {
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
      return true;
    }
    return false;
  }
}
