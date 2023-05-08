import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/shared/comopnentes/constens.dart';
import '../../shared/comopnentes/componentes.dart';

class task_Screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index]) ,
      separatorBuilder: (context, index) => Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: 2.0,
      ),
      itemCount:tasks.length,
    );
  }
}

