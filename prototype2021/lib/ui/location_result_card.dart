import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationResultCard extends StatelessWidget {
  String name;
  double size = 80;
  Image? image;
  Function()? onclick;

  LocationResultCard({required this.name, this.image, this.onclick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Column(
        children: [
          Container(
            height: size,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  height: size,
                  width: size,
                  child: image,
                ),
                SizedBox(width: 10),
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1),
        ],
      ),
    );
  }
}

class LocationResultCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
