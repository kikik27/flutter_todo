import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final VoidCallback onTap;
  const CreateButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        // elevation: 10,
        child: Container(
          width: 50,
          height: 50,
          // color: Colors.indigo,
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
