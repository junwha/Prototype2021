import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String hintText;
  Function(String) onChanged;
  String initialText;
  CustomTextField(
      {required this.hintText, required this.onChanged, this.initialText = ''});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: this.widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: this.widget.hintText),
          onChanged: this.widget.onChanged,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          enableInteractiveSelection: false,
        )
      ],
    );
  }
}
