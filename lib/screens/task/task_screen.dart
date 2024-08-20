// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flut_todo/components/buttons/default.dart';
import 'package:flut_todo/components/input/date_time_picker.dart';
import 'package:flut_todo/components/input/text.dart';
import 'package:flut_todo/extensions/space_exs.dart';
import 'package:flut_todo/main.dart';
import 'package:flut_todo/models/task.dart';
import 'package:flut_todo/utils/constant.dart';
import 'package:flut_todo/widgets/task_view_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';

import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen(
      {super.key,
      required this.titleTaskController,
      required this.descTaskController,
      required this.task});

  final TextEditingController? titleTaskController;
  final TextEditingController? descTaskController;
  final Task? task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat.Hms().format(DateTime.now()).toString();
      } else {
        return DateFormat.Hms().format(time).toString();
      }
    } else {
      return DateFormat.Hms().format(widget.task!.createdAtTime).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateTime.now();
      } else {
        return time;
      }
    } else {
      return widget.task!.createdAtTime;
    }
  }

  dynamic isTaskAlreadyExistUpdateTask() {
    if (widget.titleTaskController?.text != null &&
        widget.descTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.descTaskController?.text = subTitle;

        // widget.task?.createdAtDate = date!;
        // widget.task?.createdAtTime = time!;

        widget.task?.save();
        Navigator.of(context).pop();
      } catch (error) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title,
          createdAtTime: time,
          createdAtDate: date,
          subTitle: subTitle,
          isCompleted: false,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.of(context).pop();
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  String isTaskAlreadyExist() {
    if (widget.titleTaskController?.text == null &&
        widget.descTaskController?.text == null) {
      return 'Add ';
    } else {
      return 'Update ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 245, 242),

        // App bar
        appBar: TaskViewBar(title: isTaskAlreadyExist()),

        //body
        body: _buildMainTaskActivity(context),
      ),
    );
  }

  Widget _buildMainTaskActivity(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InputText(
              controller: widget.titleTaskController,
              onSubmit: (String val) {
                title = val;
              },
              onChange: (String val) {
                title = val;
              },
              placeholder: 'Title',
            ),
            InputText(
              controller: widget.descTaskController,
              isTextArea: true,
              onSubmit: (String val) {
                subTitle = val;
              },
              onChange: (String val) {
                subTitle = val;
              },
              placeholder: 'Description',
            ),
            DateTimePicker(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                    height: 280,
                    child: TimePickerWidget(
                      initDateTime: showTimeAsDateTime(time),
                      onChange: (dateTime, __) => {
                        setState(() {
                          if (widget.task?.createdAtTime == null) {
                            time = dateTime;
                          } else {
                            widget.task!.createdAtTime = dateTime;
                          }
                        })
                      },
                      dateFormat: 'HH:mm',
                      onConfirm: (dateTime, _) => {
                        setState(() {
                          if (widget.task?.createdAtTime == null) {
                            time = dateTime;
                          } else {
                            widget.task!.createdAtTime = dateTime;
                          }
                        })
                      },
                    ),
                  ),
                );
              },
              title: 'Time',
              time: showTime(time),
              isDate: false,
            ),
            DateTimePicker(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  initialDateTime: showDateAsDateTime(date),
                  minDateTime: DateTime.now(),
                  maxDateTime: DateTime(2030, 12, 31),
                  onChange: (dateTime, _) => {
                    setState(() {
                      if (widget.task?.createdAtDate == null) {
                        date = dateTime;
                      } else {
                        widget.task!.createdAtDate = dateTime;
                      }
                    })
                  },
                  onConfirm: (dateTime, _) => {
                    setState(() {
                      if (widget.task?.createdAtDate == null) {
                        date = dateTime;
                      } else {
                        widget.task!.createdAtDate = dateTime;
                      }
                    })
                  },
                );
              },
              title: 'Date',
              time: showDate(date),
              isDate: true,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isTaskAlreadyExist() == 'Add '
                      ? Container()
                      // ignore: dead_code
                      : Button(
                          onTap: () {
                            widget.task?.delete();
                            Navigator.of(context).pop();
                          },
                          title: 'Delete',
                          icon: Icons.close,
                          // type: 'secondary',
                        ),
                  15.w,
                  Button(
                    onTap: () {
                      // emptyFieldsWarning(context);
                      isTaskAlreadyExistUpdateTask();
                    },
                    title: isTaskAlreadyExist(),
                    icon: Icons.save,
                    type: 'primary',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
