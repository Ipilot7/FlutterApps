import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var holidays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather forecast',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              labelText: "Enter City Name",
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          const Text(
            'Murmansk Oblast, RU',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
          const Text(
            'Friday, Mar 20,2020',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.sunny,
                size: 50,
                color: Colors.white,
              ),
              Column(
                children: const [
                  Text(
                    "14 °F",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'LIGHT SNOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'km/hr',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Text(
            '7-DAYS WEATHER FORECAST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                7,
                (index) => Container(
                    height: 80,
                    padding: const EdgeInsets.all(5),
                    width: 120,
                    color: Colors.red[100],
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(
                          '${holidays[index]}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '6 F',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.sunny,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
