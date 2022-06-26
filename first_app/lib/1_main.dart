import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'IndieFlower'),
      debugShowCheckedModeBanner: false,
      home: const MyWidget(),
    );
  }
}

//------------------------------------------------------------------------------
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "HomeTask",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tab '-' to decrement",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (_count > 0) {
                      _count--;
                    }
                  }),
                  child: const Text(
                    '-',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '$_count',
                    style: const TextStyle(
                        fontSize: 39, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _count++;
                  }),
                  child: const Text(
                    '+',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const Text(
              "Tab '+' to increment",
              style: TextStyle(
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _count = 0;
        }),
        child: const Icon(Icons.delete_forever_rounded),
      ),
    );
  }
}

//------------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.green,
        width: 250,
      ),
      endDrawer: Container(
        color: Colors.red,
        width: 250,
      ),
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("MyApp"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.android)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
        ],
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: const Text(
        "Count",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.indigo, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
      ]),
    );
  }
}
