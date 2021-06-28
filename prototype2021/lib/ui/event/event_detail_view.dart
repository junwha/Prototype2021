import 'package:flutter/material.dart';
import 'package:prototype2021/model/event_detail_model.dart';
import 'package:provider/provider.dart';

class EventDetailView extends StatefulWidget {
  final int id;
  const EventDetailView(this.id);

  @override
  _EventDetailViewState createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ChangeNotifierProvider(
        create: (context) => EventDetailModel(this.widget.id),
        child: Consumer(
            builder: (context, EventDetailModel eventDetailModel, child) {
          return SingleChildScrollView(
            child: eventDetailModel.isLoading
                ? Text("Loading ...")
                : Column(
                    children: [
                      buildTopNotice(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildProfile(eventDetailModel),
                                bulidPopupMenuButton()
                              ],
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            bulidContent(eventDetailModel),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            buildDetail(eventDetailModel),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Color.fromRGBO(232, 232, 232, 1),
                      )
                    ],
                  ),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
      shadowColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Row buildProfile(EventDetailModel eventDetailModel) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(153, 153, 153, 1),
              borderRadius: BorderRadius.all(Radius.circular(13.0))),
          height: 47,
          width: 47,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventDetailModel.data.userData.nickname,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(85, 85, 85, 1)),
            ),
            Text(
              "2020.02.28 03:09",
              style:
                  TextStyle(fontSize: 10, color: Color.fromRGBO(85, 85, 85, 1)),
            )
          ],
        )
      ],
    );
  }

  Column buildDetail(EventDetailModel eventDetailModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/person_half_blue.png'),
                  SizedBox(
                    width: 8,
                  ),
                  Text('남 ${eventDetailModel.data.male}명'),
                  SizedBox(
                    width: 13,
                  ),
                  Image.asset('assets/icons/person_half_red.png'),
                  SizedBox(width: 8),
                  Text("여 ${eventDetailModel.data.female}2명")
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/icons/check_outlined.png'),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                      '${eventDetailModel.data.minAge}~${eventDetailModel.data.maxAge} 살')
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Image.asset('assets/icons/calender_outlined.png'),
            SizedBox(
              width: 8,
            ),
            Text("${eventDetailModel.data.period.end}")
          ],
        )
      ],
    );
  }

  PopupMenuButton bulidPopupMenuButton() {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("글 삭제하기"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("정보 수정하기"),
                value: 2,
              )
            ]);
  }

  Column bulidContent(EventDetailModel eventDetailModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventDetailModel.data.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          eventDetailModel.data.body,
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(85, 85, 85, 1)),
        ),
      ],
    );
  }

  Container buildTopNotice() {
    return Container(
      child: Center(
          child: Row(
        children: [
          Image.asset("assets/icons/message_outlined.png"),
          SizedBox(
            width: 7,
          ),
          Text(
            "울산광역시 불꽃축제(2021-01-04~2021-02-03",
            style: TextStyle(fontSize: 17),
          ),
        ],
      )),
      color: Color.fromRGBO(219, 219, 219, 1),
      width: double.infinity,
      height: 23,
    );
  }
}
