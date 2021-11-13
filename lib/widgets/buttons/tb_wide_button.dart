import 'package:flutter/material.dart';

class TBWideButton extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const TBWideButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 85,
        child: Card(
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 25, 0, 0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(68, 68, 68, 1)),
              ),
            ),
          ),
        ));
  }
}
