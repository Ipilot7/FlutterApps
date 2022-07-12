import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'MyUtils.dart';
import 'button.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: Calculate(),
    debugShowCheckedModeBanner: false,
  ));
}

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  Alignment dayAlign = Alignment.centerLeft;
  Alignment nightAlign = Alignment.centerRight;
  Alignment switchAlign = Alignment.centerLeft;
  Color bgClr = nightBgClr;
  Color numClr = numbersClr;
  Color numTxtClr = white;
  Color resultClr = white;

  Color switchClr = numbersClr;
  Color switchColor = lastAction;

  changeTheme() {
    setState(() {
      if (switchAlign == dayAlign) {
        switchAlign = nightAlign;
        bgClr = lightBgClr;
        numClr = white;
        numTxtClr = black;
        resultClr = black;

        switchClr = white;
        switchColor = actionsRowColor;
      } else {
        //night
        switchAlign = dayAlign;
        bgClr = nightBgClr;
        numClr = numbersClr;
        numTxtClr = white;
        resultClr = white;

        switchClr = numbersClr;
        switchColor = lastAction;
      }
    });
  }

  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: switchClr,
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: dayAlign,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.sunny,
                        color: actionsClmnnClr,
                        size: size.height * 0.04,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: nightAlign,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.mode_night_outlined,
                        color: actionsClmnnClr,
                        size: size.height * 0.04,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: switchAlign,
                      duration: const Duration(milliseconds: 500),
                      child: InkWell(
                        onTap: () {
                          changeTheme();
                        },
                        child: Container(
                          width: size.height * 0.04,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: switchColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.04),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: kTextstyle(
                      color: lastAction,
                      size: size.height * 0.04,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    textAlign: TextAlign.right,
                    style: kTextstyle(
                      color: numTxtClr,
                      size: size.height * 0.08,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        // Очистить
                        if (index == 0) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userInput = '';
                                answer = '0';
                              });
                            },
                            buttonText: buttons[index],
                            color: switchColor,
                            textColor: numTxtClr,
                          );
                        }
                        // +/-
                        else if (index == 1) {
                          return MyButton(
                            buttonText: buttons[index],
                            color: switchColor,
                            textColor: numTxtClr,
                            buttontapped: () {
                              setState(() {
                                userInput =
                                    buttons[index].substring(0, 1) + userInput;
                              });
                            },
                          );
                        }
                        // %
                        else if (index == 2) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                var a = int.parse(userInput) / 100;
                                userInput = a.toString();
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                            color: switchColor,
                            textColor: numTxtClr,
                          );
                        }
                        // Удалить
                        else if (index == 18) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userInput = userInput.substring(
                                    0, userInput.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: numClr,
                            textColor: numTxtClr,
                          );
                        }
                        // равно
                        else if (index == 19) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                equalPressed();
                                // equalPressed2();
                              });
                            },
                            buttonText: buttons[index],
                            color: actionsClmnnClr,
                            textColor: numTxtClr,
                          );
                        }
                        //  другие кнопки
                        else {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userInput += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? actionsClmnnClr
                                : numClr,
                            textColor: numTxtClr,
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//проверка на оператор
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// функция для вычисление
  void equalPressed() {
    String finaluserinput = userInput;
    String finaluserinput2 = userInput;
    finaluserinput = userInput.replaceAll(
      'x',
      '*',
    );

    Parser p = Parser();

    Expression exp = p.parse(finaluserinput);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
