import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/card_base.dart';

class ContentsCardBaseProps extends CardBaseProps {
  final double rating;
  final int ratingNumbers;
  final String explanation;
  final Color backgroundColor;
  final EdgeInsets margin;
  final int heartCount;

  ContentsCardBaseProps({
    required this.rating,
    required this.ratingNumbers,
    this.backgroundColor = Colors.white,
    required this.explanation,
    this.heartCount = 3,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

class ContentsCard extends StatefulWidget {
  final ContentsCardBaseProps props;

  ContentsCard.fromProps({required this.props});

  @override
  _ContentsCardState createState() => _ContentsCardState();
}

class _ContentsCardState extends State<ContentsCard> with CardBase {
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
      itemInfo: buildContentsCardInfo(),
      backgroundColor: widget.props.backgroundColor,
      preview: widget.props.preview,
      heartSelected: heartSelected,
      onHeartPressed: toggleHeartSelected,
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
          buildTitle(widget.props.title),
          buildH(6),
          buildPlace(widget.props.place),
          buildH(5),
          buildRatings(widget.props.rating, widget.props.ratingNumbers),
          buildH(6 * pt),
          buildExplanation(widget.props.explanation),
          buildH(10 * pt),
          buildTags(widget.props.tags),
        ],
      ),
    );
  }

  Row buildRatings(double rating, int ratingNumbers) {
    return Row(
      children: [
        Image.asset(
          "assets/icons/ic_pc_star_small.png",
        ),
        SizedBox(width: 3),
        Text(
          '${rating.toString()} (${ratingNumbers.toString()})',
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
          '${rating.toString()} (${ratingNumbers.toString()})',
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
