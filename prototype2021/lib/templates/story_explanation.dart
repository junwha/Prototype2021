import 'package:flutter/material.dart';

class StoryExplanation extends StatelessWidget {
  final String explanation;

  const StoryExplanation({this.explanation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.grey, width: 3),
                color: Colors.white),
            width: 400,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  explanation,
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(width: 35),
              Container(
                  color: Colors.white,
                  width: 130,
                  alignment: Alignment.center,
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.ac_unit),
                      Text("스토리 설명", style: TextStyle(fontSize: 20)),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
