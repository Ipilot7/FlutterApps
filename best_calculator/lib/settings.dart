import 'package:best_calculator/utils/constants.dart';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const Settings());
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final settingsController = TextEditingController();
  bool switchValue = false;
  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  bool switchValue4 = false;
  bool switchValue5 = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                      style: kTextstyle(
                          size: 12,
                          color: const Color.fromARGB(255, 53, 53, 59)),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 34,
                              width: 270,
                              child: TextField(
                                controller: settingsController,
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black))),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/historyPage',
                                    arguments: settingsController.text);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black,
                                          offset: Offset(1, 2))
                                    ]),
                                child: const Text('OK'),
                              ),
                            ),
                          )
                        ]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Минимальная точность',
                                style:
                                    kTextstyle(size: 18, color: Colors.black)),
                            Text('Ограничить минимальную точность до 2 цыфр',
                                style: kTextstyle(
                                    size: 12,
                                    color:
                                        const Color.fromARGB(255, 53, 53, 59)))
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Switch(
                                value: switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    switchValue = value;
                                  });
                                }),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Swipe для расчёта',
                                style:
                                    kTextstyle(size: 18, color: Colors.black)),
                            Text(
                                'Провести палец вниз по клавиатуре, чтобы рассчитывать',
                                style: kTextstyle(
                                    size: 12,
                                    color:
                                        const Color.fromARGB(255, 53, 53, 59)))
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Switch(
                                value: switchValue1,
                                onChanged: (value) {
                                  setState(() {
                                    switchValue1 = value;
                                  });
                                }),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Отключить текстовую анимацию',
                                style:
                                    kTextstyle(size: 18, color: Colors.black)),
                            Text(
                                'Отключить текстовую анимацию в главном разделе',
                                style: kTextstyle(
                                    size: 12,
                                    color:
                                        const Color.fromARGB(255, 53, 53, 59)))
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Switch(
                                value: switchValue2,
                                onChanged: (value) {
                                  setState(() {
                                    switchValue2 = value;
                                  });
                                }),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Оставить экран включенным',
                                style:
                                    kTextstyle(size: 18, color: Colors.black)),
                            Text(
                                'Ограничить спящий режим во время работы приложение ',
                                style: kTextstyle(
                                    size: 12,
                                    color:
                                        const Color.fromARGB(255, 53, 53, 59)))
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Switch(
                                value: switchValue3,
                                onChanged: (value) {
                                  setState(() {
                                    switchValue3 = value;
                                  });
                                }),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('выключить выбрацию',
                            style: kTextstyle(size: 18, color: Colors.black)),
                        Switch(
                            value: switchValue4,
                            onChanged: (value) {
                              setState(() {
                                switchValue4 = value;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('cкрыть статус бар',
                            style: kTextstyle(size: 18, color: Colors.black)),
                        Switch(
                            value: switchValue5,
                            onChanged: (value) {
                              setState(() {
                                switchValue5 = value;
                              });
                            }),
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
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/about');
                          },
                          child: Text(
                            'О программе',
                            style: kTextstyle(size: 18, color: Colors.black),
                          ),
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

  // _settingsListTile(String title, String subtitle, bool boolean) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(title, style: kTextstyle(size: 18, color: Colors.black)),
  //           Text(subtitle,
  //               style: kTextstyle(
  //                   size: 12, color: const Color.fromARGB(255, 53, 53, 59)))
  //         ],
  //       ),
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 7),
  //           child: Switch(
  //               value: boolean,
  //               onChanged: (value) {
  //                 setState(() {
  //                   value = !value;
  //                 });
  //               }),
  //         ),
  //       )
  //     ],
  //   );
  // }

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
