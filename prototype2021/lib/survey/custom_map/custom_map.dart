import 'package:flutter/material.dart';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //ClipRRect clips the map with size of child
      child: ClipRRect(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 2.0,
          child: Stack(
            children: [
              Image.network(
                  "https://jandi-box.com/files-thumb/21500362/1613128992050214edc3ab4cc68fe8721bd4056d3ce97?size=640"), //Map image in background
              //By using [Positioned], place icon, button, etc. on the map
              Positioned(
                  top: 150, left: 100, child: Icon(Icons.add_location_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
