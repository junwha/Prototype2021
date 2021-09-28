import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/card_base.dart';
import 'package:prototype2021/theme/heart_button.dart';

class ContentsCardBaseProps extends CardBaseProps {
  final int? rating;
  final double? ratingNumbers;
  final String explanation;
  final Color backgroundColor;
  final EdgeInsets margin;
  final int? heartCount;

  ContentsCardBaseProps({
    this.rating,
    this.ratingNumbers,
    this.backgroundColor = Colors.white,
    this.explanation = "",
    this.heartCount = 3,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    required int id,
    String? preview,
    required String title,
    String? place,
    List<String> tags = const [],
  }) : super(
          id: id,
          preview: preview ?? placeHolder,
          title: title,
          place: place,
          tags: tags,
        );
}

class ContentsCard extends StatelessWidget with CardBase {
  final ContentsCardBaseProps props;

  ContentsCard.fromProps({required this.props});

  @override
  Widget build(BuildContext context) {
    return buildCard(
      itemInfo: buildContentsCardInfo(),
      backgroundColor: props.backgroundColor,
      preview: props.preview,
      heartFor: HeartFor.contentCard,
      userId: 1, // PLEASE INPUT REAL USERID HERE
      dataId: 1, // PLEASE INPUT REAL DATAID HERE
      isHeartSelected:
          false, // PLEASE INPUT REAL isHeartSelected FROM API CALL HERE
    );
  }

  Expanded buildContentsCardInfo() {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildH(2),
          buildTitle(props.title),
          buildH(6),
          buildPlace(props.place),
          buildH(5),
          buildRatings(props.rating, props.ratingNumbers),
          buildH(6 * pt),
          buildExplanation(props.explanation),
          buildH(10 * pt),
          buildTags(props.tags),
        ],
      ),
    );
  }

  Row buildRatings([
    int? rating,
    double? ratingNumbers,
    int? heartCount,
  ]) {
    String ratingText = "";
    if (rating == null) {
      ratingText += "?";
    } else {
      ratingText += rating.toString();
      if (ratingNumbers != null) {
        ratingText += "(${ratingNumbers.toString()})";
      }
    }
    String heartText = "";
    if (heartCount == null) {
      heartText += "?";
    } else {
      heartText += heartCount.toString();
    }
    return Row(
      children: [
        Image.asset(
          "assets/icons/ic_pc_star_small.png",
        ),
        SizedBox(width: 3),
        Text(
          ratingText,
          style: TextStyle(
            color: Color(0xff555555),
            fontSize: 10 * pt,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(width: 12 * pt),
        Image.asset("assets/icons/ic_pc_heart_small.png"),
        SizedBox(width: 3),
        Text(
          heartText,
          style: TextStyle(
            color: Color(0xff555555),
            fontSize: 10 * pt,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  Text buildExplanation(String explanation) {
    return Text(
      explanation,
      maxLines: 2,
      style: TextStyle(
        color: Color(0xff555555),
        fontSize: 10 * pt,
        fontFamily: 'Roboto',
      ),
    );
  }
}
