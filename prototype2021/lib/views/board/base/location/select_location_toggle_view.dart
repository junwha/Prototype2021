import 'package:flutter/material.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/settings/constants.dart';

class SelectLocationToggleView extends StatefulWidget {
  String mainLocation;
  String subLocation;
  SelectLocationToggleView(
      {required this.mainLocation, required this.subLocation});

  @override
  _SelectLocationToggleViewState createState() =>
      _SelectLocationToggleViewState();
}

class _SelectLocationToggleViewState extends State<SelectLocationToggleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: buildSelectLocationSection(),
    );
  }

  Row buildSelectLocationSection() {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: ListView(
            children: mainLocations
                .map((data) => buildOutlinedButton(data, () {
                      setState(() {
                        this.widget.mainLocation = data;
                        this.widget.subLocation = "";
                      });
                    },
                        data == this.widget.mainLocation
                            ? Color(0xffe8e8e8)
                            : Color(0xffffffff)))
                .toList(),
          ),
        ),
        Expanded(
          flex: 10,
          child: ListView(
            children: subLocations[this.widget.mainLocation]!
                .map((data) => buildOutlinedButton(data, () {
                      setState(() {
                        this.widget.subLocation = data;
                      });
                    },
                        data == this.widget.subLocation
                            ? Color(0xffe8e8e8)
                            : Color(0xffffffff)))
                .toList(),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        '지역 선택',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15 * pt,
          fontFamily: 'Roboto',
        ),
      ),
      toolbarHeight: 80,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          width: 70 * pt,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10 * pt),
              ),
              backgroundColor: Color(0xff4080ff),
            ),
            child: Center(
              child: Text(
                '완료',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15 * pt,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onPressed: () {
              if (this.widget.subLocation != "") {
                Navigator.pop(context, {
                  "mainLocation": this.widget.mainLocation,
                  "subLocation": this.widget.subLocation
                });
              }
            },
          ),
        )
      ],
    );
  }

  Widget buildOutlinedButton(String text, Function() onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Color(0xffe8e8e8),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        height: 50 * pt,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
