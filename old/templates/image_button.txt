
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String backgroundImageDir;
  final String title;
  final double width;
  final double height;
  final Alignment textAlignment;
  final double fontSize;

  const ImageButton({
    this.backgroundImageDir,
    this.title,
    this.width = 180,
    this.height = 250,
    this.textAlignment = Alignment.bottomCenter,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage(this.backgroundImageDir),
          fit: BoxFit.cover,
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () {},
        child: Align(
          alignment: this.textAlignment,
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: this.fontSize),
          ),
        ),
      ),
    );
  }
}
