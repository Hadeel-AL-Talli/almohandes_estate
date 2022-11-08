import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final void Function(String value) onChanged;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,

      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      style: TextStyle(color: Theme.of(context).textTheme.labelLarge?.color),
      // const TextStyle(
      //   color: Colors.black,
      //   fontWeight: FontWeight.bold,
      // ),
      decoration: InputDecoration(
          counterText: '',
          enabledBorder: border(),
          focusedBorder: border(borderColor: Color(0xffFA8B06))),
    );
  }

  OutlineInputBorder border({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }
}
