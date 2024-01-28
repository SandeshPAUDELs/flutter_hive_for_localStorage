import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hieve_storage/view/home.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hieve Storage App',
      home: HomeScreen(),
    );
  }
}
