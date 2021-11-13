
import 'package:flutter/material.dart';
import 'package:to_do/database_helper.dart';
import 'package:to_do/models/Task.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task? task;

  TaskPage(this.task);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;

  @override
  void initState() {
    if (widget.task != null){
      _taskId = widget.task!.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/back_arrow_icon.png'))),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 12),
                        child: TextField(
                          onSubmitted: (t) async {
                            if (t != "") {
                              if (widget.task == null) {
                                Task _task = Task(title: t);
                                await _dbHelper.insertTask(_task);
                                Navigator.pop(context);
                              } else {
                                print("update existing task");
                              }
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Enter task title",
                              border: InputBorder.none),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551)),
                          controller: TextEditingController()
                            ..text = (widget.task != null
                                ? widget.task?.title
                                : "")!,
                        ),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter description for the task",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24)),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF211551)),
                  ),
                ),
                Expanded(
                  child:  FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getToDo(_taskId),
                      builder: (context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: TodoWidget(
                                    snapshot.data[index].title,
                                    snapshot.data[index].isDone == 0
                                        ? false
                                        : true),
                              );
                            });
                      }),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(right: 10, left: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFF86829D), width: 1.5),
                              color: Colors.transparent,
                            ),
                            child: Image(
                                image: AssetImage(
                                    "assets/images/check_icon.png"))),
                        Expanded(
                            child: TextField(
                          onSubmitted: (t) async {
                            if (t != "") {
                              DatabaseHelper _dbHelper = DatabaseHelper();
                              ToDo _todo = ToDo( taskId: _taskId , title: t, isDone: 0);
                              await _dbHelper.insertToDo(_todo);
                              setState(() { });
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Enter your todo",
                              border: InputBorder.none),
                        ))
                      ],
                    )
                  ],
                ),
              ]),
              Positioned(
                bottom: 24,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    print('delete task');
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFE3577)),
                    child: Image(
                      image: AssetImage("assets/images/delete_icon.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
