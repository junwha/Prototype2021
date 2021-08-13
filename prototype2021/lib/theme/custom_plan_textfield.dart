import 'package:flutter/material.dart';

class CustomPlanTextField extends StatefulWidget {
  String hintText;
  Function(String) onChanged;
  String initialText;
  int maxLine;
  bool isChecked1 = true;
  double height;
  double width;

  CustomPlanTextField(
      {required this.hintText,
      required this.onChanged,
      this.height = 50,
      this.width = 260,
      this.initialText = '',
      this.maxLine = 1});

  @override
  _CustomPlanTextFieldState createState() => _CustomPlanTextFieldState();
}

class _CustomPlanTextFieldState extends State<CustomPlanTextField> {
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
          height: this.widget.height,
          width: this.widget.width,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: Color(0xff505050),
                ),
              ),
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 10, right: 15),
              hintText: this.widget.hintText,
              hintStyle: TextStyle(
                color: Color(0xffbdbdbd),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: this.widget.onChanged,
            maxLines: this.widget.maxLine,
            keyboardType: TextInputType.multiline,
            enableInteractiveSelection: false,
          ),
        ),
        Container(
          height: this.widget.height,
          width: this.widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Image.asset(
                    'assets/icons/ic_save_edit.png',
                  ),
                  onPressed: () {
                    setState(() {
                      this.widget.isChecked1 = !this.widget.isChecked1;
                    });
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
