import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/handler/event/event_article_handler.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/model/board/plan/plan_dto.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/model/google_place/place_data.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/event/editor/editor_view.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';
import 'package:provider/provider.dart';

class EventDetailView extends StatefulWidget {
  final int id;
  EventArticleHandler eventArticleModel;
  ArticleType articleType;

  EventDetailView(this.id, this.eventArticleModel, this.articleType);

  @override
  _EventDetailViewState createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  @override
  void initState() {
    super.initState();
    UserInfoHandler userInfoHandler =
        Provider.of<UserInfoHandler>(context, listen: false);
    this.widget.eventArticleModel.loadDetail(
          this.widget.id,
          this.widget.articleType,
          userInfoHandler.token,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
          builder: () {
            return ChangeNotifierProvider.value(
              value: this.widget.eventArticleModel,
              child: Consumer(builder:
                  (context, EventArticleHandler eventArticleModel, child) {
                return SingleChildScrollView(
                  child: eventArticleModel.detailData == null
                      ? Text("Loading ...")
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      buildProfile(eventArticleModel),
                                      bulidPopupMenuButton(eventArticleModel)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  bulidContent(eventArticleModel),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  buildDetail(eventArticleModel),
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
            );
          }),
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

  Row buildProfile(EventArticleHandler eventArticleModel) {
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
              eventArticleModel.detailData!.userData.nickname,
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

  Column buildDetail(EventArticleHandler eventArticleModel) {
    return Column(
      children: [
        buildBottomCard(eventArticleModel),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/person_half_blue.png'),
                  SizedBox(
                    width: 8,
                  ),
                  Text('남 ${eventArticleModel.detailData!.male}명'),
                  SizedBox(
                    width: 13,
                  ),
                  Image.asset('assets/icons/person_half_red.png'),
                  SizedBox(width: 8),
                  Text("여 ${eventArticleModel.detailData!.female}명")
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/icons/check_outlined.png'),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                      '${eventArticleModel.detailData!.minAge}~${eventArticleModel.detailData!.maxAge} 살')
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image.asset('assets/icons/calender_outlined.png'),
            SizedBox(
              width: 8,
            ),
            Text("${eventArticleModel.detailData!.period.end}")
          ],
        ),
      ],
    );
  }

  Widget buildBottomCard(EventArticleHandler handler) {
    if (handler.placeData != null) {
      return ContentsCard.fromProps(
          props: ContentsCardBaseProps(
        hearted: false,
        id: -1,
        title: handler.placeData!.name,
      ));
    } else if (handler.planDetail != null) {
      return ProductCard.fromProps(
          props: ProductCardBaseProps(
        period: handler.planDetail!.period,
        costStart: handler.planDetail!.expense,
        costEnd: handler.planDetail!.expense,
        isGuide: false,
        tendencies: [],
        preview: handler.planDetail!.photo,
        title: handler.planDetail!.title,
        tags: handler.planDetail!.types,
        id: handler.planDetail!.id,
        hearted: handler.planDetail!.hearted ?? false,
      ));
    }
    return SizedBox();
  }

  PopupMenuButton bulidPopupMenuButton(EventArticleHandler articleModel) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("글 삭제하기"),
          value: "DEL",
        ),
        PopupMenuItem(
          child: Text("정보 수정하기"),
          value: "EDIT",
        )
      ],
      onSelected: (dynamic value) async {
        if (value == "DEL") {
          if (await articleModel.deleteArticle(
              this.widget.id, this.widget.articleType)) {
            Navigator.pop(context);
          }
        } else if (value == "EDIT") {
          try {
            bool result = await Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return EditorView.edit(articleModel.detailData!);
            })) as bool;
            if (result) {
              UserInfoHandler userInfoHandler =
                  Provider.of<UserInfoHandler>(context, listen: false);
              await articleModel.loadDetail(
                this.widget.id,
                this.widget.articleType,
                userInfoHandler.token,
              );
            }
          } catch (e) {}
        }
      },
    );
  }

  Widget bulidContent(EventArticleHandler eventArticleModel) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventArticleModel.detailData!.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            eventArticleModel.detailData!.body,
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(85, 85, 85, 1)),
          ),
        ],
      ),
    );
  }
}
