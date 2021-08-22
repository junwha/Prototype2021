import 'package:flutter/material.dart';

class CircularWrapper extends StatelessWidget {
  final double size;
  final double borderRadius;
  final Widget icon;
  final void Function()? onTap;
  final Color backgroundColor;
  final bool shadow;

  CircularWrapper(
      {required this.size,
      required this.icon,
      this.backgroundColor = Colors.white,
      this.shadow = false,
      this.onTap})
      : borderRadius = size / 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          child: Center(
            child: icon,
          ),
          decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: shadow
                  ? [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 0)
                    ]
                  : [],
              borderRadius: BorderRadius.circular(borderRadius)),
          width: size,
          height: size,
        ));
  }
}
