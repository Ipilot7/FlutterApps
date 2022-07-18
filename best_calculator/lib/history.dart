import 'package:best_calculator/settings.dart';
import 'package:best_calculator/utils/list_view_utils.dart';
import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';
import 'utils/constants.dart';
import 'utils/utils.dart';
import 'utils/button.dart';
import 'utils/theme_colors.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final userInput = TextEditingController();
  final answer = TextEditingController();
  final currencyTop = TextEditingController();
  final currencyBottom = TextEditingController();
  final rulesController = TextEditingController();

  bool isChecked = false;

  String name = '1';
  @override
  void initState() {
    super.initState();
    rulesController.text = name;
  }

  @override
  void dispose() {
    rulesController.dispose();
    super.dispose();
  }

  bool isActive = true;

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
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              controller: userInput,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              controller: answer,
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    GridView.builder(
                        physics: const BouncingScrollPhysics(),
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
                                          physics:
                                              const BouncingScrollPhysics(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 25),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 29),
                      decoration: BoxDecoration(
                          color: operationsBgColor,
                          boxShadow: const [
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
                                    style: TextStyle(color: fromCurrencyColor),
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: currencyTop,
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
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: inCurrencyColor),
                                    controller: currencyBottom,
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
                    _currencyButtons(),
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
                          tabs: List.generate(
                            ruleMenu.length,
                            (index) {
                              return Tab(
                                text: ruleMenu[index],
                              );
                            },
                          ),
                        ),
                      ),
                      body: TabBarView(
                          children: List.generate(ruleMenu.length, (index) {
                        return _tabs(mapNames[index]);
                      })),
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

  Padding _currencyButtons() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: operationsBgColor, boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(0.0, 0.75),
          )
        ]),
        child: Container(
          color: black,
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: numbers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 11) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        currencyTop.text = '';
                        currencyBottom.text = '';
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
                      setState(() {
                        currencyBottom.text = currencyBottom.text
                            .substring(0, currencyBottom.text.length - 1);
                      });
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
                      setState(() {
                        currencyBottom.text += numbers[index];
                        currencyTop.text += numbers[index];
                      });
                    },
                    buttonText: numbers[index],
                    color: operationsBgColor,
                    textColor: isCurrencyOperator(numbers[index])
                        ? iconActiveColor
                        : numbersColor,
                  );
                }
              }),
        ),
      ),
    );
  }

  Padding _currencyButtonsRules() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: operationsBgColor, boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(0.0, 0.75),
          )
        ]),
        child: Container(
          color: black,
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: numbersOfRules.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 7) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        rulesController.text = '';
                      });
                    },
                    buttonText: numbersOfRules[index],
                    color: operationsBgColor,
                    textColor: iconActiveColor,
                  );
                }

                // Delete Button
                else if (index == 3) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        rulesController.text = rulesController.text
                            .substring(0, rulesController.text.length - 1);
                      });
                    },
                    buttonText: numbersOfRules[index],
                    color: operationsBgColor,
                    textColor: iconActiveColor,
                  );
                }

                //  other buttons
                else {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        rulesController.text += numbersOfRules[index];
                      });
                    },
                    buttonText: numbersOfRules[index],
                    color: operationsBgColor,
                    textColor: isCurrencyOperator(numbersOfRules[index])
                        ? iconActiveColor
                        : numbersColor,
                  );
                }
              }),
        ),
      ),
    );
  }

  Column _tabs(Map mapName) {
    return Column(
      children: [
        Container(
            color: appBarBgColor,
            height: 170,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: bodyBgColor,
                            context: context,
                            builder: (BuildContext context) {
                              return ListView.builder(
                                itemCount: mapName.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    listile3pageInShModButSheet(
                                        mapName.keys.elementAt(index),
                                        "${mapName.values.elementAt(index)[0]}",
                                        index),
                              );
                            });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(mapName.keys.last.toString(),
                                    style: kTextstyle(
                                        size: 16, color: iconActiveColor)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    mapName.values.first[0].toString(),
                                    style: kTextstyle(
                                        size: 38, color: iconActiveColor),
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                    color: numbersColor,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: TextField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: bodyBgColor,
                          context: context,
                          builder: (BuildContext contex) {
                            return _currencyButtonsRules();
                          });
                    },
                    controller: rulesController,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: iconActiveColor, fontSize: 38),
                  ))
                ])),
        Expanded(
          child: ListView.builder(
            itemCount: mapName.length,
            itemBuilder: (BuildContext context, int index) => listTile3page(
                mapName.keys.elementAt(index),
                "${mapName.values.elementAt(index)[0]}",
                '${mapName.values.elementAt(index)[1] * num.parse(rulesController.text == "" ? "1" : rulesController.text)}',
                index),
          ),
        ),
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
          return InkWell(
            onTap: () {
              setState(() {
                switch (index + 1) {
                  case 1:
                    appBarBgColor = appBarBgColor1;
                    drawerBGColor = drawerBGColor1;
                    iconActiveColor = iconActiveColor1;
                    iconColor = iconActiveColor1;
                    bodyBgColor = bodyBgColor1;
                    numbersBgColor = numbersBgColor1;
                    numbersColor = numberColor1;
                    resulColor = resulColor1;
                    operationsBgColor = operationsBgColor1;
                    black = black1;
                    fromCurrencyColor = fromCurrencyColor1;
                    inCurrencyColor = inCurrencyColor1;
                    white = white1;
                    listViewColor = listViewColor1;
                    listViewTextColor = listViewTextColor1;
                    break;
                  case 2:
                    appBarBgColor = appBarBgColor2;
                    drawerBGColor = drawerBGColor2;
                    iconActiveColor = iconActiveColor2;
                    iconColor = iconActiveColor2;
                    bodyBgColor = bodyBgColor2;
                    numbersBgColor = numbersBgColor2;
                    numbersColor = numbersColor2;
                    resulColor = resulColor2;
                    operationsBgColor = operationsBgColor2;
                    black = black2;
                    fromCurrencyColor = fromCurrencyColor2;
                    inCurrencyColor = inCurrencyColor2;
                    white = white2;
                    listViewColor = listViewColor2;
                    listViewTextColor = listViewTextColor2;
                    break;
                  case 3:
                    appBarBgColor = appBarBgColor3;
                    drawerBGColor = drawerBGColor3;
                    iconActiveColor = iconActiveColor3;
                    iconColor = iconActiveColor8;
                    bodyBgColor = bodyBgColor3;
                    numbersBgColor = numbersBgColor3;
                    numbersColor = numberColor3;
                    resulColor = resulColor3;
                    operationsBgColor = operationsBgColor3;
                    black = black31;
                    fromCurrencyColor = fromCurrencyColor3;
                    inCurrencyColor = inCurrencyColor3;
                    white = white3;
                    listViewColor = listViewColor3;
                    break;
                  case 5:
                    appBarBgColor = appBarBgColor5;
                    drawerBGColor = drawerBGColor5;
                    iconActiveColor = iconActiveColor5;
                    iconColor = iconActiveColor5;
                    bodyBgColor = bodyBgColor5;
                    numbersBgColor = numbersBgColor5;
                    numbersColor = numbersColor5;
                    resulColor = resulColor5;
                    operationsBgColor = operationsBgColor5;
                    black = black31;
                    fromCurrencyColor = fromCurrencyColor5;
                    inCurrencyColor = inCurrencyColor5;
                    white = white5;
                    listViewColor = listViewColor51;
                    break;
                  case 8:
                    appBarBgColor = appBarBgColor8;
                    drawerBGColor = drawerBGColor8;
                    iconActiveColor = iconActiveColor8;
                    iconColor = iconActiveColor8;
                    bodyBgColor = bodyBgColor8;
                    numbersBgColor = numbersBgColor8;
                    numbersColor = numberColor8;
                    resulColor = resulColor8;
                    operationsBgColor = operationsBgColor8;
                    black = black8;
                    fromCurrencyColor = fromCurrencyColor8;
                    inCurrencyColor = inCurrencyColor8;
                    white = white8;
                    listViewColor = listViewColor81;
                    break;
                }
              });
            },
            child: Image.asset(
              'assets/drawImages/${index + 1}.png',
              fit: BoxFit.contain,
            ),
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
                style: kTextstyle(size: 12, color: listViewTextColor),
              ),
              Text(subtitle,
                  style: kTextstyle(size: 24, color: listViewTextColor)),
            ],
          ),
          Text(trailing, style: kTextstyle(size: 24, color: listViewTextColor)),
        ]),
      ),
    );
  }

  listile3pageInShModButSheet(String title, String subtitle, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = true;
        });
      },
      child: Container(
        color: index.isOdd ? numbersBgColor : listViewColor,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: ListTile(
          title: Text(
            title,
            style: kTextstyle(size: 12, color: listViewTextColor),
          ),
          subtitle: Text(subtitle,
              style: kTextstyle(size: 24, color: listViewTextColor)),
          trailing: title == mapNames.last[0]
              ? Icon(Icons.done, color: Colors.green)
              : null,
        ),
      ),
    );
    // InkWell(
    //   onTap: () {},
    //   child: Container(
    //     color: index.isOdd ? numbersBgColor : listViewColor,
    //     padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
    //     child:
    //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             title,
    //             style: kTextstyle(size: 12, color: listViewTextColor),
    //           ),
    //           Text(subtitle,
    //               style: kTextstyle(size: 24, color: listViewTextColor)),
    //         ],
    //       ),
    //       Icon(Icons.done, color: Colors.green),
    //     ]),
    //   ),
    // );
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
    if (answer.text is double) {
      answer.text = eval.toInt().toString();
    }
    answer.text = eval.toString();
  }
}
