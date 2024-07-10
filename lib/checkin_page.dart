import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiddielink_attendance/firebase_options.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckInPage(),
    );
  }
}

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  String _inputCode = '';
  int totalStudents = 0;
  int presentStudents = 0;
  int absentStudents = 0;


  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'del') {
        if (_inputCode.isNotEmpty) {
          _inputCode = _inputCode.substring(0, _inputCode.length - 1);
        }
      } else if (_inputCode.length < 4) {
        _inputCode += value;
      }
    });
  }

  Future<void> _handleCheckInOut() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('student')
          .where('attendance_code', isEqualTo: _inputCode)
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        String studentId = querySnapshot.docs.first.id;
        QuerySnapshot<Map<String, dynamic>> lastAttendanceSnapshot = await FirebaseFirestore.instance
            .collection('student')
            .doc(studentId)
            .collection('attendance')
            .orderBy('check_in_time', descending: true)
            .limit(1)
            .get();

        if (lastAttendanceSnapshot.docs.isNotEmpty) {
          DocumentSnapshot<Map<String, dynamic>> lastAttendance = lastAttendanceSnapshot.docs.first;
          if (lastAttendance.exists && lastAttendance.data()!['check_out_time'] == null) {
            await FirebaseFirestore.instance
                .collection('student')
                .doc(studentId)
                .collection('attendance')
                .doc(lastAttendance.id)
                .update({
              'check_out_time': FieldValue.serverTimestamp(),
            });

            setState(() {
              presentStudents--;
              absentStudents++;
            });

            _showDialog('Check-out Successful', 'You have successfully checked out.');
          } else {
            String attendanceId = Uuid().v4();
            await FirebaseFirestore.instance
                .collection('student')
                .doc(studentId)
                .collection('attendance')
                .add({
              'check_in_time': FieldValue.serverTimestamp(),
              'check_out_time': null,
              'date': FieldValue.serverTimestamp(),
              'attendance_id': attendanceId,
            });

            setState(() {
              presentStudents++;
              absentStudents--;
            });

            _showDialog('Check-in Successful', 'You have successfully checked in.');
          }
        } else {
          // No previous attendance record found, create a new check-in
          String attendanceId = Uuid().v4();
          await FirebaseFirestore.instance
              .collection('student')
              .doc(studentId)
              .collection('attendance')
              .add({
            'check_in_time': FieldValue.serverTimestamp(),
            'check_out_time': null,
            'date': FieldValue.serverTimestamp(),
            'attendance_id': attendanceId,
          });

          setState(() {
            presentStudents++;
            absentStudents--;
          });

          _showDialog('Check-in Successful', 'You have successfully checked in.');
        }

        setState(() {
          _inputCode = '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid code!'),
        ));
      }
    } catch (e) {
      print('Error during check-in/check-out: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }



  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKey(String value) {
    return AspectRatio(
      aspectRatio: 1,
      child: ElevatedButton(
        onPressed: () => _onKeyPressed(value),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(0),
        ),
        child: Text(
          value == 'del' ? '⌫' : value,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              'WELCOME TO\nKiddieLink',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Enter 4 Digit Check-in Code',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      index < _inputCode.length ? '*' : '',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(150),
              children: <String>[
                '1', '2', '3',
                '4', '5', '6',
                '7', '8', '9',
                '', '0', 'del'
              ].map(_buildKey).toList(),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: _inputCode.length == 4 ? _handleCheckInOut : null,
              child: Text('Check in/out'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                minimumSize: Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
