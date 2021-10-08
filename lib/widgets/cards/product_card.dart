import 'package:flutter/material.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/cards/props/card_base.dart';
import 'package:prototype2021/widgets/buttons/heart_button.dart';
import 'package:prototype2021/widgets/shapes/tag.dart';
import 'package:provider/provider.dart';

class ProductCardBaseProps extends CardBaseProps {
  final DateTimeRange period;
  final int costStart;
  final int costEnd;
  final bool isGuide;
  final double? matchPercent;
  final List<String> tendencies;
  final bool hearted;

  ProductCardBaseProps({
    required this.period,
    required this.costStart,
    required this.costEnd,
    required this.isGuide,
    required this.tendencies,
    required this.hearted,
    required String title,
    required List<String> tags,
    required int id,
    this.matchPercent,
    String? preview,
    String? place,
  }) : super(
          id: id,
          preview: preview,
          title: title,
          place: place,
          tags: tags,
        );
}

class ProductCard extends StatelessWidget with CardBase {
  final ProductCardBaseProps props;
  ProductCard.fromProps({
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    UserInfoHandler handler = Provider.of<UserInfoHandler>(context);
    return buildCard(
      itemInfo: buildProductCardInfo(),
      backgroundColor: Colors.white,
      preview: props.preview,
      heartFor: HeartFor.planCard,
      userId: handler.userId ?? -1,
      dataId: props.id,
      isHeartSelected: props.hearted,
      token: handler.token ?? "",
    );
  }

  Expanded buildProductCardInfo() {
    return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildH(2),
            buildProductTitle(props.title, props.isGuide),
            buildH(6),
            buildPlace(props.place),
            buildH(12 * pt),
            buildEstimates(props.period, props.costStart, props.costEnd),
            buildH(14 * pt),
            buildTags(props.tags)
          ],
        ));
  }

  Row buildProductTitle(String title, bool isGuide) {
    return Row(
      children: [
        buildTitle(title),
        buildW(8 * pt),
        isGuide ? ContentTag(tagName: "가이드") : SizedBox()
      ],
    );
  }

  Container buildEstimates(DateTimeRange period, int costStart, int costEnd) {
    return Container(
      child: Column(
        children: [
          Text(
            "기간: ${period.end.difference(period.start).inDays.toString()}일",
            maxLines: 2,
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 12 * pt,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 4 * pt),
          Text(
            '예산: $costStart만원',
            maxLines: 2,
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 12 * pt,
              fontFamily: 'Roboto',
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
