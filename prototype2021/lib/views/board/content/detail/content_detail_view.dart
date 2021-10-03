import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prototype2021/data/dto/contents/content_detail.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/model/event/event_article_model.dart';
import 'package:prototype2021/model/user_info_model.dart';
import 'package:prototype2021/views/board/content/detail/mixin/body.dart';
import 'package:prototype2021/views/board/content/detail/mixin/body_event.dart';
import 'package:prototype2021/views/board/content/detail/mixin/header.dart';
import 'package:prototype2021/views/board/content/detail/mixin/helpers.dart';
import 'package:prototype2021/theme/center_notice.dart';
import 'package:prototype2021/theme/loading.dart';
import 'package:prototype2021/views/event/main/event_main_view.dart';
import 'package:provider/provider.dart';

int _testCid = 128022;

class ContentDetailView extends StatefulWidget {
  final int id;
  ContentDetailView({required this.id});

  @override
  ContentDetailViewState createState() => ContentDetailViewState();
}

class ContentDetailViewState extends State<ContentDetailView>
    with
        ContentsLoader,
        ContentDetailViewHeaderMixin,
        ContentsDetailViewBodyMixin,
        ContentDetailViewEventMixin,
        ContentDetailViewHelpers {
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
      return buildError();
    }
    if (props == null) {
      return Container(
        child: LoadingIndicator(),
        decoration: new BoxDecoration(color: Colors.white),
      );
    }
    return buildPage();
  }

  Container buildError() {
    return Container(
      child: CenterNotice(
        text: "컨텐츠를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요",
        actionText: "다시 시도",
        onActionPressed: fetchDetail,
      ),
      decoration: const BoxDecoration(color: Colors.white),
    );
  }

  Scaffold buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
            child: ChangeNotifierProvider(
          create: (context) => EventArticleModel.main(),
          child: Consumer(
              builder: (context, EventArticleModel eventArticleModel, child) {
            void onImageChanged(int i, CarouselPageChangedReason reason) {
              setState(() {
                imageIndex = i.toDouble();
              });
            }

            void onEventNavButtonPressed() {
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
            }

            if (props == null) {
              return SizedBox();
            }

            return Column(
              children: [
                buildHeadSection(
                  context,
                  onPageChanged: onImageChanged,
                  imageIndex: imageIndex,
                  props: props!,
                ),
                buildLineArea(),
                buildTextArea(props!),
                buildLineArea(),
                buildPriceArea(props!),
                buildLineArea(),
                buildTimeArea(props!),
                buildLineArea(),
                buildLocationArea(props!),
                buildLineArea(),
                // 이벤트와 관련한 위젯을 theme/board/contents_detail/body_event.dart에 옮겨두었습니다
                buildEventArea(
                  context,
                  eventArticleModel,
                ),
                buildEventArticles(
                  context,
                  eventArticleModel,
                ),
                buildEventNavigatorButton(
                  context,
                  onPressed: onEventNavButtonPressed,
                ),
              ],
            );
          }),
        )),
      ),
    );
  }
}
