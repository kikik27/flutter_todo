import 'package:flut_todo/models/task.dart';
import 'package:flut_todo/screens/task/task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  // ignore: use_super_parameters
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();

  // @override
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerSubTitle = TextEditingController();

  @override
  void initState() {
    textEditingControllerTitle.text = widget.task.title;
    textEditingControllerSubTitle.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerTitle.dispose();
    textEditingControllerSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskScreen(
              titleTaskController: textEditingControllerTitle,
              descTaskController: textEditingControllerSubTitle,
              task: widget.task,
            ),
          ),
        );
      },
      child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: widget.task.isCompleted
                  ? Colors.indigo.withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: const Offset(0, 4),
                    blurRadius: 16)
              ]),
          duration: const Duration(milliseconds: 600),
          child: ListTile(
            //check icon
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color:
                        widget.task.isCompleted ? Colors.green : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1)),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //task title
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                widget.task.title,
                style: TextStyle(
                  color: widget.task.isCompleted ? Colors.indigo : Colors.black,
                  fontWeight: FontWeight.w600,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),

            //task description
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.task.subTitle,
                style: TextStyle(
                  color: widget.task.isCompleted ? Colors.indigo : Colors.black,
                  fontWeight: FontWeight.w400,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),

              //date
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
