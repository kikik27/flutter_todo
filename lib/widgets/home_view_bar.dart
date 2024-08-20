import 'package:flutter/material.dart';

class HomeViewBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: const SizedBox(
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Todo List Project",
                  style: TextStyle(fontSize: 18, color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
