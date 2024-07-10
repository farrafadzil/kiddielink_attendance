import 'package:flutter/material.dart';
import 'package:kiddielink_attendance/checkin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ABC Academy Check-In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckInPage(),
    );
  }
}