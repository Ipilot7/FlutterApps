import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:best_calculator/currency/currency_model.dart';
import 'package:best_calculator/utils/hive_util.dart';
import 'package:best_calculator/utils/list_view_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wakelock/wakelock.dart';
import 'currency/compare_page.dart';
import 'currency/constants.dart';
import 'utils/routes.dart';
import 'utils/constants.dart';
import 'utils/utils.dart';
import 'utils/button.dart';
import 'utils/theme_colors.dart';
import 'main.dart';

class History extends StatefulWidget {
  const History( {Key? key}) : super(key: key);
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with HiveUtil {
  late List hiveValues;
  late List hiveKeys;
  final rulesController = TextEditingController();
   
  int activeIndex = 0;
  int lowIndex=0;

  final settingsController = TextEditingController();
  final userInput = TextEditingController();
  final answer = TextEditingController();
  final currencyTop = TextEditingController();
  final currencyBottom = TextEditingController();
 
  late String animatedText;
  //---
  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();
  List<CurrencyModel> _listCurrency = [];
  CurrencyModel? topCur;
  CurrencyModel? bottomCur;
  //---
  
  late Animation animation;

  String name = '1';
  //settings
  bool minimumTo2Cals = false; //.00;
  bool onSwapClear = false;
  bool isAnimated =true;
  bool isWakeLook = false;
  //;выбрация не сделано
  bool isCheckStatusBar = false;
  //---------------------
  // settings_bools
  bool switchValue = false;
  bool switchValue1 = false;
  bool switchValue2 = false;
  // bool switchValueView=false;
  bool switchValue3 = false;
  bool switchValue4 = false;
  bool switchValue5 = false;
//---------------------

  

  @override
  
  void initState() {
     
    super.initState();
    rulesController.text = '1';
    animatedText = "Baxtiyor";
    hiveKeys = [];
    hiveValues = [];
    //--
    
    _editingControllerTop.addListener(() {
      if (_topFocus.hasFocus) {
        setState(() {
          if (_editingControllerTop.text.isNotEmpty) {
            double sum = double.parse(topCur?.rate ?? '0') /
                double.parse(bottomCur?.rate ?? '0') *
                double.parse(_editingControllerTop.text);
            _editingControllerBottom.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerBottom.clear();
          }
        });
      }
    });
    _editingControllerBottom.addListener(() {
      if (_bottomFocus.hasFocus) {
        setState(() {
          if (_editingControllerBottom.text.isNotEmpty) {
            double sum = double.parse(bottomCur?.rate ?? '0') /
                double.parse(topCur?.rate ?? '0') *
                double.parse(_editingControllerBottom.text);
            _editingControllerTop.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerTop.clear();
          }
        });
      }
    });
    //---   
  }

  @override
  void dispose() {    
    rulesController.dispose();
    //---
    _editingControllerTop.dispose();
    _editingControllerBottom.dispose();
    _topFocus.dispose();
    _bottomFocus.dispose();
    //---
    super.dispose();
  }

  //-----
  Future<bool?> _loadData() async {
    var isLoad = await loadLocalData();
    if (isLoad) {
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          for (final item in jsonDecode(response.body)) {
            var model = CurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              topCur = model;
            } else if (model.ccy == 'RUB') {
              bottomCur = model;
            }
            _listCurrency.add(model);
            await saveBox<String>(dateBox, topCur?.date ?? '', key: dateKey);
            await saveBox<List<dynamic>>(currencyBox, _listCurrency,
                key: currencyListKey);
          }
          return true;
        } else {
          _showMessage('Unknown error');
        }
      } on SocketException {
        _showMessage('Connection error');
      } catch (e) {
        _showMessage(e.toString());
      }
    } else {
      return true;
    }
    return null;
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String>(dateBox, key: dateKey);
      if (date ==
          DateFormat('dd.MM.yyyy')
              .format(DateTime.now().add(const Duration(days: -1)))) {
        var list =
            await getBox<List<dynamic>>(currencyBox, key: currencyListKey) ??
                [];
        _listCurrency = List.castFrom<dynamic, CurrencyModel>(list);
        for (var model in _listCurrency) {
          if (model.ccy == 'USD') {
            topCur = model;
          } else if (model.ccy == 'RUB') {
            bottomCur = model;
          }
        }
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
          style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  //-----
  callback(value) {
    setState(() {
      if (value is String) {
        animatedText = value;
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    if (isWakeLook) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
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
            endDrawer: MaterialApp(
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
                            const SizedBox(height: 20),
                            Text(
                              'Изменение текста основного экрана',
                              style: kTextstyle(
                                  size: 12,
                                  color: const Color.fromARGB(255, 53, 53, 59)),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      height: 34,
                                      width: 270,
                                      child: TextField(
                                        controller: settingsController,
                                        decoration: InputDecoration(
                                            hintText: animatedText,
                                            enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black))),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          animatedText =
                                              settingsController.text;

                                          settingsController.text = '';
                                          
                                        });

                                       
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                        style: kTextstyle(
                                            size: 18, color: Colors.black)),
                                    Text(
                                        'Ограничить минимальную точность до 2 цыфр',
                                        style: kTextstyle(
                                            size: 12,
                                            color: const Color.fromARGB(
                                                255, 53, 53, 59)))
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
                                            minimumTo2Cals=value;
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
                                        style: kTextstyle(
                                            size: 18, color: Colors.black)),
                                    Text(
                                        'Провести палец вниз по клавиатуре, чтобы рассчитывать',
                                        style: kTextstyle(
                                            size: 12,
                                            color: const Color.fromARGB(
                                                255, 53, 53, 59)))
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
                                            onSwapClear=value;
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
                                        style: kTextstyle(
                                            size: 18, color: Colors.black)),
                                    Text(
                                        'Отключить текстовую анимацию в главном разделе',
                                        style: kTextstyle(
                                            size: 12,
                                            color: const Color.fromARGB(
                                                255, 53, 53, 59)))
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
                                            isAnimated=!value;
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
                                        style: kTextstyle(
                                            size: 18, color: Colors.black)),
                                    Text(
                                        'Ограничить спящий режим во время работы приложение ',
                                        style: kTextstyle(
                                            size: 12,
                                            color: const Color.fromARGB(
                                                255, 53, 53, 59)))
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
                                            isWakeLook=value;
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
                                    style: kTextstyle(
                                        size: 18, color: Colors.black)),
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
                                    style: kTextstyle(
                                        size: 18, color: Colors.black)),
                                Switch(
                                    value: switchValue5,
                                    onChanged: (value) {
                                      setState(() {
                                        switchValue5 = value;
                                        if (value) {
                                          SystemChrome.setEnabledSystemUIMode(
                                              SystemUiMode.manual,
                                              overlays: [
                                                SystemUiOverlay.bottom
                                              ]);
                                        } else {
                                          SystemChrome.setEnabledSystemUIMode(
                                              SystemUiMode.manual,
                                              overlays: SystemUiOverlay.values);
                                        }
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
                                    Navigator.pushReplacementNamed(
                                        context, '/about');
                                  },
                                  child: Text(
                                    'О программе',
                                    style: kTextstyle(
                                        size: 18, color: Colors.black),
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
            ),
            backgroundColor: bodyBgColor,
            appBar: AppBar(
              iconTheme: IconThemeData(color: iconActiveColor),
              backgroundColor: appBarBgColor,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.settings, size: 25),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
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
                          color: iconActiveColor, size: 28),),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 110, right: 90),
                                  child: SizedBox(
                                    height: 30.0,
                                    child: isAnimated
                                        ? Shimmer.fromColors(
                                            baseColor: bodyBgColor,
                                            highlightColor: white,
                                            child: Text(
                                              animatedText,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            animatedText,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 30.0,
                                            ),
                                          ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        InkWell(
                                            child: Image.asset(
                                              'assets/history.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: size.height * 0.89,
                                                    color:
                                                        const Color(0xff262626),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 17,
                                                                  right: 17),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              TextButton(
                                                                onPressed:
                                                                
                                                                    () {},
                                                                child: Text(
                                                                  "history",
                                                                  style:
                                                                      kTextStyle(
                                                                    size: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        iconActiveColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    hiveKeys
                                                                        .clear();
                                                                    hiveValues
                                                                        .clear();
                                                                    box.clear();
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  CupertinoIcons
                                                                      .delete_simple,
                                                                  size: 35,
                                                                  color:
                                                                      iconActiveColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: size.height *
                                                              0.775,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xff262626),
                                                            border: Border(
                                                              top: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    numbersColor,
                                                              ),
                                                              bottom:
                                                                  BorderSide(
                                                                width: 1,
                                                                color:
                                                                    numbersColor,
                                                              ),
                                                            ),
                                                          ),
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                hiveKeys.length,
                                                            itemBuilder:
                                                                ((BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: double
                                                                    .infinity,
                                                                height: 100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color:
                                                                            iconActiveColor)),
                                                                child: ListTile(
                                                                  leading:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        hiveKeys
                                                                            .removeAt(index);
                                                                        hiveValues
                                                                            .removeAt(index);
                                                                        box.deleteAt(
                                                                            index);
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                      CupertinoIcons
                                                                          .delete,
                                                                      color:
                                                                          numbersColor,
                                                                      size: 25,
                                                                    ),
                                                                  ),
                                                                  title: Text(
                                                                    '${hiveKeys[index]}',
                                                                    style: kTextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    hiveValues[
                                                                        index],
                                                                    style: kTextStyle(
                                                                        color:
                                                                            numbersColor,
                                                                        size:
                                                                            18),
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    '${box.keys.elementAt(index).substring(0, 19)}',
                                                                    style: kTextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            15),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }),
                                      ],
                                    )),
                              ],
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: userInput,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none),
                                style: const TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none),
                                controller: answer,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        int sensitivity = 8;
                        if (details.delta.dy > sensitivity) {
                          setState(() {
                            if (onSwapClear) {
                              userInput.text = '';
                              answer.text = '';
                              setState(() {});
                            }
                          });
                        } else if (details.delta.dy < -sensitivity) {
                          // Up Swipe
                        }
                      },
                      child: GridView.builder(
                          physics:
                              const BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()) красивое прокрутка при up и down

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
                                    if (userInput.text.isNotEmpty) {
                                      userInput.text = userInput.text.substring(
                                          0, userInput.text.length - 1);
                                    } else {
                                      userInput.text = '';
                                    }
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
                                    if(!isOperator(userInput.text[userInput.text.length-1])){
                                    userInput.text+=buttons[index];   
                                    }
                                    userInput.text+='';
                                   
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
                                       if(!isOperator(userInput.text[userInput.text.length-1])){
                                    userInput.text+=buttons[index];   
                                    }
                                    userInput.text+='';
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: operationsBgColor,
                                  textColor: iconActiveColor);
                            } 
                            // - button
                             else if (index == 11) {
                              return MyButton(
                                  buttontapped: () {
                                    setState(() {
                                       if(!isOperator(userInput.text[userInput.text.length-1])){
                                    userInput.text+=buttons[index];   
                                    }
                                    userInput.text+='';
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: operationsBgColor,
                                  textColor: iconActiveColor);
                            }
                            // + button
                             else if (index == 15) {
                              return MyButton(
                                  buttontapped: () {
                                    setState(() {
                                       if(!isOperator(userInput.text[userInput.text.length-1])){
                                    userInput.text+=buttons[index];   
                                    }
                                    userInput.text+='';
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: operationsBgColor,
                                  textColor: iconActiveColor);
                            }
                            else if (index == 1) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    if (userInput.text.isNotEmpty ||
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

                            // = Button
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
                            } else if (index == 18) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    if (userInput.text.isNotEmpty) {
                                      if (!userInput.text.contains('(') &&
                                          !userInput.text.contains(')')) {
                                        userInput.text = '(${userInput.text})';
                                      } else {
                                        if (userInput.text.contains('(')) {
                                          userInput.text += ')';
                                        } else {
                                          userInput.text += '(';
                                        }
                                      }
                                    } else {
                                      userInput.text = '(';
                                    }
                                    ;
                                  });
                                },
                                buttonText: buttons[index],
                                color: numbersBgColor,
                                textColor: numbersColor,
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
                    ),
                    InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              backgroundColor: bodyBgColor,
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
                                            if (index == 9) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text = pow(
                                                          int.parse(
                                                              userInput.text),
                                                          2)
                                                      .toString();
                                                  equalPressed();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 10) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text = pow(
                                                          int.parse(
                                                              userInput.text),
                                                          3)
                                                      .toString();
                                                  equalPressed();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 0) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text = (int.parse(
                                                              userInput.text) *
                                                          180 /
                                                          3.14)
                                                      .toStringAsFixed(5);

                                                  equalPressed();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 1) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text =
                                                      '${shModButtons[index]}(${userInput.text})';
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 2) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text =
                                                      '${shModButtons[index]}(${userInput.text})';
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 3) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text =
                                                      '${shModButtons[index]}(${userInput.text})';
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 4) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text += '3.14';
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 8) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text = (1 /
                                                          (int.parse(
                                                              userInput.text)))
                                                      .toString();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 5) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  var sin =
                                                      int.parse(userInput.text);
                                                  userInput.text =
                                                      '${sinh(sin)}';
                                                  equalPressed();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 6) {
                                              return MyButton(
                                                  textColor: iconActiveColor,
                                                  buttonText:
                                                      shModButtons[index],
                                                  buttontapped: () {
                                                    var cos = int.parse(
                                                        userInput.text);
                                                    userInput.text =
                                                        '${cosh(cos)}';
                                                    equalPressed();
                                                  });
                                            } else if (index == 7) {
                                              return MyButton(
                                                  textColor: iconActiveColor,
                                                  buttonText:
                                                      shModButtons[index],
                                                  buttontapped: () {
                                                    var tan = int.parse(
                                                        userInput.text);
                                                    userInput.text =
                                                        '${tanh(tan)}';
                                                    equalPressed();
                                                  });
                                            } else if (index == 11) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text = (exp(
                                                          int.parse(
                                                              userInput.text)))
                                                      .toString();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 12) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text = (log(
                                                          double.parse(
                                                              userInput.text)))
                                                      .toString();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 13) {
                                              //не закончен
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text +=
                                                      shModButtons[index];
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 14) {
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text +=
                                                      e.toString();
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            } else if (index == 15) {
                                              //не закончен
                                              return MyButton(
                                                textColor: iconActiveColor,
                                                buttontapped: () {
                                                  userInput.text +=
                                                      '${shModButtons[index].replaceAll('eⁿ', 'e^')}(';
                                                },
                                                buttonText: shModButtons[index],
                                              );
                                            }

                                            return MyButton(
                                              buttontapped: () {
                                                setState(() {
                                                  userInput.text +=
                                                      shModButtons[index];
                                                });
                                              },
                                              buttonText: shModButtons[index],
                                              color: operationsBgColor,
                                              textColor: isMathOperations(
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
                ComparePage(),                
                DefaultTabController(
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
                          children: 
                          List.generate(mapNames.length, (index) {                             
                           
                        return _tabs(mapNames[index],index);
                      })),
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
        itemCount: 9,
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
                  case 6:
                    appBarBgColor = appBarBgColor6;
                    drawerBGColor = drawerBGColor6;
                    iconActiveColor = iconActiveColor6;
                    iconColor = iconActiveColor6;
                    bodyBgColor = bodyBgColor6;
                    numbersBgColor = numbersBgColorNoGradient6;
                    // numbersColor = numbersColor6;
                    resulColor = resulColor6;
                    // operationsBgColor = operationsBgColor6;
                    // black = black61;
                    fromCurrencyColor = fromCurrencyColor6;
                    inCurrencyColor = inCurrencyColor6;
                    // white = white6;
                    listViewColor = listViewColor61;
                    listViewTextColor=listViewTextcolor6;
                    break;
                  case 7:
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
                   case 8:
                    appBarBgColor = black9;
                    drawerBGColor = drawerBGColor9;
                    iconActiveColor = white9;
                    iconColor = iconColor9;
                    bodyBgColor = black;
                    numbersBgColor = black;
                    numbersColor = white;
                    resulColor = white;
                    operationsBgColor = black;                    
                    fromCurrencyColor = white;
                    inCurrencyColor = white;
                    listViewTextColor=listViewTextColor9;
                    listViewColor = drawerBGColor9;
                    
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
 Column _tabs(Map mapName, int index) { 
    int nowIndex=index;                              
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
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(meashureNames[index],
                                
                                  
                                  style: kTextstyle(
                                      size: 16, color: iconActiveColor)),
                              Text(meashureNames2[index],
                                
                                style: kTextstyle(
                                    size: 38, color: iconActiveColor),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(
                              Icons.expand_more,
                              color: numbersColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      
                                    
                      showModalBottomSheet(
                          backgroundColor: bodyBgColor,
                          context: context,
                          builder: (BuildContext context) {
                            return ListView.builder(
                                itemCount: mapName.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {

                                  setState(() {
                                      activeIndex = index;
                                      meashureNames[nowIndex] =
                                          mapName.keys.elementAt(activeIndex);
                                      meashureNames2[nowIndex] = mapName.values
                                          .elementAt(activeIndex)[0];
                                      

                                      Navigator.pop(context);});
                                      
                                     
                                    },
                                    child: Container(
                                      color: index.isOdd
                                          ? numbersBgColor
                                          : listViewColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 12),
                                      child: ListTile(
                                        title: Text(
                                          mapName.keys.elementAt(index),
                                          style: kTextstyle(
                                              size: 12,
                                              color: listViewTextColor),
                                        ),
                                        subtitle: Text(
                                            "${mapName.values.elementAt(index)[0]}",
                                            style: kTextstyle(
                                                size: 24,
                                                color: listViewTextColor)),
                                        trailing: activeIndex == index
                                            ? Icon(Icons.done,
                                                color: Colors.green)
                                            : null,
                                      ),
                                    ),
                                  );
                                });
                          });
                      
                    },
                  ),
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
              itemBuilder: (BuildContext context, int index) {
                
                if (meashureNames2[nowIndex] == mapName.values.elementAt(index)[0]) {
                  return Container();
                } else {
                  return listTile3page(
                      mapName.keys.elementAt(index),
                      "${mapName.values.elementAt(index)[0]}",
                      '${mapName.values.elementAt(index)[1] * num.parse(rulesController.text == "" ? "1" : rulesController.text)}',
                      index);
                }
              }),
        ),
      ],
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
                else if(index==11){
                  return MyButton(
                     buttonText: numbersOfRules[index],
                    color: operationsBgColor,
                    textColor: iconActiveColor,
                    buttontapped: (){
                      
                      setState(() {
                        Navigator.pop(context);
                      });
                    },

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
   bool isCurrencyOperator(String x) {
    if (x == 'del' || x == 'up/d' || x == 'C') {
      return true;
    }
    return false;
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
    if (minimumTo2Cals) {
      answer.text = eval.toStringAsFixed(2);
    } else {
      answer.text = eval.toString();
    }

    hiveKeys.add('${userInput.text}');
    hiveValues.add('${answer.text}');

    var date = DateTime.now().toString();
    box.put(date, ['${hiveKeys}', '${hiveValues}']);
  }

  Widget _itemExch(TextEditingController controller, CurrencyModel? model,
      FocusNode focusNode, Function callback) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '0.00',
                    hintStyle:
                        kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.currencyPage,
                    arguments: {
                      'list_curreny': _listCurrency,
                      'top_cur': topCur?.ccy,
                      'bottom_cur': bottomCur?.ccy
                    }).then(((value) => callback(value))),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueGrey),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SvgPicture.asset(
                        'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        model?.ccy ?? 'UNK',
                        style:
                            kTextStyle(size: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                      size: 15,
                    )
                  ]),
                ),
              )
            ],
          ),
          Text(
            controller.text.isNotEmpty
                ? (double.parse(controller.text) * 0.05).toStringAsFixed(2)
                : '0.00',
            style:
                kTextStyle(fontWeight: FontWeight.w600, color: Colors.white54),
          )
        ],
      ),
    );
  }

  bool isMathOperations(String x) {
    if (x == 'RAD' ||
        x == 'sin' ||
        x == 'cos' ||
        x == 'tan' ||
        x == 'π' ||
        x == 'sinh' ||
        x == 'cosh' ||
        x == 'tanh' ||
        x == 'x¯¹' ||
        x == 'x²' ||
        x == 'x³' ||
        x == 'exp' ||
        x == 'log' ||
        x == 'ln' ||
        x == 'e' ||
        x == 'eⁿ') {
      return true;
    }
    return false;
  }

  pow(int x, int y) {
    var a = 1;
    for (int i = 0; i < y; i++) {
      a *= x;
    }
    return a;
  }

  sinh(num x) {
    return x = (exp(x) - exp(-x)) / 2;
  }

  cosh(num x) {
    return x = (exp(x) + exp(-x)) / 2;
  }

  tanh(num x) {
    return x = ((exp(2 * x) - 1)) / ((exp(2 * x) + 1));
  }

}
