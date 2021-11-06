import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircularImage extends StatelessWidget {
  final XFile? image;
  final double size;
  final EdgeInsets? margin;

  const CircularImage({
    Key? key,
    this.image,
    this.size = 76,
    this.margin = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: margin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffdbdbdb),
        image: (image == null)
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(image!.path),
                ),
              ),
      ),
    );
  }
}
