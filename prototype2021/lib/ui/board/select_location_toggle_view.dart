import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/location_toggle.dart';

class SelectLocationToggleView extends StatefulWidget {
  const SelectLocationToggleView({Key? key}) : super(key: key);

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
      body: LocationToggle(),
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
        onPressed: () {},
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
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
