import 'package:flutter/material.dart';

class archieved_screen extends StatefulWidget {
  const archieved_screen({Key? key}) : super(key: key);

  @override
  _archieved_screenState createState() => _archieved_screenState();
}

class _archieved_screenState extends State<archieved_screen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'New Archived',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50.0,
        ),
      ),
    );
  }
}