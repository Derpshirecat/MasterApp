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
            bodyLarge:  TextStyle(
              fontSize: 18,
              fontWeight:  FontWeight.w600,
            ),
            bodyMedium: TextStyle(
              fontSize: 16
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
  int _currentWeekday= DateTime.now().weekday - 1;

  void _incrementCounter() {
    setState(() {
      _currentWeekday++;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Text(
                'Welcome Anna Wagner, MSc!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
               Container(
                 margin: const EdgeInsets.only(top:30, bottom: 30),
                 height: 250,
                 child: Image.asset('images/weekday_$_currentWeekday.png')
                 ),
               const Text('You have pushed the button this many times:'),
              Text(
                '$_currentWeekday',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
