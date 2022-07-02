import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'main.dart';
import 'utils.dart';
import 'currency_model.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: CurrencyPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();

  // Future<bool?> _loadData() async {
  //   try {
  //     var response =
  //         await get(Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
  //     if (response.statusCode == 200) {
  //       for (final item in jsonDecode(response.body)) {
  //         var model = CurrencyModel.fromJson(item);
  //         list.add(model);
  //       }
  //     }
  //   } on SocketException {
  //     log('Connection error');
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }
}

// _showMessage(String text, {bool isError = true}) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: isError ? Colors.red : Colors.green[400],
//       content: Text(
//         text,
//         style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
//       ),
//     ),
//   );
// }

class _CurrencyPageState extends State<CurrencyPage> {
  final textEditingController = TextEditingController();
  List<CurrencyModel> list = [];
  @override
  void initState() {
    super.initState();
    list = listCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f2235),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    list = listCurrency.where((value) => value.ccyNmUz!
                            .toLowerCase()
                            .startsWith(
                                textEditingController.text.toLowerCase())).toList();
                    listCurrency.forEach(
                      (element) => print(element.ccyNmUz),
                    );
                    print(list);
                  });
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xff2d334d),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  hintText: 'Search',
                  hintStyle: kTextStyle(
                      color: Colors.white54,
                      size: 16,
                      fontWeight: FontWeight.w500),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.clear,
                          color: Colors.white, size: 20)),
                ),
              ),
            ),
            content(list),
          ],
        ),
      ),
    );
  }

  Expanded content(List<CurrencyModel> list) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: const Color(0xff2d334d),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(
              list.length,
              // listCurrency.length,
              (index) => InkWell(
                onTap: () {},
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/${list[index].ccy.toString().substring(0, 2).toLowerCase()}.svg',
                    width: 25,
                    height: 25,
                  ),
                  subtitle: Text(
                    '${list[index].ccyNmUz}',
                    style: kTextStyle(),
                  ),
                  title: Text(
                    '${list[index].ccy}',
                    style: kTextStyle(),
                  ),
                  trailing: Text(
                    '${list[index].rate}',
                    style: kTextStyle(),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
