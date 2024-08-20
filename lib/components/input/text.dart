import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      required this.controller,
      this.isTextArea = false,
      // required this.title,
      required this.placeholder, this.onChange, this.onSubmit});

  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final bool isTextArea;
  // final String title;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: ListTile(
        title: TextFormField(
          maxLines: isTextArea ? 2 : 1,
          controller: controller,
          decoration: InputDecoration(
              hintText: placeholder,
              counter: Container(),
              border: isTextArea ? InputBorder.none : null,
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo))),
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
        ),
      ),
    );
  }
}
