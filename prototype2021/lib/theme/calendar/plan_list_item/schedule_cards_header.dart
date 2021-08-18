import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/model/calendar.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/memo_dialog.dart';
import 'package:provider/provider.dart';

class ScheduleCardsHeader extends StatefulWidget {
  final int dateIndex;
  final bool listHasItem;
  final void Function() toggleExpanded;
  final bool expanded;
  final void Function(bool) setExpanded;
  final void Function(PlaceDataProps) addPlaceData;

  ScheduleCardsHeader(
      {required this.dateIndex,
      required this.listHasItem,
      required this.toggleExpanded,
      required this.expanded,
      required this.setExpanded,
      required this.addPlaceData});

  @override
  _ScheduleCardsHeaderState createState() => _ScheduleCardsHeaderState(
      dateIndex: dateIndex,
      listHasItem: listHasItem,
      toggleExpanded: toggleExpanded,
      expanded: expanded,
      setExpanded: setExpanded,
      addPlaceData: addPlaceData);
}

class _ScheduleCardsHeaderState extends State<ScheduleCardsHeader>
    with PlanListItemMemoDialogMixin, PlanListItemHelper {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  final int dateIndex;
  final bool listHasItem;
  final void Function() toggleExpanded;
  final bool expanded;
  final void Function(bool) setExpanded;
  final void Function(PlaceDataProps) addPlaceData;

  String _memo = "";
  void _setMemo(String memo) {
    setState(() {
      _memo = memo;
    });
  }

  void _createMemo() {
    addPlaceData(new MemoData(memo: _memo));
  }

  TextEditingController _textEditingController = TextEditingController();

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  _ScheduleCardsHeaderState(
      {required this.dateIndex,
      required this.listHasItem,
      required this.toggleExpanded,
      required this.expanded,
      required this.setExpanded,
      required this.addPlaceData});

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    DateTime date =
        calendarHandler.datePoints[0]!.add(Duration(days: dateIndex));
    return Container(
      child: Row(
        children: [buildLeading(date), buildActions()],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Container buildLeading(DateTime date) {
    return Container(
        child: Row(
          children: [
            Container(
              child: Row(
                children: [
                  Text("${(dateIndex + 1).toString()} 일차",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.left),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      "${date.month.toString()}.${date.day.toString()} ${Calendar().getWeekdayInKorean(date.weekday)}",
                      style: const TextStyle(
                          color: const Color(0xff505050),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0),
                      textAlign: TextAlign.left),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            IconButton(
                onPressed: listHasItem
                    ? null
                    : () {
                        toggleExpanded();
                      },
                icon: expanded
                    ? Image.asset('assets/icons/ic_calender_arrow_up_fold.png')
                    : Image.asset(
                        'assets/icons/ic_calender_arrow_down_unfold.png'))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        constraints: BoxConstraints(minWidth: 150));
  }

  Container buildActions() {
    return Container(
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                await displayMemoInputDialog(
                    context, _textEditingController, _setMemo, _createMemo);
                setExpanded(true);
              },
              icon: Image.asset('assets/icons/ic_calender_memo_gray.png')),
          IconButton(
              onPressed: () {
                addPlaceData(randomPlaceData());
                setExpanded(true);
              },
              icon: Image.asset('assets/icons/ic_calender_plus.png')),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
