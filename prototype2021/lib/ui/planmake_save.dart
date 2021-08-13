import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_pw_textfield.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';

class PlanmakeSaveView extends StatefulWidget {
  const PlanmakeSaveView({Key? key}) : super(key: key);

  @override
  _PlanmakeSaveViewState createState() => _PlanmakeSaveViewState();
}

class _PlanmakeSaveViewState extends State<PlanmakeSaveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        appBar: buildAppBar(),
        body: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Row(
                children: [
                  Text(
                    '여행',
                    style: TextStyle(
                      color: Color(0xff4080ff),
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '저장하기',
                    style: TextStyle(
                      color: Color(0xff9dbeff),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)) // POINT
                    ),
              ),
            ),
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
          onPressed: () {},
        ),
        title: Text("여행저장하기",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0 * pt),
            textAlign: TextAlign.left));
  }
}
