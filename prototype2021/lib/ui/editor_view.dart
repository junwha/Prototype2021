import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/editor_model.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/theme/checkbox_row.dart';
import 'package:prototype2021/theme/datetimepicker_column.dart';
import 'package:prototype2021/theme/checkbox_widget.dart';
import 'package:prototype2021/theme/map/map_preview.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/theme/textfieldform.dart';
import 'package:provider/provider.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  List<bool> articleType = [
    true,
    false
  ]; //initialize state as 내 주변 이벤트 [내 주변 이벤트, 동행찾기]
  DateTime? chosenDateTime1;
  DateTime? chosenDateTime2;
  TextEditingController controlofoto = TextEditingController();
  Location? targetLoction;

  @override
  Widget build(BuildContext context) {
    final Map<String, Object>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>?;
    if (args != null && args.containsKey("location")) {
      targetLoction = args["location"] as Location;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: ChangeNotifierProvider(
            create: (context) => EditorModel(),
            child: Consumer(builder: (context, EditorModel editorModel, child) {
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
                        child: TextFieldForm(
                            hintText: "제목",
                            onChanged: (String text) {
                              editorModel.title = text;
                              editorModel.printChanged();
                            })),
                    Container(height: 1, width: 500, color: Colors.grey),
                    Container(
                        alignment: FractionalOffset.topLeft,
                        height: 200 * pt,
                        width: 500,
                        color: Colors.white,
                        child: TextFieldForm(
                          hintText: "내용을 입력하세요.",
                          onChanged: (String text) {
                            editorModel.content = text;
                            editorModel.printChanged();
                          },
                        )),
                    Container(height: 1, width: 500, color: Colors.grey),
                    Column(
                      children: [
                        CheckboxRow(
                            value1: editorModel.hasGender,
                            onChanged1: (bool? value) {
                              setState(() {
                                editorModel.hasGender = value ?? false;
                              });
                              editorModel.printChanged();
                            },
                            value2: editorModel.hasAge,
                            onChanged2: (bool? value) {
                              setState(() {
                                editorModel.hasAge = value ?? false;
                              });
                              editorModel.printChanged();
                            }),
                        CheckBoxWidget(
                            editorModel.hasGender, editorModel.hasAge,
                            (recruitNumber, maleRecruitNumber,
                                femaleRecruitNumber, startAge, endAge) {
                          editorModel.recruitNumber = recruitNumber;
                          editorModel.maleRecruitNumber = maleRecruitNumber;
                          editorModel.femaleRecruitNumber = femaleRecruitNumber;
                          editorModel.startAge = startAge;
                          editorModel.endAge = endAge;
                          editorModel.printChanged();
                        }),
                        //   DateTimePickerCol(chosenDateTime1) TODO: implement DateTimePicker
                        targetLoction == null
                            ? TextButton(
                                child: Text("지도 선택하기"),
                                onPressed: () {
                                  loadLocation();
                                })
                            : GestureDetector(
                                child: MapPreview(location: targetLoction!),
                                onTap: () {
                                  loadLocation();
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildTypeToggle(EditorModel editorModel) {
    return Row(
      children: [
        SelectableTextButton(
            titleName: "내 주변 이벤트",
            isChecked: articleType[0],
            onPressed: () {
              setState(() {
                editorModel.articleType = EVENT;
                articleType[1] = false;
                articleType[0] = true;
              });
            }),
        SizedBox(width: 10),
        SelectableTextButton(
            titleName: "동행찾기",
            isChecked: articleType[1],
            onPressed: () {
              setState(() {
                editorModel.articleType = COMPANION;
                articleType[1] = true;
                articleType[0] = false;
              });
            })
      ],
    );
  }

  Widget buildHeaderBar(EditorModel editorModel) {
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
          PopButton(
            buttonTitle: "임시저장",
            listBody: ListBody(
              children: [
                Container(
                  width: 291 * pt,
                  height: 250 * pt,
                  child: buildListBodyText(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10 * pt,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              editorModel.writeArticle();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("임시 저장하시겠습니까?", style: TextStyle(fontSize: 17 * pt)),
        SizedBox(
          height: 15,
        ),
        Text('임시 저장한 글은',
            style: TextStyle(
              fontSize: 14 * pt,
            )),
        Text('\'내 정보 > 임시 저장한 글\'',
            style: TextStyle(fontSize: 14 * pt, fontWeight: FontWeight.bold)),
        Text('에서 볼 수 있어요.', style: TextStyle(fontSize: 14 * pt))
      ],
    );
  }

  void loadLocation() async {
    Location? location =
        (await Navigator.pushNamed(context, "select_location")) as Location?;

    if (location != null) {
      setState(() {
        this.targetLoction = location;
        print(location.latLng);
      });
    }
  }
}
