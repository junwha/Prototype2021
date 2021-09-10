import 'package:flutter/material.dart';
import 'package:prototype2021/loader/signin_loader.dart';
import 'package:prototype2021/model/signin_model.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/signin/helpers.dart';
import 'package:prototype2021/theme/signin/widgets.dart';
import 'package:prototype2021/ui/signin_page/signin_view_gender.dart';
import 'package:provider/provider.dart';

class SigninViewBirth extends StatefulWidget {
  const SigninViewBirth({Key? key}) : super(key: key);

  @override
  _SigninViewBirthState createState() => _SigninViewBirthState();
}

class _SigninViewBirthState extends State<SigninViewBirth>
    with SignInViewWidgets, SigninLoader, SigninViewHelper {
  final List<int> dayList = List.generate(31, (index) => index + 1);
  final List<String> monthList =
      List.generate(12, (index) => "${(index + 1).toString()}월");
  final List<int> yearList = List.generate(41, (index) => 1970 + index);

  int year = 1999;
  String month = '1월';
  int day = 1;

  void setYear(int? _year) => setState(() {
        year = _year ?? 1999;
      });
  void setMonth(String? _month) => setState(() {
        month = _month ?? '1월';
      });
  void setDay(int? _day) => setState(() {
        day = _day ?? 1;
      });

  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(context, shouldPopTo: SigninViewGender),
      body: Center(
          child: Column(children: [
        SizedBox(
          height: 60,
        ),
        Text(
          '생년월일을 알려주세요.',
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 21,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '생년월일',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff999999),
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildDatePicker(),
              SizedBox(
                height: 60,
              ),
              buildSigninButton(context, onPressed: () async {
                try {
                  signInModel.setBirth(
                      new DateTime(year, interpolateMonthToInt(month), day));
                  int userUid = await requestSignup(signInModel);
                  Navigator.popUntil(context, ModalRoute.withName("login"));
                } catch (error) {
                  tbShowTextDialog(context, generateErrorText(error));
                }
              }, text: "시작하기")
            ],
          ),
        ),
      ])),
    );
  }

  Row buildDatePicker() {
    return Row(
      children: [
        buildDropdownMenu<int>(
            value: year, allValues: yearList, valueSetter: setYear),
        SizedBox(
          width: 12,
        ),
        buildDropdownMenu<String>(
            value: month, allValues: monthList, valueSetter: setMonth),
        SizedBox(
          width: 12,
        ),
        buildDropdownMenu<int>(
            value: day, allValues: dayList, valueSetter: setDay),
      ],
    );
  }

  Container buildDropdownMenu<T>(
      {required T value,
      required List<T> allValues,
      required void Function(T?) valueSetter}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xffbdbdbd),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      height: 60,
      width: 120,
      child: Center(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          underline: SizedBox(),
          items: allValues.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text("${value.toString()}"),
              );
            },
          ).toList(),
          onChanged: valueSetter,
        ),
      ),
    );
  }

  int interpolateMonthToInt(String month) =>
      int.parse(month.replaceAll('월', ''));
}
