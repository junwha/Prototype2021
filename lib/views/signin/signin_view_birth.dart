import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prototype2021/loader/signin/signin_loader.dart';
import 'package:prototype2021/handler/signin/signin_handler.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/views/signin/mixin/helpers.dart';
import 'package:prototype2021/views/signin/mixin/widgets.dart';
import 'package:prototype2021/views/signin/signin_view_gender.dart';
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
  bool loading = false;

  void setYear(int? _year) => setState(() {
        year = _year ?? 1999;
      });

  void setMonth(String? _month) => setState(() {
        month = _month ?? '1월';
      });

  void setDay(int? _day) => setState(() {
        day = _day ?? 1;
      });

  void setLoading(bool _loading) => setState(() {
        loading = _loading;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar:
          buildAppBar(context, shouldPopTo: SigninViewGender, title: "회원 설정"),
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
        builder: () {
          return Center(
            child: Column(
              children: [
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
                buildNextButton(context),
              ],
            ),
          );
        }
      ),
    );
  }

  Padding buildNextButton(BuildContext context) {
    SignInHandler signInModel = Provider.of<SignInHandler>(context);
    void onPressed() async {
      setLoading(true);
      try {
        signInModel
            .setBirth(new DateTime(year, interpolateMonthToInt(month), day));
        int uid = await requestSignup(signInModel);
        Navigator.popUntil(context, ModalRoute.withName("login"));
      } catch (error) {
        tbShowTextDialog(context, generateErrorText(error));
      }
      setLoading(false);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: buildSigninButton(
        context,
        onPressed: onPressed,
        text: "시작하기",
        loading: loading,
      ),
    );
  }

  Container buildDatePicker() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              child: buildDropdownMenu<int>(
                  value: year, allValues: yearList, valueSetter: setYear),
              flex: 1),
          Flexible(
              child: buildDropdownMenu<String>(
                  value: month, allValues: monthList, valueSetter: setMonth),
              flex: 1),
          Flexible(
              child: buildDropdownMenu<int>(
                  value: day, allValues: dayList, valueSetter: setDay),
              flex: 1)
        ],
      ),
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
      width: MediaQuery.of(context).size.width,
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
