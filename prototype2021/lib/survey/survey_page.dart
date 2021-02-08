import 'package:flutter/material.dart';
import 'package:prototype2021/survey/templates/ticket_button.dart';
import 'package:prototype2021/survey/templates/select_trip_plan.dart';
import 'package:prototype2021/survey/templates/story_explanation.dart';
import 'package:prototype2021/templates/borded_button.dart';

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
            SelectTripPlan(),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: BordedButton(
                      child: Text("내 플랜 미리보기"),
                      onPressed: openDialog,
                      radius: 5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  openDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "안녕안녕안녕안녕",
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text("닫기"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
