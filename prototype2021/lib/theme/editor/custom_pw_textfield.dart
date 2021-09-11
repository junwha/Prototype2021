import 'package:flutter/material.dart';

class CustomPWTextField extends StatefulWidget {
  String hintText;
  Function(String) onChanged;
  String initialText;
  int maxLine;
  bool isChecked1 = true;
  bool isChecked2 = false;

  CustomPWTextField(
      {required this.hintText,
      required this.onChanged,
      this.initialText = '',
      this.maxLine = 1});

  @override
  _CustomPWTextFieldState createState() => _CustomPWTextFieldState();
}

class _CustomPWTextFieldState extends State<CustomPWTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: this.widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75,
          decoration: BoxDecoration(
            color: const Color(0xfff2f2f2),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 30, right: 15),
                hintText: this.widget.hintText),
            onChanged: this.widget.onChanged,
            maxLines: this.widget.maxLine,
            obscureText: this.widget.isChecked1,
            keyboardType: TextInputType.multiline,
            enableInteractiveSelection: false,
          ),
        ),
        Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Image.asset(
                    'assets/icons/ic_eye_gray.png',
                  ),
                  onPressed: () {
                    setState(() {
                      this.widget.isChecked1 = !this.widget.isChecked1;
                    });
                  }),
              IconButton(
                  icon: Image.asset(
                    'assets/icons/ic_search_remove_background.png',
                  ),
                  onPressed: () {
                    setState(() {
                      this.widget.isChecked2 = !this.widget.isChecked2;
                      _controller!.clear();
                    });
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
