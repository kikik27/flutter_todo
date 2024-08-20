import 'package:animate_do/animate_do.dart';
import 'package:flut_todo/extensions/space_exs.dart';
import 'package:flut_todo/components/buttons/create.dart';
import 'package:flut_todo/main.dart';
import 'package:flut_todo/models/task.dart';
import 'package:flut_todo/screens/task/task_screen.dart';
import 'package:flut_todo/widgets/home_view_bar.dart';
import 'package:flut_todo/widgets/task_view_list.dart';
import 'package:flut_todo/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          tasks.sort(((a, b) => a.createdAtDate.compareTo(b.createdAtDate)));

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 245, 242),
            floatingActionButton: CreateButton(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) => const TaskScreen(
                              titleTaskController: null,
                              descTaskController: null,
                              task: null,
                            )));
              },
            ),
            appBar: const HomeViewBar(),

            //body
            body: _buildHomeBody(base, tasks),
          );
        });
  }

//Home Body
  Widget _buildHomeBody(
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        // Taskss
        Expanded(
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) =>
                              base.dataStore.deleteTask(task: task),
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              8.w,
                              const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          key: Key(index.toString()),
                          child: TaskWidget(task: task));
                    })
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                          child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(
                          lottieURL,
                          animate: tasks.isNotEmpty ? false : true,
                        ),
                      )),
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          'You Have Done All Tasks! 👍🏻',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ))
      ]),
    );
  }
}
