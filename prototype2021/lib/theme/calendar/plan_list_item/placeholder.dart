import 'package:flutter/material.dart';

class PlanListPlaceHolder extends StatelessWidget {
  final Key? key;

  PlanListPlaceHolder({this.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: key,
      child: SizedBox(height: 27),
    );
  }
}
