import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSubmitted;
  final void Function()? onTap;
  final TextEditingController? textController;
  final String? hintText;
  final Image? prefixIcon;

  const RoundedTextField({
    Key? key,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textController,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  TextEditingController _textController;

  _RoundedTextFieldState({TextEditingController? textController})
      : _textController = textController ?? new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(21)),
              borderSide: BorderSide.none),
          prefixIcon: widget.prefixIcon,
          fillColor: const Color(0xffe8e8e8),
          filled: true,
          contentPadding: EdgeInsets.all(12),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 14.0)),
    );
  }
}
