import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Components

Widget buildTaskItem(Map model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
       CircleAvatar(
        radius: 40.0,
        child: Text('${model['time']}',

        ),
      ),
      const SizedBox(
        width: 10.0,),
      Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('${model['title']}',
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('${model['date']}',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],

  ),
);