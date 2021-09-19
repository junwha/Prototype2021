import 'package:flutter/material.dart';

class TBFoldableCard extends StatefulWidget {
  double width;
  double height;
  Widget child;
  String text;

  TBFoldableCard(
      {required this.child,
      required this.text,
      this.width = double.infinity,
      this.height = 50,
      Key? key})
      : super(key: key);

  @override
  _TBFoldableCardState createState() => _TBFoldableCardState();
}

class _TBFoldableCardState extends State<TBFoldableCard>
    with SingleTickerProviderStateMixin {
  /* =================================/=============================== */
  /* =========================STATES & METHODS======================== */
  /* =================================/=============================== */
  bool expanded = false;
  void changeExpandedState() {
    setState(() {
      expanded = !expanded;
    });
  }

  /* =================================/=============================== */
  /* ==============================Widget============================= */
  /* =================================/=============================== */
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      color: Colors.pink,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [buildHeader(), buildMain()],
      ),
    );
  }

  AnimatedSize buildMain() {
    return AnimatedSize(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: expanded
          ? Container(
              child: this.widget.child,
            )
          : Container(),
      vsync: this,
    );
  }

  Container buildHeader() {
    return Container(
      height: this.widget.height,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.widget.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: changeExpandedState,
            icon: expanded
                ? Image.asset('assets/icons/ic_calender_arrow_up_fold.png')
                : Image.asset('assets/icons/ic_calender_arrow_down_unfold.png'),
          ),
        ],
      ),
    );
  }
}
