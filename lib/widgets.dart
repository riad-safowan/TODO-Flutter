import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidgets extends StatelessWidget {
  final String? title;
  final String? description;

  TaskCardWidgets({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              description ??
                  "Welcome to list. Welcome to troikasoft list. Welcome to troikasoft ToDo list Welcome to troikasoft ToDo list",
              style: TextStyle(color: Color(0xFF86829D), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final String? text;
  final bool isDone;

  TodoWidget(this.text, this.isDone);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: isDone
                    ? null
                    : Border.all(color: Color(0xFF86829D), width: 1.5),
                color: isDone ? Color(0xFF7349FE) : Colors.transparent,
              ),
              child: Image(image: AssetImage("assets/images/check_icon.png"))),
          Text(
            text ?? "Unnamed todo",
            style: TextStyle(
                color: isDone ? Color(0xFF211551) : Color(0xFF86829D),
                fontSize: 16,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
