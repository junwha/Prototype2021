import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/views/board/plan/make/home/plan_make_home_view.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/constants.dart';
import 'package:prototype2021/views/board/plan/make/schedule_card/mixin/actions.dart';
import 'package:prototype2021/views/board/plan/make/schedule_card/mixin/helper.dart';
import 'package:prototype2021/views/board/plan/make/schedule_card/mixin/leading.dart';

// class ScheduleCard extends StatefulWidget {
//   final PlaceDataProps data;
//   final int dateIndex;
//   final int order;
//   final Key? key;
//   final void Function() deleteSelf;

//   ScheduleCard(
//       {required this.data,
//       required this.dateIndex,
//       required this.order,
//       required this.deleteSelf,
//       this.key});

//   @override
//   _ScheduleCardState createState() => _ScheduleCardState(
//       data: data,
//       dateIndex: dateIndex,
//       order: order,
//       deleteSelf: deleteSelf,
//       key: key);
// }

class ScheduleCard extends StatelessWidget
    with
        ScheduleCardLeadingMixin,
        ScheduleCardActionsMixin,
        ScheduleCardHelpers {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  final PlaceDataProps data;
  final int dateIndex;
  final int order;
  final Key? key;
  final void Function() deleteSelf;
  final String dataId; // Recommend to change with real dataId soon

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  ScheduleCard(
      {required this.data,
      required this.dateIndex,
      required this.order,
      required this.deleteSelf,
      this.key})
      : dataId = "$dateIndex-${order - 1}";

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    PlanMakeHomeViewState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeViewState>();
    String types = data.types;
    return Container(
      key: key,
      child: Container(
          child: Row(
            children: [
              Container(
                child: Row(
                  children: [
                    buildLeading(types, order, placeColorByType(types)),
                    SizedBox(
                      width: 10,
                    ),
                    buildInfo(data)
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              buildActions(context, types, placeIconByType(types)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                    spreadRadius: 0)
              ],
              color: grandParent?.copiedDataId == dataId
                  ? const Color(0xffe8e8e8)
                  : const Color(0xffffffff))),
      padding: EdgeInsets.only(right: 4),
    );
  }

  Container buildActions(BuildContext context, String types, Widget icon) {
    PlanMakeHomeViewState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeViewState>();
    PlanMakeMode mode = grandParent?.mode ?? PlanMakeMode.add;
    void onCopyButtonPressed() {
      grandParent?.setCopiedData(dataId, data);
    }

    switch (mode) {
      case PlanMakeMode.edit:
        return buildEditActions(
            context, order, grandParent?.setOnDrag, onCopyButtonPressed);
      case PlanMakeMode.delete:
        return buildDeleteActions(context, deleteSelf);
      default:
        return buildDefaultActions(context, types, icon);
    }
  }
}
