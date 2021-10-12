import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/handler/event/editor_handler.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/views/event/editor/plan_select/plan_select_view.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/views/event/editor/mixin/event_custom_text_field.dart';
import 'package:prototype2021/utils/google_map/widgets/map_preview.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';
import 'package:provider/provider.dart';

class EditorView extends StatefulWidget {
  late WriteType writeType;
  ArticleDetailData? data;

  EditorView() {
    this.writeType = WriteType.POST;
  }

  EditorView.edit(ArticleDetailData data) {
    this.writeType = WriteType.EDIT;
    this.data = data;
  }

  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  ArticleType articleType = ArticleType.EVENT;

  //initialize state as 내 주변 이벤트 [내 주변 이벤트, 동행찾기]
  DateTime? chosenDateTime1;
  DateTime? chosenDateTime2;
  TextEditingController controlofoto = TextEditingController();
  Location? targetLocation;

  final List<int> recruitList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final List<int> ageList = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90];

  @override
  Widget build(BuildContext context) {
    final Map<String, Object>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>?;
    if (args != null && args.containsKey("location")) {
      targetLocation = args["location"] as Location;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
          builder: () {
            return SingleChildScrollView(
              child: Container(
                child: ChangeNotifierProvider(
                  create: (context) => getEditorModel(this.widget.writeType),
                  child: Consumer(
                      builder: (context, EditorHandler editorModel, child) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                          20.0 * pt, 30.0 * pt, 20.0 * pt, 20.0 * pt),
                      child: Column(
                        children: [
                          buildHeaderBar(editorModel),
                          SizedBox(
                            height: 23 * pt,
                          ),
                          buildTypeToggle(editorModel),
                          SizedBox(
                            height: 16 * pt,
                          ),
                          Container(height: 1, width: 500, color: Colors.grey),
                          Container(
                              height: 61 * pt,
                              child: EventCustomTextField(
                                height: 75,
                                hintText: "제목",
                                onChanged: (String text) {
                                  editorModel.title = text;
                                },
                                initialText: editorModel.title,
                              )),
                          Container(height: 1, width: 500, color: Colors.grey),
                          Container(
                              alignment: FractionalOffset.topLeft,
                              height: 200 * pt,
                              width: 500,
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: EventCustomTextField(
                                  height: 300,
                                  hintText: "내용을 입력하세요.",
                                  onChanged: (String text) {
                                    editorModel.content = text;
                                  },
                                  initialText: editorModel.content,
                                  maxLine: 15,
                                ),
                              )),
                          Container(height: 1, width: 500, color: Colors.grey),
                          buildBottom(editorModel, context),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            );
          }),
    );
  }

  Column buildBottom(EditorHandler editorModel, BuildContext context) {
    return Column(
      children: [
        buildCheckBox(editorModel),
        buildDropdown(editorModel),
        buildDateSelect(editorModel, context),
        ((articleType == ArticleType.EVENT && editorModel.location == null) ||
                articleType == ArticleType.COMPANION)
            ? buildSelect(editorModel)
            : buildPreview(editorModel),
        SizedBox(height: 20),
        buildCard(editorModel)
      ],
    );
  }

  Widget buildCard(EditorHandler editorModel) {
    return (articleType == ArticleType.EVENT && editorModel.location == null) ||
            (articleType == ArticleType.COMPANION && editorModel.pid == null)
        ? SizedBox()
        : buildContentsCard(editorModel);
  }

  Widget buildPreview(EditorHandler editorModel) {
    return articleType == ArticleType.EVENT
        ? GestureDetector(
            child: MapPreview(location: editorModel.location!),
            onTap: () {
              loadLocation(editorModel);
            },
          )
        : SizedBox();
  }

  Widget buildDropdown(EditorHandler editorModel) {
    if (!editorModel.hasGender && !editorModel.hasAge) {
      return buildRecruitmentNumber(editorModel);
    } else if (!editorModel.hasGender) {
      return Column(
        children: [
          buildRecruitmentNumber(editorModel),
          buildAgeSelection(editorModel),
        ],
      );
    } else if (!editorModel.hasAge) {
      return Column(
        children: [
          buildGenderRecruitment(editorModel),
        ],
      );
    } else {
      return Column(
        children: [
          buildGenderRecruitment(editorModel),
          buildAgeSelection(editorModel),
        ],
      );
    }
  }

  Widget buildGenderRecruitment(EditorHandler editorModel) {
    return Row(
      children: [
        Text("모집인원", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 40,
        ),
        Text("남", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 10 * pt,
        ),
        DropdownButton<int>(
          value: editorModel.maleRecruitNumber,
          items: recruitList.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text("$value"),
              );
            },
          ).toList(),
          onChanged: (int? value) {
            setState(() {
              editorModel.maleRecruitNumber = value == null ? 0 : value;
            });
          },
        ),
        Text("명", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 20 * pt,
        ),
        Text("여", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 10 * pt,
        ),
        DropdownButton<int>(
          value: editorModel.femaleRecruitNumber,
          items: recruitList.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text("$value"),
              );
            },
          ).toList(),
          onChanged: (int? value) {
            setState(() {
              editorModel.femaleRecruitNumber = value == null ? 0 : value;
            });
          },
        ),
        Text("명", style: TextStyle(fontSize: 13 * pt))
      ],
    );
  }

  Widget buildAgeSelection(EditorHandler editorModel) {
    return Row(
      children: [
        Text("나이", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 80,
        ),
        DropdownButton<int>(
          value: editorModel.startAge,
          items: ageList.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text("$value"),
              );
            },
          ).toList(),
          onChanged: (int? value) {
            setState(() {
              editorModel.startAge = value == null ? 0 : value;
            });
          },
        ),
        Text("     ~     "),
        DropdownButton<int>(
          value: editorModel.endAge,
          items: ageList.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text("$value"),
              );
            },
          ).toList(),
          onChanged: (int? value) {
            setState(() {
              editorModel.endAge = value == null ? 0 : value;
            });
          },
        ),
        Text("살", style: TextStyle(fontSize: 13 * pt))
      ],
    );
  }

  Widget buildRecruitmentNumber(EditorHandler editorModel) {
    return Row(children: [
      Text("모집인원", style: TextStyle(fontSize: 13 * pt)),
      SizedBox(
        width: 50,
      ),
      Row(
        children: [
          DropdownButton<int>(
            value: editorModel.recruitNumber,
            items: recruitList.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text("$value"),
                );
              },
            ).toList(),
            onChanged: (int? value) {
              setState(() {
                editorModel.recruitNumber = value == null ? 0 : value;
              });
            },
          ),
          Text("명", style: TextStyle(fontSize: 13 * pt))
        ],
      ),
    ]);
  }

  Row buildCheckBox(EditorHandler editorModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("이벤트 정보",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14 * pt)),
        Row(
          children: [
            Text("성별무관",
                style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 13 * pt)),
            Checkbox(
              value: !editorModel.hasGender,
              onChanged: (bool? onChecked) {
                setState(() {
                  editorModel.hasGender = !editorModel.hasGender;
                  print(editorModel.hasGender);
                });
              },
            ),
            Text("나이무관",
                style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 13 * pt)),
            Checkbox(
              value: !editorModel.hasAge,
              onChanged: (bool? onChecked) {
                setState(() {
                  editorModel.hasAge = !editorModel.hasAge;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  EditorHandler getEditorModel(WriteType writeType) {
    UserInfoHandler userInfoHandler = Provider.of<UserInfoHandler>(context);
    if (writeType == WriteType.POST)
      return EditorHandler(
          location: targetLocation, userInfoHandler: userInfoHandler);
    else {
      //else if (writeType == WriteType.PUT) {
      if (this.widget.data == null) Navigator.pop(context);
      return EditorHandler.edit(
          data: this.widget.data!, userInfoHandler: userInfoHandler);
    }
  }

  TextButton buildSelect(EditorHandler editorModel) {
    return TextButton(
        child: Text(articleType == ArticleType.EVENT ? "지도 선택하기" : "플랜 선택하기",
            style: TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 13 * pt,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          articleType == ArticleType.EVENT
              ? loadLocation(editorModel)
              : loadPlan(editorModel);
        });
  }

  Widget buildDateSelect(EditorHandler editorModel, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('여행 시작일', style: TextStyle(fontSize: 13 * pt)),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text(
                  editorModel.startDate == null
                      ? "시작날짜 선택"
                      : "${editorModel.startDate!.year}.${editorModel.startDate!.month}.${editorModel.startDate!.day}",
                  style: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 13 * pt)),
              onPressed: () async {
                editorModel.setStartDate(await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2030),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light(),
                      child: child ?? SizedBox(),
                    );
                  },
                ));
              },
            ),
          ],
        ),
        Row(
          children: [
            Text('여행 종료일', style: TextStyle(fontSize: 13 * pt)),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text(
                editorModel.endDate == null
                    ? "종료날짜 선택"
                    : "${editorModel.endDate!.year}.${editorModel.endDate!.month}.${editorModel.endDate!.day}",
                style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1), fontSize: 13 * pt),
              ),
              onPressed: () async {
                editorModel.setEndDate(await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2030),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light(),
                      child: child ?? SizedBox(),
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildContentsCard(EditorHandler editorModel) {
    if (articleType == ArticleType.EVENT) {
      GooglePlaceLocation location =
          editorModel.location as GooglePlaceLocation;
      return ContentsCard.fromProps(
          props: new ContentsCardBaseProps(
        hearted: false,
        id: 0,
        preview: location.preview,
        title: location.name,
        explanation: location.description ?? "",
        tags: [],
        margin: const EdgeInsets.symmetric(vertical: 0),
      ));
    }
    // } else {
    //   return ProductCard.fromProps(
    //       props: ProductCardBaseProps(
    //           period: period,
    //           costStart: costStart,
    //           costEnd: costEnd,
    //           isGuide: isGuide,
    //           matchPercent: matchPercent,
    //           tendencies: tendencies,
    //           preview: preview,
    //           title: title,
    //           place: place,
    //           tags: tags,
    //           id: id));
    // }
    return SizedBox();
  }

  Widget buildTypeToggle(EditorHandler editorModel) {
    if (this.widget.data == null)
      return Row(
        children: [
          TBSelectableTextButton(
              titleName: "내 주변 이벤트",
              isChecked: articleType == ArticleType.EVENT,
              onPressed: () {
                setState(() {
                  editorModel.articleType = ArticleType.EVENT;
                  articleType = ArticleType.EVENT;
                });
              }),
          SizedBox(width: 10),
          this.targetLocation == null
              ? TBSelectableTextButton(
                  titleName: "동행찾기",
                  isChecked: articleType == ArticleType.COMPANION,
                  onPressed: () {
                    setState(() {
                      editorModel.articleType = ArticleType.COMPANION;
                      articleType = ArticleType.COMPANION;
                    });
                  })
              : SizedBox(),
        ],
      );

    return Container(
      width: double.maxFinite,
      child: Row(
        children: [
          TBSelectableTextButton(
            titleName: editorModel.articleType == ArticleType.EVENT
                ? "내 주변 이벤트"
                : "동행찾기",
            isChecked: articleType == ArticleType.EVENT,
          ),
        ],
      ),
    );
  }

  Widget buildHeaderBar(EditorHandler editorModel) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          CloseButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            '글 쓰기',
            style: TextStyle(fontSize: 14 * pt, fontWeight: FontWeight.bold),
          )
        ],
      ),
      Row(
        children: [
          this.widget.data != null
              ? SizedBox()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    tbShowDialog(
                        context,
                        TBSimpleDialog(
                            title: "임시 저장하시겠습니까?", body: buildListBodyText()));
                  },
                  child: Text('임시저장',
                      style: TextStyle(
                          fontSize: 13 * pt, fontWeight: FontWeight.bold)),
                ),
          SizedBox(
            width: 10 * pt,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () async {
              bool result = await editorModel.writeArticle();
              if (result)
                Navigator.pop(context, true);
              else
                print("Error");
            },
            child: Text('등록',
                style:
                    TextStyle(fontSize: 13 * pt, fontWeight: FontWeight.bold)),
          )
        ],
      )
    ]);
  }

  Widget buildListBodyText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('임시 저장한 글은',
              style: TextStyle(
                fontSize: 14 * pt,
              )),
          Text('\'내 정보 > 임시 저장한 글\'',
              style: TextStyle(fontSize: 14 * pt, fontWeight: FontWeight.bold)),
          Text('에서 볼 수 있어요.', style: TextStyle(fontSize: 14 * pt))
        ],
      ),
    );
  }

  void loadLocation(EditorHandler editorModel) async {
    Location? location =
        (await Navigator.pushNamed(context, "select_location")) as Location?;

    if (location != null) {
      setState(() {
        editorModel.location = location;
      });
    }
  }

  void loadPlan(EditorHandler editorHandler) async {
    Map<String, dynamic> data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanSelectView(navigator: (Navigate navigate) {}),
      ),
    ) as Map<String, dynamic>;
    print(data["id"] as int);
    editorHandler.pid = data["id"] as int;
  }
}
