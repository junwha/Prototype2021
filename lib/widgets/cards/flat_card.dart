import 'package:flutter/material.dart';

class FlatCard extends StatelessWidget {
  final void Function()? onTap;
  final String title;

  const FlatCard({
    Key? key,
    required this.title,
    this.onTap,
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
