import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ServiceList()));
}

class ServiceList extends StatefulWidget {
  @override
  ServiceListState createState() => ServiceListState();
}

class ServiceListState extends State<ServiceList> {
  List<bool> isChecked = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ServiceList"),
      ),
      body: _serviceListView(),
    );
  }

  Widget _serviceListView() {
    var listview = Container(
      height: 400,
      width: 500,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 1,
              child: Container(
                height: 150,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "선택 서비스",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        !(isChecked[0] ||
                                isChecked[1] ||
                                isChecked[2] ||
                                isChecked[3] ||
                                isChecked[4])
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Text("현재 기본 서비스만 이용중 입니다")],
                              )
                            : SizedBox(height: 0),
                        isChecked[0] ? Text("우선 탑승 및 하차") : SizedBox(height: 0),
                        isChecked[1] ? Text("고 품질 좌석") : SizedBox(height: 0),
                        isChecked[2] ? Text("공항 라운지 이동") : SizedBox(height: 0),
                        isChecked[3] ? Text("기내식") : SizedBox(height: 0),
                        isChecked[4] ? Text("수하물 용량 추가") : SizedBox(height: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  serviceflatbutton("+ 우선 탑승 및 하차", 0),
                  SizedBox(
                    width: 10,
                  ),
                  serviceflatbutton("+ 고 품질 좌석", 1),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  serviceflatbutton("+ 공항 라운지 이용", 2),
                  SizedBox(
                    width: 10,
                  ),
                  serviceflatbutton("+ 기내식", 3),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  serviceflatbutton("+ 수하물 용량 추가", 4),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("가성비 별점"),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
    return listview;
  }

  FlatButton serviceflatbutton(
    String text,
    int i,
  ) {
    return FlatButton(
      child: Text(text),
      color: isChecked[i] ? Colors.blue[200] : Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50)),
      onPressed: () {
        setState(() {
          isChecked[i] = isChecked[i] ? false : true;
        });
      },
    );
  }
}
