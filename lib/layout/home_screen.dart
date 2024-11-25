import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/components/constants.dart';
import 'package:to_do_app/modules/archived_tasks.dart';
import 'package:to_do_app/modules/done_tasks.dart';
import 'package:to_do_app/modules/tasks.dart';
import 'package:to_do_app/components/reusable_components.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

List<Widget> screens = [
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchivedTasksScreen(),
];

List<String> titles = [
  'New Tasks',
  'Done Tasks',
  'Archived Tasks',
];
late Database database;
int selcindex = 0;
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();

bool isBottomSheetShow = false;
IconData floticon = Icons.edit;
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
Color? maincolor = Colors.green[300];
double sizeboxheight = 10;

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    createDataBase();
  }

  Future<void> _refresh() async {
    // Perform some asynchronous operation to update the items list
    await Future.delayed(Duration(seconds: 1));
   
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: 
          
           RefreshIndicator(onRefresh :_refresh,
          child: screens[selcindex]),
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          titles[selcindex],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: maincolor,
        onPressed: () {
          if (isBottomSheetShow) {
            if (formKey.currentState!.validate()) {
              insertDataBase(
                title: titleController.text,
                time: timeController.text,
                date: dateController.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  setState(() {
                    isBottomSheetShow = false;
                    tasks = value;
                    floticon = Icons.edit;
                  });
                });
              });
            }
          } else {
            scaffoldKey.currentState
                ?.showBottomSheet(
                  (context) => Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            label: 'notes',
                            prefix: Icons.title,
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: sizeboxheight,
                          ),
                          defaultFormField(
                            label: 'time',
                            prefix: Icons.watch_later_outlined,
                            controller: timeController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  timeController.text =
                                      value.format(context).toString();
                                }
                              });
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: sizeboxheight,
                          ),
                          defaultFormField(
                            label: 'date',
                            prefix: Icons.calendar_today,
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2030-12-01'),
                              ).then((value) {
                                dateController.text = value.toString();
                              });
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'must not be empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .closed
                .then((value) {
              isBottomSheetShow = false;
              setState(() {
                floticon = Icons.edit;
              });
            });
            isBottomSheetShow = true;
            setState(() {
              floticon = Icons.add;
            });
          }
        },
        child: Icon(floticon),
      ),

      //creating buttom navigation bar and insert the items into a list and taking the taped item index and pass it to public var selcindex
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selcindex,
          onTap: (index) {
            setState(() {
              selcindex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'new tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: 'done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'archive'),
          ]),
    );
  }

// This part of code for creating  into database
  void createDataBase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT);')
          .then((value) {
        print('table created');
      }).catchError((Error) {
        print('error is ${Error.toString}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        tasks = value;
      });
    });
  }

// this part for inserting into database
  Future insertDataBase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO  tasks (title,date,time,status) values ("$title" ,"$date","$time","new")')
          .then((value) {
        print('$value inserted sussefully');
      }).catchError((error) {
        print('error${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * from tasks');
  }
}
