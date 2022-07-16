import 'package:best_calculator/settings.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'utils/constants.dart';
import 'utils/utils.dart';
import 'utils/button.dart';
import 'utils/themeColors.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final userInput = TextEditingController();
  final answer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: Drawer(
              backgroundColor: drawerBGColor,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                children: [
                  _themes(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        style: buttonStyle(color: iconActiveColor),
                        onPressed: () {},
                        child: Text(
                          'More Themes',
                          style: kTextstyle(
                            size: 24,
                          ),
                        )),
                  )
                ],
              ),
            ),
            backgroundColor: bodyBgColor,
            appBar: AppBar(
              iconTheme: IconThemeData(color: iconActiveColor),
              backgroundColor: appBarBgColor,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.settings,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()));
                    }),
                const SizedBox(
                  width: 10,
                )
              ],
              title: TabBar(
                labelColor: iconActiveColor,
                indicatorColor: iconActiveColor,
                tabs: [
                  Tab(
                      icon: Icon(Icons.calculate,
                          color: iconActiveColor, size: 28)),
                  Tab(
                      icon: Icon(Icons.monetization_on_outlined,
                          color: iconActiveColor, size: 28)),
                  Tab(icon: Icon(Icons.rule, color: iconActiveColor, size: 28)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset('assets/history.png')),
                              ),
                              TextField(
                                controller: userInput,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              TextField(
                                controller: answer,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                    GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          // del Button
                          if (index == 3) {
                            return MyButton(
                              buttontapped: () {
                                setState(() {
                                  userInput.text = '';
                                  answer.text = '0';
                                });
                              },
                              buttonText: buttons[index],
                              color: operationsBgColor,
                              textColor: iconActiveColor,
                            );
                            // / button
                          } else if (index == 2) {
                            return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    userInput.text += buttons[index];
                                  });
                                },
                                buttonText: buttons[index],
                                color: operationsBgColor,
                                textColor: iconActiveColor);
                          }
                          // x button
                          else if (index == 7) {
                            return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    userInput.text += buttons[index];
                                  });
                                },
                                buttonText: buttons[index],
                                color: operationsBgColor,
                                textColor: iconActiveColor);
                          } else if (index == 1) {
                            return MyButton(
                              buttontapped: () {
                                setState(() {
                                  if (userInput.text != null ||
                                      userInput.text != 0) {
                                    var a = (int.parse(userInput.text) * 0.01)
                                        .toString();
                                    // userInput.text += buttons[index];
                                    answer.text = a;

                                    equalPressed();
                                  }
                                  userInput.text = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: operationsBgColor,
                              textColor: iconActiveColor,
                            );
                          }

                          // Equal_to Button
                          else if (index == 19) {
                            return MyButton(
                              buttontapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              buttonText: buttons[index],
                              color: operationsBgColor,
                              textColor: iconActiveColor,
                            );
                          }

                          //  other buttons
                          else {
                            return MyButton(
                              buttontapped: () {
                                setState(() {
                                  userInput.text += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperator(buttons[index])
                                  ? operationsBgColor
                                  : numbersBgColor,
                              textColor: isOperator(buttons[index])
                                  ? iconActiveColor
                                  : numbersColor,
                            );
                          }
                        }),
                    InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Container(
                                      child: GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: shModButtons.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            //  other buttons

                                            return MyButton(
                                              buttontapped: () {
                                                setState(() {
                                                  userInput.text +=
                                                      shModButtons[index];
                                                });
                                              },
                                              buttonText: shModButtons[index],
                                              color: isOperator(
                                                      shModButtons[index])
                                                  ? operationsBgColor
                                                  : numbersBgColor,
                                              textColor: isOperator(
                                                      shModButtons[index])
                                                  ? iconActiveColor
                                                  : numbersColor,
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          color: iconActiveColor,
                          width: size.width,
                          height: 30,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 25),
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 29),
                      decoration:
                          BoxDecoration(color: operationsBgColor, boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75),
                        )
                      ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('From currency',
                                    style: kTextstyle(
                                        size: 16, color: fromCurrencyColor)),
                              ),
                              Icon(
                                Icons.refresh,
                                size: 40,
                                color: numbersColor,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _listTile('usd', 'USD', 'American dollar'),
                              SizedBox(
                                  height: 34,
                                  width: 172,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: fromCurrencyColor))),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('In currency',
                                style: kTextstyle(
                                    size: 16, color: inCurrencyColor)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _listTile('uzs', 'UZS', 'Uzsbekistan sum'),
                              SizedBox(
                                  height: 34,
                                  width: 172,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: inCurrencyColor))),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: operationsBgColor,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                offset: Offset(0.0, 0.75),
                              )
                            ]),
                        child: Container(
                          color: Colors.white,
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numbers.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // Clear Button
                                if (index == 11) {
                                  return MyButton(
                                    buttontapped: () {
                                      setState(() {
                                        // userInput = '';
                                        // answer = '0';
                                      });
                                    },
                                    buttonText: numbers[index],
                                    color: operationsBgColor,
                                    textColor: iconActiveColor,
                                  );
                                }

                                // Delete Button
                                else if (index == 3) {
                                  return MyButton(
                                    buttontapped: () {
                                      // setState(() {
                                      //   userInput = userInput.substring(
                                      //       0, userInput.length - 1);
                                      // });
                                    },
                                    buttonText: numbers[index],
                                    color: operationsBgColor,
                                    textColor: iconActiveColor,
                                  );
                                }

                                //  other buttons
                                else {
                                  return MyButton(
                                    buttontapped: () {
                                      // setState(() {
                                      //   userInput += numbers[index];
                                      // });
                                    },
                                    buttonText: numbers[index],
                                    color: operationsBgColor,
                                    textColor:
                                        isCurrencyOperator(numbers[index])
                                            ? iconActiveColor
                                            : numbersColor,
                                  );
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: DefaultTabController(
                    length: 7,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: bodyBgColor,
                      appBar: AppBar(
                        backgroundColor: appBarBgColor,
                        title: TabBar(
                            indicatorColor: iconActiveColor,
                            labelColor: iconActiveColor,
                            isScrollable: true,
                            tabs: const [
                              Tab(text: 'DISTANCE'),
                              Tab(text: 'AREA'),
                              Tab(text: 'MASS'),
                              Tab(text: 'VOLUME'),
                              Tab(text: 'TEMPERATURE'),
                              Tab(text: 'FUEL'),
                              Tab(text: 'COOCKING'),
                            ]),
                      ),
                      body: TabBarView(children: [
                        Column(
                          children: [
                            Container(
                                color: appBarBgColor,
                                height: 170,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'm',
                                              style: kTextstyle(
                                                  size: 20,
                                                  color: iconActiveColor),
                                            ),
                                            DropdownButton(
                                              items: <String>['km', 'm']
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                    child: Text(value),
                                                    value: value);
                                              }).toList(),
                                              onChanged: (_) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(
                                          child: TextField(
                                        minLines: 1,
                                        maxLines: 4,
                                      )),
                                    ])),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            listTile3page('title', 'subtitle',
                                                'trailing', index))),
                          ],
                        ),
                        Text('hellooo'),
                        Text('hellooo'),
                        Text('hellooo'),
                        Text('hellooo'),
                        Text('hellooo'),
                        Text('hellooo'),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  listTile3page(String title, String subtitle, String trailing, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: index.isOdd ? numbersBgColor : listViewColor,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kTextstyle(size: 12, color: iconActiveColor),
              ),
              Text(subtitle,
                  style: kTextstyle(size: 24, color: iconActiveColor)),
            ],
          ),
          Text(trailing, style: kTextstyle(size: 24, color: iconActiveColor)),
        ]),
      ),
    );
  }

  Row _listTile(String imageName, String title, String subtitle) {
    return Row(
      children: [
        Image.asset('assets/${imageName}.png'),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: kTextstyle(size: 16, color: Colors.white)),
          Text(subtitle, style: kTextstyle(size: 12, color: Colors.white))
        ])
      ],
    );
  }

  bool isCurrencyOperator(String x) {
    if (x == 'del' || x == 'up/d' || x == 'C') {
      return true;
    }
    return false;
  }

  bool isOperator(String x) {
    if (x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == 'del' ||
        x == 'xⁿ') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput.text;

    finaluserinput = userInput.text.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer.text = eval.toString();
  }
}
