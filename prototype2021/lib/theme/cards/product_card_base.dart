import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/card_base.dart';
import 'package:prototype2021/theme/tag.dart';

class ProductCardBaseProps extends CardBaseProps {
  final int period;
  final int costStart;
  final int costEnd;
  final bool isGuide;
  final double matchPercent;
  final List<String> tendencies;

  ProductCardBaseProps(
      {required this.period,
      required this.costStart,
      required this.costEnd,
      required this.isGuide,
      required this.matchPercent,
      required this.tendencies,
      required String preview,
      required String title,
      required String place,
      required List<String> tags,
      bool isHeartSelected = false,
      Function(bool)? onHeartPreessed})
      : super(
          preview: preview,
          title: title,
          place: place,
          tags: tags,
          isHeartSelected: isHeartSelected,
          onHeartPreessed: onHeartPreessed,
        );
}

abstract class ProductCardBase extends StatelessWidget with CardBase {
  final ProductCardBaseProps props;

  ProductCardBase.fromProps({required this.props});

  @override
  Widget build(BuildContext context) {
    return buildCard(buildProductCardInfo(), Colors.white, props.preview,
        props.isHeartSelected, props.onHeartPreessed);
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

  Container buildEstimates(int period, int costStart, int costEnd) {
    return Container(
      child: Column(
        children: [
          Text(
            "기간: ${period.toString()}일",
            maxLines: 2,
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 12 * pt,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 4 * pt),
          Text(
            '예산: ${costStart.toString()}~${costEnd.toString()}만원',
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
