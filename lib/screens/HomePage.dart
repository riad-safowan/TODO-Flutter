import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/database_helper.dart';
import 'package:to_do/models/Task.dart';
import 'package:to_do/screens/TaskPage.dart';
import '../widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Color(0xFFF6F6F6),
        width: double.infinity,
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20, left: 24),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                initialData: [],
                future: _dbHelper.getTasks(),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskPage(
                                        snapshot.data[index],
                                      )),
                            );
                          },
                          child: TaskCardWidgets(
                            title: snapshot.data[index].title,
                            description: snapshot.data[index].description,
                          ),
                        );
                      });
                },
              ),
            ),
          ]),
          Positioned(
            bottom: 24,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskPage(null)))
                    .then((value) {
                  setState(() {});
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF7349FE)),
                child: Image(
                  image: AssetImage("assets/images/add_icon.png"),
                ),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
