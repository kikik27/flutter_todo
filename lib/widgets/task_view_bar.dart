import 'package:flutter/material.dart';

class TaskViewBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskViewBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 30),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            children: const [
                          TextSpan(
                              text: "Task",
                              style: TextStyle(fontWeight: FontWeight.w500))
                        ])),
                    const Text("What are you planning ?",
                        style: TextStyle(fontSize: 12, color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
