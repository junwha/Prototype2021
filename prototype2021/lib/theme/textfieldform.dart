import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  String hintText;
  Function(String) onChanged;
  TextFieldForm({required this.hintText, required this.onChanged});

  @override
  _TextFieldFormState createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  String inputText = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$inputText'),
        TextField(
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: this.widget.hintText),
          onChanged: this.widget.onChanged,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        )
      ],
    );
  }
}
