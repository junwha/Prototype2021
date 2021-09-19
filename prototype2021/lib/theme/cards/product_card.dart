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

  ProductCardBaseProps({
    required this.period,
    required this.costStart,
    required this.costEnd,
    required this.isGuide,
    required this.matchPercent,
    required this.tendencies,
    required String preview,
    required String title,
    required String place,
    required List<String> tags,
  }) : super(
          preview: preview,
          title: title,
          place: place,
          tags: tags,
        );
}

class ProductCard extends StatefulWidget {
  final ProductCardBaseProps props;
  ProductCard.fromProps({
    required this.props,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with CardBase {
  bool heartSelected = false;
  void toggleHeartSelected() {
    setState(() {
      heartSelected = !heartSelected;
    });
    // Do something needed here (e.g. API call)
  }

  @override
  Widget build(BuildContext context) {
    return buildCard(
      itemInfo: buildProductCardInfo(),
      backgroundColor: Colors.white,
      preview: widget.props.preview,
      heartSelected: heartSelected,
      onHeartPressed: toggleHeartSelected,
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
            buildProductTitle(widget.props.title, widget.props.isGuide),
            buildH(6),
            buildPlace(widget.props.place),
            buildH(12 * pt),
            buildEstimates(widget.props.period, widget.props.costStart,
                widget.props.costEnd),
            buildH(14 * pt),
            buildTags(widget.props.tags)
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
