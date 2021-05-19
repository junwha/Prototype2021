import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  String hintText;
  TextFieldForm({required this.hintText});

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
          onChanged: (text) {
            setState(() {
              inputText = text;
            });
          },
          maxLines: null,
          keyboardType: TextInputType.multiline,
        )
      ],
    );
  }
}
