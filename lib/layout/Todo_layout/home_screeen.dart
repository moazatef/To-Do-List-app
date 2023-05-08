// ignore_for_file: invalid_required_positional_param

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/layout/Todo_layout/archived_screen.dart';
import 'package:todoapp/layout/Todo_layout/tasks_screen.dart';

import '../../shared/comopnentes/constens.dart';
import 'done_screen.dart';

class Home_Sreen extends StatefulWidget {
  const Home_Sreen({Key? key}) : super(key: key);

  @override
  _Home_SreenState createState() => _Home_SreenState();
}


class _Home_SreenState extends State<Home_Sreen> {

  int currentIndex = 0;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();




  bool isBottomSheetShown= false;

  IconData fabIcon = Icons.edit;
  var titleControll= TextEditingController();
  var timeControll = TextEditingController();
  var dateControll = TextEditingController();


  List<String> title =
  [
    'New Tasks',
    'done',
    'Archived',
  ];

  List<Widget> screens = [
     task_Screen(),
    const done_screen(),
    const archieved_screen(),
  ];

   late Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          title[currentIndex],
        ),
      ),
      body: ConditionalBuilder(
        builder: (context) => screens[currentIndex] ,
        condition: tasks.isNotEmpty ,
        fallback: (context) => const Center(child: CircularProgressIndicator()) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isBottomSheetShown)
          {
            if(formkey.currentState!.validate())
            {
              insertdatabase(
                date: dateControll.text,
                time: timeControll.text,
                title: titleControll.text,
              ).then((value)
              {
                getDataBaseFromdatabase(database).then((value)
                {
                  Navigator.pop(context);
                  setState(()
                  {
                    tasks = value;

                    isBottomSheetShown = false;
                    fabIcon = Icons.edit;
                  });

                });

              });

            }

          }

              scaffoldKey.currentState!.showBottomSheet(
                elevation: 20.0,
                      (context) => Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                      [
                        TextFormField(
                          controller: titleControll ,
                          keyboardType:TextInputType.text,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return ' Title must be not empty';
                            }
                            return null;
                          },
                          decoration:const InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            label: Text('Task Title'),
                            prefixIcon: Icon(Icons.title),
                            ),
                        ),
                        const SizedBox(
                          height:20.0 ,),
                        TextFormField(
                          controller: timeControll ,
                          onTap: ()
                          {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()).then((value)
                            {
                              timeControll.text = value!.format(context).toString();
                              print(value.format(context));
                            });
                          },
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return ' Time must be not empty';
                            }
                            return null;
                          },

                          decoration:const InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            label: Text('Task Time'),
                            prefixIcon: Icon(Icons.watch_later),

                          ),
                        ),
                        const SizedBox(
                          height:20.0 ,),
                        TextFormField(
                          controller: dateControll ,
                          onTap: ()
                          {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:DateTime.now()  ,
                              lastDate:DateTime.parse('2022-09-01'),

                            ).then((value)
                            {
                              dateControll.text= DateFormat.yMMMMd().format(value!).toString();
                            });
                          },
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return ' Date must be not empty';
                            }
                            return null;
                          },

                          decoration:const InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            label: Text('Task date'),
                            prefixIcon: Icon(Icons.calendar_today),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )).closed.then((value)
              {

                isBottomSheetShown = false;
                setState(()
                {
                  fabIcon = Icons.edit;
                });
              });
              isBottomSheetShown = true;
              setState(()
              {
                fabIcon = Icons.add;
              });
            }
        },

        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items:
        const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_rounded,
            ),
            label: 'done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive,
            ),
            label: 'Archived',
          ),
        ],
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    creatdatabase();
  }


  void creatdatabase() async {
    database = await openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) async
      {
        print('data base created');

        database.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)')
            .then((value) {
          print('database table created ');
        }).catchError((error) {
          print('When database table created ${error.toString()}');
        });
      },

      onOpen: (database) {
        getDataBaseFromdatabase(database).then((value)
        {
          setState(()
          {
            tasks = value;
          });

        });
        print('data base opened');
      },
    );
  }


  Future insertdatabase({@required title , @required time , @required date} ) async {

  return await database.transaction((txn) async
    {

      txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new")').then((value){
        print(' $value data Inserted Successfully');

      });
    });

    }



 Future<List<Map>> getDataBaseFromdatabase(database) async
  {
    return await database.rawQuery('SELECT * FROM tasks');

  }


  }

