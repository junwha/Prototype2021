import 'dart:io';

import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  String name;

  SearchResult(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
