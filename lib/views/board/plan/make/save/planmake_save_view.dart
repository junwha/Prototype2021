import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/model/board/plan/plan_dto.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/widgets/textfields/custom_plan_textfield.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/widgets/shapes/tb_contenttag.dart';
import 'package:prototype2021/widgets/radio/tb_radio_bar.dart';
import 'package:prototype2021/widgets/buttons/tb_save_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PlanmakeSaveView extends StatefulWidget {
  final void Function(Navigate, [PlanMakeViewMode?]) navigator;
  const PlanmakeSaveView({Key? key, required this.navigator}) : super(key: key);

  @override
  _PlanmakeSaveViewState createState() =>
      _PlanmakeSaveViewState(navigator: navigator);
}

class _PlanmakeSaveViewState extends State<PlanmakeSaveView> {
  final void Function(Navigate, [PlanMakeViewMode?]) navigator;

  _PlanmakeSaveViewState({required this.navigator});

  int selectedRadio1 = 1;
  int selectedRadio2 = 1;
  int _selectedValue = 0;
  List<String> priceList = [
    '0원~10만원',
    '10만원~30만원',
    '30만원~50만원',
    '50만원~70만원',
    '70만원~100만원',
    '100만원 이상'
  ];
  bool _selected = false;
  List<bool> isTagsSelected = [
    true,
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<String> tags = [
    "액티비티",
    "관광명소",
    "인생사진",
    "역사탐방",
    "맛집탐방",
    "야경감상",
    "SNS핫플",
    "휴양",
    "이색체험",
    "쇼핑메카"
  ];

  List<String> get selectedTags {
    List<String> selected = [];
    for (String tag in tags) {
      if (isTagsSelected[tags.indexOf(tag)]) {
        selected.add(tag);
      }
    }
    return selected;
  }

  int randomN = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                buildContentTitle(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)) // POINT
                        ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildInfo(context),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Color(0xffbdbdbd),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          buildRadioArea(
                            "여행 피로도",
                            selectedRadio1,
                            "여유롭고\n느긋한여행",
                            "바쁘더라도\n알찬 여행",
                            (int? val) {
                              print(val);
                              // Changes the selected value on 'onChanged' click on each radio button
                              setState(() {
                                selectedRadio1 = val!;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildRadioArea(
                            '여행 경비',
                            selectedRadio2,
                            '불편해도 \n저렴하게',
                            "비싸더라도\n편안하게",
                            (int? val) {
                              // Changes the selected value on 'onChanged' click on each radio button
                              setState(() {
                                selectedRadio2 = val!;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TBSaveButton(
                                buttonTitle: '저장하기',
                                onPressed: () async {
                                  UserInfoHandler userInfoHandler =
                                      Provider.of<UserInfoHandler>(context,
                                          listen: false);
                                  PlanMakeHandler planMakeHandler =
                                      Provider.of<PlanMakeHandler>(context,
                                          listen: false);
                                  PlanLoader loader = PlanLoader();

                                  PlanData data = PlanData(
                                    -1,
                                    planMakeHandler.title!,
                                    [],
                                    (planMakeHandler
                                                .flattenPlanListItems.length !=
                                            0)
                                        ? planMakeHandler
                                            .flattenPlanListItems[randomN].photo
                                        : null,
                                    selectedTags,
                                    _selectedValue,
                                    planMakeHandler.dateRange!,
                                    selectedRadio1,
                                    selectedRadio2,
                                    [[]],
                                  );

                                  bool saved = await loader.createPlan(
                                      userInfoHandler.token!, data);
                                  print(saved);

                                  if (saved) widget.navigator(Navigate.forward);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Row buildInfo(BuildContext context) {
    PlanMakeHandler calendarHandler = Provider.of<PlanMakeHandler>(context);

    return Row(
      children: [
        buildPreview(),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPlanTextField(
                  width: double.infinity,
                  hintText: '여행 이름을 입력해주세요.',
                  onChanged: (String text) {
                    calendarHandler.title = text;
                  }),
              SizedBox(
                height: 5,
              ),
              // Text(buildRegionString(calendarHandler),
              //     style:
              //         builidTextStyle(11, Color(0xff707070), FontWeight.w400),
              //     textAlign: TextAlign.left),
              SizedBox(
                height: 10,
              ),
              Text(
                  "기간 : ${calendarHandler.dateDifference}일 (${buildDateString(calendarHandler) ?? "x"})",
                  style:
                      builidTextStyle(14, Color(0xff707070), FontWeight.w400),
                  textAlign: TextAlign.left),
              buildBudget(context),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                        children: List.generate(
                            tags.length,
                            (index) => isTagsSelected[index]
                                ? TBContentTag(contentTitle: tags[index])
                                : SizedBox())),
                  ),
                  IconButton(
                      icon: Image.asset("assets/icons/ic_save_edit.png"),
                      onPressed: () {
                        showTagsDialog(context)
                            .then((value) => setState(() {}));

                        print(isTagsSelected[0]);
                      }),
                ],
              ),
            ],
          ),
        ), // 상하이, 베이징, 광저우
      ],
    );
  }

  String? buildDateString(PlanMakeHandler calendarHandler) {
    DateTime? first = calendarHandler.datePoints.first;
    DateTime? last = calendarHandler.datePoints.last;

    if (first == null && last != null) {
      return "${first!.month}월 ${first.day}일";
    } else if (first != null && last == null) {
      return "${last!.month}월 ${last.day}일";
    } else if (first != null && last != null) {
      return "${first.month}월 ${first.day}일 ~ ${last.month}월 ${last.day}일";
    }
    return null;
  }

  int countList(List<dynamic> list, dynamic target) {
    return list
        .map((e) => e == target ? 1 : 0)
        .reduce((value, element) => value + element);
  }

  // TODO: 컨텐츠 가져오기에서 areaCode도 함께 가져와야함
  String buildRegionString(PlanMakeHandler calendarHandler) {
    List<PlaceDataInterface> items = calendarHandler.flattenPlanListItems;
    items.toSet().toList().sort((PlaceDataInterface a, PlaceDataInterface b) =>
        countList(items, a).compareTo(countList(items, a)));
    items.removeWhere((element) => element.address == null);

    if (items.length < 3) return items.map((e) => e.address!).join(", ");
    return "${items[0].address!}, ${items[1].address!}, ${items[2].address!}";
  }

  Future<dynamic> showTagsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          List<bool> _isTagsSelected = List.from(isTagsSelected);
          return StatefulBuilder(builder: (context, setState) {
            return TBSimpleDialog(
              title: '태그 수정',
              body: Column(
                children: [
                  // 사각형 1720
                  Container(
                    width: double.infinity,
                    height: 81,
                    decoration: BoxDecoration(color: const Color(0xfff6f6f6)),
                    child: buildTagFilterChipRow(_isTagsSelected, setState, 0),
                  ),

                  buildTagFilterChipRow(_isTagsSelected, setState, 3),
                  buildTagFilterChipRow(_isTagsSelected, setState, 6),
                ],
              ),
              onSubmitPressed: () {
                if (_isTagsSelected
                        .where((element) => element)
                        .toList()
                        .length >
                    6) {
                  Fluttertoast.showToast(
                      msg: "태그는 6개 이하 선택 가능합니다.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  setState(() {
                    isTagsSelected = List.from(_isTagsSelected);
                  });
                }
              },
            );
          });
        });
  }

  Row buildTagFilterChipRow(
      List<bool> _isTagsSelected, StateSetter setState, int offset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        3,
        (index) => FilterChip(
            showCheckmark: false,
            selectedColor: Colors.grey,
            disabledColor: Colors.white,
            selected: _isTagsSelected[index + offset],
            label: Text(tags[index + offset]),
            onSelected: (bool selected) {
              setState(() {
                _isTagsSelected[index + offset] =
                    !_isTagsSelected[index + offset];
              });
            }),
      ),
    );
  }

  Column buildRadioArea(String title, int selectedRadio, String minimumText,
      String maximumText, Function(int?) onChanged) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/icons/img_check_green.png'),
            Text(title,
                style: builidTextStyle(16, Color(0xff555555), FontWeight.w700)),
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: TBRadioBar(
                selectedRadio: selectedRadio,
                onChanged: onChanged,
                minimumText: minimumText,
                maximumText: maximumText)),
      ],
    );
  }

  Container buildBudget(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "예산:",
                style: TextStyle(
                  color: Color(0xff707070),
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                priceList[_selectedValue],
                style: TextStyle(
                  color: Color(0xff707070),
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
          IconButton(
              icon: Image.asset("assets/icons/ic_save_edit.png"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => TBSimpleDialog(
                          title: '예산설정',
                          body: Container(height: 230, child: buildCupertino()),
                        ));
              }),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xff707070)),
        ),
      ),
    );
  }

  Widget buildPreview() {
    PlanMakeHandler planMakeHandler = Provider.of<PlanMakeHandler>(context);
    List<PlaceDataInterface> items = planMakeHandler.flattenPlanListItems;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          height: 150,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            image: new DecorationImage(
              image: new NetworkImage(
                (items.length != 0 && items[randomN].photo != null)
                    ? items[randomN].photo!
                    : placeHolder,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              randomN = Random(null).nextInt(items.length - 1);
            });
          },
        )
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xfff6f6f6),
      shadowColor: Color(0xfff6f6f6),
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
        onPressed: () {},
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/ic_hamburger_menu.png')),
      ],
    );
  }

  Padding buildContentTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
      child: Row(
        children: [
          Text('여행',
              style: builidTextStyle(
                25,
                Color(0xff4080ff),
                FontWeight.w700,
              )),
          SizedBox(
            width: 6,
          ),
          Text('저장하기',
              style: builidTextStyle(19, Color(0xff9dbeff), FontWeight.w500)),
        ],
      ),
    );
  }

  TextStyle builidTextStyle(
      double size, Color textcolor, FontWeight textweight) {
    return TextStyle(
      color: textcolor,
      fontSize: size,
      fontFamily: 'Roboto',
      fontWeight: textweight,
      fontStyle: FontStyle.normal,
    );
  }

  CupertinoPicker buildCupertino() {
    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 45,
      scrollController: FixedExtentScrollController(initialItem: 1),
      children: priceList
          .map(
            (text) => Text(
              text,
              style: TextStyle(
                color: Color(0xff707070),
                fontFamily: 'Roboto',
              ),
            ),
          )
          .toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }
}
