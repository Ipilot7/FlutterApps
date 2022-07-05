import 'package:html/parser.dart';
import 'package:http/http.dart';

void main(List<String> arguments) async {
  // print('Hello world: ${dart_application_1.calculate()}!');

  Weather().weatherInfo("tashkent");
}

class Weather {
  List a = [];
  String? _value = "Ташкент";
  weatherInfo(String city) async {
    var response = await get(
      Uri.parse('https://pogoda.uz/$city'),
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);

      var today = document.getElementsByClassName("grid-1 cont-block")[0];
      var currenday = document
          .getElementsByClassName('current-day')[0]
          .text; //Сегодня, 4 июля
      var thisday = today.getElementsByTagName("strong")[0].text; //+21
      var oshushayetsa = document
          .getElementsByTagName('span~span~span')[0]
          .text; //ошушается 26 градус
      var yasno = document
          .getElementsByClassName("current-forecast-desc")[0]
          .text; //yasno
      ////// 2-konteyner/////
      var konteyner2 =
          document.getElementsByClassName('current-forecast-details')[0];
      var vla = konteyner2.getElementsByTagName('div p')[0].text;
      var vet = konteyner2.getElementsByTagName('div p~p')[0].text;
      var dav = konteyner2.getElementsByTagName('div p~p~p')[0].text;
      var lun = konteyner2.getElementsByTagName('div~div p')[0].text;
      var vos = konteyner2.getElementsByTagName('div~div p~p')[0].text;
      var zak = konteyner2.getElementsByTagName('div~div p~p~p')[0].text;
      //////3 недельный прогноз/////
      var veatherTable = document.getElementsByClassName('weather-table')[0];

      var denNed = veatherTable.getElementsByTagName('strong strong')[0].text;
      print(denNed);
    }
  }
}
