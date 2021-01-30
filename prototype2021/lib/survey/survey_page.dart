import 'package:flutter/material.dart';
import 'package:prototype2021/templates/ticket_button.dart';
import 'package:prototype2021/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svgs/ticket.svg',
                        semanticsLabel: 'ticket')
                  ],
                ),
              ),
            ),
            Container(
                height: 80,
                child: SvgPicture.asset('assets/svgs/ticket.svg',
                    semanticsLabel: 'ticket'))
          ],
        ));
  }
}
