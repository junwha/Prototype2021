import 'package:flutter/material.dart';
import 'package:prototype2021/survey/templates/ticket_button.dart';
import 'package:prototype2021/survey/templates/select_trip_plan.dart';
import 'package:prototype2021/survey/templates/story_explanation.dart';
import 'package:prototype2021/survey/custom_map/custom_map.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<bool> _isSelected = [false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Trip Builder',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            StoryExplanation(
              explanation: "asdf",
            ),
            //   SelectTripPlan(),
            CustomMap(),
          ],
        ),
      ),
    );
  }
}
