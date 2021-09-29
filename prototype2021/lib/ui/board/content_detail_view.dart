import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/model/contents_dto/content_detail.dart';
import 'package:prototype2021/model/event/event_article_model.dart';
import 'package:prototype2021/model/user_info_model.dart';
import 'package:prototype2021/theme/center_notice.dart';
import 'package:prototype2021/theme/heart_button.dart';
import 'package:prototype2021/theme/loading.dart';
import 'package:prototype2021/ui/event/event_main_view.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/ui/event/editor_view.dart';
import 'package:prototype2021/ui/event/event_detail_view.dart';
import 'package:prototype2021/theme/cards/timer_card.dart';
import 'package:prototype2021/settings/constants.dart';

int _testCid = 128022;

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
    UserInfoModel model = Provider.of<UserInfoModel>(context, listen: false);
    String ratingText = "";
    if (props!.reviewNo != null) {
      ratingText += props!.reviewNo.toString();
      if (props!.rating != null) {
        ratingText += " (${props!.rating.toString()})";
      }
    }
    if (ratingText.length == 0) {
      ratingText += "?";
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  props!.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                flex: 2,
              ),
              Flexible(
                child: HeartButton(
                  isHeartSelected: props?.hearted ?? false,
                  heartFor: HeartFor.contentCard,
                  dataId: props?.id ?? -1,
                  userId: model.userId ?? -1,
                ),
                flex: 1,
              ),
            ],
          ),
          Text(
            props!.detailInfo.place ??
                props!.detailInfo.eventplace ??
                props!.detailInfo.placeinfo ??
                props!.address ??
                "",
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
          buildTags([]), // API에서 태그가 넘어오는게 아니라 어떻게 처리해야 할지가 난감합니다
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

  Widget buildImageArea() {
    return props!.photo.length == 0
        ? SizedBox()
        : Stack(
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
                          child: Image.network(
                            url,
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

  /// 리스트에 있는 아이템 중에서 null
  T? pickNonNull<T>(List<T?> items) {
    T? result;
    items.forEach((item) {
      if (item != null) {
        result = item;
      }
    });
    return result;
  }

  String handlePriceData() {
    List<List<String>> useFees = [];
    String? usefee = pickNonNull([
      props?.detailInfo.usefee,
      props?.detailInfo.usetimefestival == null
          ? null
          : props?.detailInfo.usetimefestival.toString(),
      props?.detailInfo.usefeeleports,
    ]);
    if (usefee != null) {
      print(usefee is String);
      useFees.add(['이용요금', usefee]);
    }
    String? discountInfo = pickNonNull([
      props?.detailInfo.discountInfo,
      props?.detailInfo.discountInfofood,
      props?.detailInfo.discountinfofestival,
    ]);
    if (discountInfo != null) {
      useFees.add(['할인 정보', discountInfo]);
    }
    String? refundRegulation = pickNonNull([
      props?.detailInfo.refundregulation,
    ]);
    if (refundRegulation != null) {
      useFees.add(['환불 정책', refundRegulation]);
    }
    String? parking = pickNonNull([
      props?.detailInfo.parking,
      props?.detailInfo.parkingculture,
      props?.detailInfo.parkingleports,
      props?.detailInfo.parkingshopping,
      props?.detailInfo.parkingfood,
    ]);
    if (parking != null) {
      useFees.add(['주차 시설', parking]);
    }
    String? parkingFee = pickNonNull([
      props?.detailInfo.parkingfee,
      props?.detailInfo.parkingfeeculture,
      props?.detailInfo.parkingfeeleports,
    ]);
    if (parkingFee != null) {
      useFees.add(['주차 요금', parkingFee]);
    }
    if (props?.detailInfo.saleitem != null) {
      useFees.add(['판매 품목', props!.detailInfo.saleitem!]);
      if (props?.detailInfo.saleitemcost != null) {
        useFees.add(['품목별 가격', props!.detailInfo.saleitemcost!]);
      }
    }

    return useFees.fold<String>("", (acc, cur) {
      return acc + cur[0] + " " + cur[1] + '\n';
    });
  }

  Widget buildPriceArea() {
    String priceData = handlePriceData();
    if (priceData.length == 0) {
      return SizedBox();
    }
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
              // Text(
              //   "유료",
              //   style: const TextStyle(
              //       color: const Color(0xff004af7),
              //       fontWeight: FontWeight.w700,
              //       fontFamily: "Roboto",
              //       fontStyle: FontStyle.normal,
              //       letterSpacing: 1.5,
              //       fontSize: 17.0),
              // )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            priceData,
            style: TextStyle(
              color: Color(0xff707070),
              height: 1.9,
              fontSize: 15,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  String handleTimeData() {
    List<List<String>> useTimes = [];
    String? openDate = pickNonNull([
      props?.detailInfo.opendate,
      props?.detailInfo.opendatefood,
      props?.detailInfo.opendateshopping,
    ]);
    if (openDate != null) {
      useTimes.add(['오픈 일자', openDate]);
    }
    // Need close date
    String? openPeriod = pickNonNull([
      props?.detailInfo.openpriod,
    ]);
    if (openPeriod != null) {
      useTimes.add(['오픈 기간', openPeriod]);
    }
    String? openTime = pickNonNull([
      props?.detailInfo.opentime,
      props?.detailInfo.opentimefood,
    ]);
    if (openTime != null) {
      useTimes.add(['영업시간', openTime]);
    }
    String? restDate = pickNonNull([
      props?.detailInfo.restdate,
      props?.detailInfo.restdateculture,
      props?.detailInfo.restdateleports,
      props?.detailInfo.restdateshopping,
    ]);
    if (restDate != null) {
      useTimes.add(['쉬는날', restDate]);
    }
    String? useSeason = pickNonNull([
      props?.detailInfo.useseason,
    ]);
    if (useSeason != null) {
      useTimes.add(['이용시즌', useSeason]);
    }
    String? useTime = pickNonNull([
      props?.detailInfo.usetime,
      props?.detailInfo.usetimeculture,
      props?.detailInfo.usetimeleports,
      // props?.detailInfo.usetimefestival // 이게 왜 요금인지 모르겠음. 하여간 정부 API는 ㄹㅇ 이상함
    ]);
    if (useTime != null) {
      useTimes.add(['이용시간', useTime]);
    }
    String? spendTime = pickNonNull([
      props?.detailInfo.spendtime,
    ]);
    if (spendTime != null) {
      useTimes.add(['관람 소요시간', spendTime]);
    }
    String? playtime = pickNonNull([
      props?.detailInfo.playtime,
    ]);
    if (playtime != null) {
      useTimes.add(["공연시간", playtime]);
    }
    if (props?.detailInfo.checkintime != null) {
      useTimes.add(['입실 시간', props!.detailInfo.checkintime!]);
    }
    if (props?.detailInfo.checkouttime != null) {
      useTimes.add(['퇴실 시간', props!.detailInfo.checkouttime!]);
    }
    return useTimes.fold<String>("", (acc, cur) {
      return acc + cur[0] + " " + cur[1] + "\n";
    });
  }

  Widget buildTimeArea() {
    String timeData = handleTimeData();
    if (timeData.length == 0) {
      return SizedBox();
    }
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
              timeData,
              style: TextStyle(
                fontFamily: 'Roboto',
                height: 1.9,
                color: Color(0xff707070),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  List<TextSpan> buildKeyValueSpan(String key, String value) {
    key = key + " ";
    return [
      TextSpan(
        text: key,
        style: const TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xff040404),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          height: 2,
        ),
      ),
      TextSpan(
        text: value + "\n",
        style: const TextStyle(
            fontFamily: 'Roboto',
            color: Color(0x80080808),
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            height: 2),
      ),
    ];
  }

  Padding buildLocationArea() {
    // API에 가는 방법에 대한 데이터가 없어서 이게 빠져있습니다
    List<TextSpan> locationInfo = [];
    if (props?.address != null) {
      locationInfo.addAll(buildKeyValueSpan('주소', props!.address!));
    }
    if (props?.tel != null) {
      locationInfo.addAll(buildKeyValueSpan("전화", props!.tel!));
    }
    if (props?.homePage != null) {
      locationInfo.addAll(buildKeyValueSpan("홈페이지", props!.homePage!));
    }
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
          // ** NEED REAL MAP HERE **
          Image.asset('assets/icons/mapimage.png'),
          SizedBox(
            height: 10,
          ),
          RichText(text: new TextSpan(children: locationInfo))
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
