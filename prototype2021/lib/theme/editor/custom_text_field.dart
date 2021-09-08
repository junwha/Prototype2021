import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final String initialText;
  final int maxLine;
  final bool isPasswordField;
  final bool onError;
  final Widget? extraActionsWidget;

  CustomTextField({
    required this.hintText,
    required this.onChanged,
    this.initialText = '',
    this.maxLine = 1,
    this.isPasswordField = false,
    this.onError = false,
    this.extraActionsWidget,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  bool isChecked2 = false;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: this.widget.initialText);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75,
          decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
              border: Border(
                  bottom: BorderSide(
                      color: this.widget.onError
                          ? const Color(0xffff3120)
                          : Colors.transparent,
                      width: 1))),
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
            obscureText: this.widget.isPasswordField ? this.isObscure : false,
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
              widget.isPasswordField
                  ? IconButton(
                      icon: Image.asset(
                        'assets/icons/ic_eye_gray.png',
                      ),
                      onPressed: () {
                        setState(() {
                          this.isObscure = !this.isObscure;
                        });
                      })
                  : SizedBox(),
              IconButton(
                  icon: Image.asset(
                    'assets/icons/ic_search_remove_background.png',
                  ),
                  onPressed: () {
                    setState(() {
                      this.isChecked2 = !this.isChecked2;
                      _controller!.clear();
                    });
                  }),
              widget.extraActionsWidget ?? SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
