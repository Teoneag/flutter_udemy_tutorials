import 'package:flutter/material.dart';

import './text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hw_1'),
        ),
        body: Text1(_count),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: const Icon(Icons.change_circle),
          ),
        ),
      ),
    );
  }
}
