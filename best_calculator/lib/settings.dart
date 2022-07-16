import 'package:best_calculator/utils/constants.dart';
import 'package:best_calculator/utils/utils.dart';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Settings());
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.grey,
              title: const TabBar(
                  tabs: [Tab(text: 'Настройки'), Tab(text: 'Tемы')]),
            ),
            body: TabBarView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Изменение текста основного экрана',
                      style: kTextstyle(size: 12, color: const Color.fromARGB(255, 53, 53, 59)),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              height: 34,
                              width: 270,
                              child: TextField(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black))),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.black,
                                        offset: Offset(1, 2))
                                  ]),
                              child: Text('OK'),
                            ),
                          )
                        ]),
                    SizedBox(height: 20),
                    _settingsListTile('Минимальная точность',
                        'Ограничить минимальную точность до 2 цыфр', true),
                    _settingsListTile(
                        'Swipe для расчёта',
                        'Провести палец вниз по клавиатуре, чтобы рассчитывать',
                        true),
                    _settingsListTile('Отключить текстовую анимацию',
                        'Отключить текстовую анимацию в главном разделе', true),
                    _settingsListTile(
                        'Оставить экран включенным',
                        'Ограничить спящий режим во время работы приложение ',
                        true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('выключить выбрацию',
                            style: kTextstyle(size: 18, color: Colors.black)),
                        Switch(value: true, onChanged: (f) {})
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('cкрыть статус бар',
                            style: kTextstyle(size: 18, color: Colors.black)),
                        Switch(value: true, onChanged: (f) {})
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black,
                          child: Text(
                            "i",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          'О программе',
                          style: kTextstyle(size: 18, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
              _themes()
            ]),
          )),
    );
  }

  _settingsListTile(String title, String subtitle, bool bool) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: kTextstyle(size: 18, color: Colors.black)),
            Text(subtitle,
                style: kTextstyle(size: 12, color: const Color.fromARGB(255, 53, 53, 59)))
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Switch(value: bool, onChanged: (hgu) {}),
          ),
        )
      ],
    );
  }

  GridView _themes() {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.41 / 0.73),
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            'assets/drawImages/${index + 1}.png',
            fit: BoxFit.contain,
          );
        });
  }
}
