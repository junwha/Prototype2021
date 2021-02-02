import 'package:flutter/material.dart';
import 'package:prototype2021/templates/ticket_button.dart';
import 'package:prototype2021/templates/select_trip_plan.dart';
import 'package:prototype2021/templates/story_explanation.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
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
        body: Column(
          children: [
            StoryExplanation(
              title: "스토리 설명",
              explanation: "TripBuilder Devloper",
            ),
            SelectTripPlan(),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [],
            //     ),
            //   ),
            // ),
            Container(height: 80, child: Text('asfd'))
          ],
        ));
  }
}
