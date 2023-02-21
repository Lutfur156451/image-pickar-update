import 'package:flutter/material.dart';
import 'package:img_pickar/img_pickar.dart';
import 'package:img_pickar/user_data.dart';
import 'package:img_pickar/user_data_upload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: img_pickar(),
    );
  }
}


