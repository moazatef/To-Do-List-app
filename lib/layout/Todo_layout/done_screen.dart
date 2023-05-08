import 'package:flutter/material.dart';

class done_screen extends StatefulWidget {
  const done_screen({Key? key}) : super(key: key);

  @override
  _done_screenState createState() => _done_screenState();
}

class _done_screenState extends State<done_screen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Done',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50.0,
        ),
      ),
    );
  }
}
