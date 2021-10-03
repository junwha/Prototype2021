import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/data/dto/contents/content_detail.dart';
import 'package:prototype2021/model/user_info_model.dart';
import 'package:prototype2021/theme/heart_button.dart';
import 'package:provider/provider.dart';

/// 제목부터 이미지 슬라이드를 담당하는 믹스인
mixin ContentDetailViewHeaderMixin {
  /// 제목부터 이미지 슬라이드까지의 UI를 렌더링합니다
  Padding buildHeadSection(
    BuildContext context, {
    required ContentsDetail props,
    required Function(int, CarouselPageChangedReason) onPageChanged,
    required double imageIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(context, props),
          buildAddress(props),
          SizedBox(height: 8),
          buildRatings(props),
          SizedBox(height: 6),
          buildTags([]), // API에서 태그가 넘어오는게 아니라 어떻게 처리해야 할지가 난감합니다
          SizedBox(height: 18),
          buildImageArea(
            props,
            onPageChanged: onPageChanged,
            imageIndex: imageIndex,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  /// 제목과 하트 버튼을 렌더링합니다
  Widget buildTitle(BuildContext context, ContentsDetail props) {
    UserInfoModel model = Provider.of<UserInfoModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            props.title,
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
            isHeartSelected: props.hearted,
            heartFor: HeartFor.contentCard,
            dataId: props.id,
            userId: model.userId ?? -1,
            token: model.token ?? "",
          ),
          flex: 1,
        ),
      ],
    );
  }

  String _handleAddress(ContentsDetail props) {
    return props.detailInfo.place ??
        props.detailInfo.eventplace ??
        props.detailInfo.placeinfo ??
        props.address ??
        "";
  }

  /// 제목 아래에 들어가는 주소부분이 있다면 렌더링합니다
  Text buildAddress(ContentsDetail props) {
    return Text(
      _handleAddress(props),
      style: TextStyle(
        color: Color(0xff707070),
        fontSize: 13,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _handleRatingData(ContentsDetail props) {
    String ratingText = "";
    if (props.reviewNo != null) {
      ratingText += props.reviewNo.toString();
      if (props.rating != null) {
        ratingText += " (${props.rating.toString()})";
      }
    }
    if (ratingText.length == 0) {
      ratingText += "?";
    }
    return ratingText;
  }

  /// 별점 정보를 렌더링합니다
  Row buildRatings(ContentsDetail props) {
    return Row(
      children: [
        Image.asset('assets/icons/ic_pc_star_big.png'),
        SizedBox(
          width: 5,
        ),
        Text(
          _handleRatingData(props),
          style: TextStyle(
            color: Color(0xff707070),
            fontSize: 15,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  /// 이름이나 주소 아래 들어가는 태그들이 있다면 렌더링 합니다
  Row buildTags(List<String> tags) {
    return Row(children: tags.map<Container>((tag) => buildTag(tag)).toList());
  }

  /// buildTags의 헬퍼 메서드로 쓰입니다. 직접 사용하지 말아주세요
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

  List<String> _handleImageData(ContentsDetail props) {
    List<String> allPhotos = [];
    if (props.thumbnail != null) {
      allPhotos.add(props.thumbnail!);
    }
    allPhotos.addAll(props.photo);
    return allPhotos;
  }

  /// 제목, 주소, 별점 등의 아래에 표시되는 이미지를 렌더링합니다
  Widget buildImageArea(
    ContentsDetail props, {
    required void Function(int, CarouselPageChangedReason) onPageChanged,
    required double imageIndex,
  }) {
    List<String> photos = _handleImageData(props);
    if (photos.length == 0) {
      return SizedBox();
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: onPageChanged,
            height: 200,
            viewportFraction: 1,
          ),
          items: photos.map((url) {
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
          }).toList(),
        ),
        DotsIndicator(
          dotsCount: props.photo.length,
          position: imageIndex,
        )
      ],
    );
  }

  /// 현재 화면의 앱바를 렌더링합니다
  AppBar buildAppBar(BuildContext context) {
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
}
