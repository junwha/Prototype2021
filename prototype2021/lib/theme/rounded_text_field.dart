import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(21)),
              borderSide: BorderSide.none),
          prefixIcon: prefixIcon,
          fillColor: const Color(0xffe8e8e8),
          filled: true,
          contentPadding: EdgeInsets.all(12),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 14.0)),
    );
  }
}
