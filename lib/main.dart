import 'package:flutter/material.dart';
import 'dart:core';

void main() {
  runApp(const MyApp());
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
  int _currentWeekday = DateTime.now().weekday - 1;
  bool punVisible = false;
  bool favButtonDisabled = true;

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
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
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
                const Text(
                    'What is the difference between a sable tooth tiger and a mammoth?'),
                Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 50),
                    child: punVisible
                        ? const Text('The body fat percentage!')
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
