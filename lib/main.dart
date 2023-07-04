import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class Joke {
  int idjoke = 0;
  String question = '';
  String pun = '';

  Joke(this.idjoke, this.question, this.pun);

  Joke.fromMap(Map<String, dynamic> map) {
    idjoke = map['idjoke'];
    question = map['question'];
    pun = map['pun'];
  }
}

class SQLDB {
  String filepath = '';

  static Joke getDailyJoke(filepath) {
    List<Map<String, dynamic>> validJokes = [
      {
        'idjoke': 0,
        'question': 'What is the difference between a sable tooth tiger and a mammoth?',
        'pun': 'the body fat percentage!'
      },
      {
        'idjoke': 1,
        'question': 'Why is the sloth sleeping?',
        'pun': 'because its a regenerating'
      },
      {
        'idjoke': 2,
        'question': 'Why is the field red?',
        'pun': 'Because it is Vulcanic'
      }
    ];
    int randIndex = Random().nextInt(validJokes.length);
    return Joke.fromMap(validJokes[randIndex]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MasterApp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00ffbf00)),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              bodyMedium: TextStyle(fontSize: 16)
          ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return const Color(0x50ffbf00);
                    }
                    return const Color(0xFFffbf00);}),
            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0E2239)),
            fixedSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 48)), // Width as 100% and fixed height of 48
            maximumSize: MaterialStateProperty.all<Size>(const Size(500, 48)), // Max width of 500
          )
        )
      ),
      home: const MyHomePage(title: 'MasterApp: Joke of the Day'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _currentWeekday = DateTime.now().weekday - 1;
  bool punVisible = false;
  bool favButtonDisabled = true;
  Joke dailyJoke = SQLDB.getDailyJoke('');

  void _showPun() {
    setState(() {
      punVisible = true;
      favButtonDisabled = false;
    });
  }

  void _addFavButton() {
    setState(() {
      favButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Color(0xFF0E2239), fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Center(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Welcome Anna Wagner, MSc!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 40),
                    height: 250,
                    child: Image.asset('images/weekday_$_currentWeekday.png')),
                Text(dailyJoke.question),
                Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 50),
                    child: punVisible
                        ? Text(dailyJoke.pun)
                        : ElevatedButton(onPressed: _showPun, child: const Text('Show Pun'))
                ),
                if (punVisible) ElevatedButton(onPressed: !favButtonDisabled ? _addFavButton : null, child: const Text('Add to favorites')
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
