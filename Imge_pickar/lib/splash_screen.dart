import 'dart:async';
import 'package:flutter/material.dart';
import 'package:img_pickar/img_pickar.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 4), () =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => img_pickar(),))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  'Demo App',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
