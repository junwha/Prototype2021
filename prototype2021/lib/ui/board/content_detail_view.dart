import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/model/contents_dto/content_detail.dart';
import 'package:prototype2021/model/event/event_article_model.dart';
import 'package:prototype2021/model/user_info_model.dart';
import 'package:prototype2021/theme/center_notice.dart';
import 'package:prototype2021/theme/loading.dart';
import 'package:prototype2021/ui/event/event_main_view.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/ui/event/editor_view.dart';
import 'package:prototype2021/ui/event/event_detail_view.dart';
import 'package:prototype2021/theme/cards/timer_card.dart';
import 'package:prototype2021/settings/constants.dart';

class ContentDetailView extends StatefulWidget {
  final int id;
  ContentDetailView({required this.id});

  @override
  ContentDetailViewState createState() => ContentDetailViewState();
}

class ContentDetailViewState extends State<ContentDetailView>
    with ContentsLoader {
  double imageIndex = 0;
  bool isAllList = false;
  bool onError = false;

  ContentsDetail? props;
  void setProps(ContentsDetail _props) => setState(() {
        props = _props;
      });
  void setOnError(bool _onError) => setState(() {
        onError = _onError;
      });

  Future<void> fetchDetail() async {
    try {
      UserInfoModel model = Provider.of<UserInfoModel>(context, listen: false);
      setProps(await getContentDetail(widget.id, model.token!));
      setOnError(false);
    } catch (error) {
      print(error);
      setOnError(true);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    if (onError) {
      return Container(
        child: CenterNotice(
          text: "컨텐츠를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요",
          actionText: "다시 시도",
          onActionPressed: fetchDetail,
        ),
        decoration: const BoxDecoration(color: Colors.white),
      );
    }
    if (props == null) {
      return Container(
        child: LoadingIndicator(),
        decoration: new BoxDecoration(color: Colors.white),
      );
    }
    return buildPage();
  }

  Scaffold buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
            child: ChangeNotifierProvider(
          create: (context) => EventArticleModel.main(),
          child: Consumer(
              builder: (context, EventArticleModel eventArticleModel, child) {
            return Column(
              children: [
                buildHeadSection(),
                buildLineArea(),
                buildTextArea(),
                buildLineArea(),
                buildPriceArea(),
                buildLineArea(),
                buildTimeArea(),
                buildLineArea(),
                buildLocationArea(),
                buildLineArea(),
                buildEventArea(eventArticleModel),
                buildEventArticles(eventArticleModel),
                buildEventNavigatorButton(),
              ],
            );
          }),
        )),
      ),
    );
  }

  Padding buildHeadSection() {
    String ratingText = "";
    if (props!.rating != null) {
      ratingText += props!.rating.toString();
      if (props!.reviewNo != null) {
        ratingText += "(${props!.reviewNo.toString()})";
      }
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                props!.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/ic_main_heart_default.png'))
            ],
          ),
          Text(
            props!.address ?? "",
            style: TextStyle(
              color: Color(0xff707070),
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Image.asset('assets/icons/ic_pc_star_big.png'),
              SizedBox(
                width: 5,
              ),
              Text(
                ratingText,
                style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 15,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          buildTags([]), // API에서 태그가 넘어오는게 아닌데 어떻게 처리해야 좋을까요ㅜㅜ
          SizedBox(
            height: 18,
          ),
          buildImageArea(),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  TextButton buildEventNavigatorButton() {
    return TextButton(
      child: Container(
          height: 35 * pt,
          width: 280 * pt,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Text(
            "이벤트 게시판에서 더보기 ->",
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ))),
      onPressed: () {
        if (!isAllList) {
          setState(() {
            isAllList = true;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventMainView()),
          );
          // TODO: next page
        }
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/ic_hamburger_menu.png'))
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("컨텐츠 정보",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xff000000),
              fontSize: 17,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )));
  }

  Container buildTag(String tagName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
      child: Text(
        tagName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: const Color(0xff707070),
        ),
      ),
    );
  }

  Row buildTags(List<String> tags) {
    return Row(children: tags.map<Container>((tag) => buildTag(tag)).toList());
  }

  Stack buildImageArea() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (i, reason) {
                setState(() {
                  imageIndex = i.toDouble();
                });
              },
              height: 200,
              viewportFraction: 1,
            ),
            items: props!.photo.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/icons/imagebar2.png",
                      fit: BoxFit.cover,
                      scale: 20,
                    ),
                  );
                },
              );
            }).toList()),
        DotsIndicator(
          dotsCount: props!.photo.length,
          position: imageIndex,
        )
      ],
    );
  }

  Container buildLineArea() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffe8e8e8),
    );
  }

  Padding buildTextArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Text(
            props!.title,
            style: TextStyle(
              height: 1.3,
              color: Color(0xff010101),
              fontSize: 21,
              letterSpacing: 1.5,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            props!.overview,
            style: TextStyle(
              color: Colors.black,
              height: 1.5,
              fontSize: 15,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPriceArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("이용료",
                  style: const TextStyle(
                      color: const Color(0xff080808),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.5,
                      fontSize: 17.0)),
              SizedBox(
                width: 4,
              ),
              Text(
                "유료",
                style: const TextStyle(
                    color: const Color(0xff004af7),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.5,
                    fontSize: 17.0),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
              '성인 20유로 (홈페이지 예약 시, 19유로) \n 만 11세 이하 무료\n사전 예매 가능 (홈페이지)\n00 카드 소지 시 30% 할인',
              style: TextStyle(
                color: Color(0xff707070),
                height: 1.9,
                fontSize: 15,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left),
        ],
      ),
    );
  }

  Padding buildTimeArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('영업 시간, 휴무일',
                style: TextStyle(
                    color: Color(0xff080808),
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5),
                textAlign: TextAlign.left),
            SizedBox(
              height: 3,
            ),
            Text(
                "일 09:00 - 21:00\n월 휴무\n화 09:00 - 21:00\n수 09:00 - 21:00\n목 09:00 - 21:00\n금 09:00 - 21:00\n토 09:00 - 21:00\n",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  height: 1.9,
                  color: Color(0xff707070),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left)
          ],
        ),
      ),
    );
  }

  Padding buildLocationArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '위치 및 가는 법',
            style: TextStyle(
              color: Color(0xff080808),
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Image.asset('assets/icons/mapimage.png'),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: new TextSpan(children: [
            new TextSpan(
                text: "주소 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff040404),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "Amusementstreet 1, 1071 XX Sanghai\n",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "가는 방법 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "장궈이 역에서 도보 5분 거리\n",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "전화 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "+31206747000\n",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "홈페이지 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "https://portal.unist.ac.kr/irj/portal",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
          ]))
        ],
      ),
    );
  }

  Padding buildEventArea(EventArticleModel articleModel) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '이 장소 같이 가요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/icons/editor.png",
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () async {
                      try {
                        bool result = await Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                          return EditorView();
                        })) as bool;
                        if (result) {
                          articleModel.loadTopArticles();
                          articleModel.loadArticles();
                        }
                      } catch (e) {}
                    },
                  ),
                  Text(
                    '글 쓰기',
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEventArticles(EventArticleModel eventArticleModel) {
    if (eventArticleModel.isTopEventArticleLoading) return Text("Loading ...");
    return Column(
      children: eventArticleModel.topEventArticleList
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                    return EventDetailView(
                        e.id, eventArticleModel, eventArticleModel.articleType);
                  }),
                );
              },
              child: TimerCard(
                title: e.title,
                description: e.summary,
                due: e.period.end,
                onEnd: () {
                  eventArticleModel.loadTopArticles();
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
