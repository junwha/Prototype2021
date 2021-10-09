import 'package:flutter/material.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/board/plan/make/home/plan_make_home_view.dart';
import 'package:prototype2021/widgets/shapes/circular_wrapper.dart';
import 'package:provider/provider.dart';

mixin PlanMakeHomeHeaderMixin on State<PlanMakeHomeView> {
  /*
   * Abstract method for State
   * override this method with State variable.
   */
  void onMapButtonTap();

  Container buildHeader(
    BuildContext context, {
    required void Function() backNavigator,
  }) {
    return Container(
      child: Row(
        children: [
          buildHeaderLeading(),
          buildHeaderActions(
            context,
            navigator: backNavigator,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(top: 50 * pt, left: 40, right: 40, bottom: 10),
    );
  }

  Container buildHeaderLeading() {
    return Container(
      child: Row(
        children: [
          Text("여행 일정",
              style: const TextStyle(
                  color: const Color(0xff4080ff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 22.0),
              textAlign: TextAlign.left),
          SizedBox(width: 5),
          Text("짜기",
              style: const TextStyle(
                  color: const Color(0xff9dbeff),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.left)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }

  Container buildHeaderActions(
    BuildContext context, {
    required void Function() navigator,
  }) {
    PlanMakeHandler calendarHandler = Provider.of<PlanMakeHandler>(context);
    return Container(
      child: Row(
        children: [
          CircularWrapper(
            icon: Image.asset('assets/icons/map.png'),
            onTap: onMapButtonTap,
            size: 34,
            shadow: true,
          ),
          SizedBox(
            width: 10 * pt,
          ),
          CircularWrapper(
            icon: Image.asset('assets/icons/ic_calender_calender.png'),
            onTap: navigator,
            size: 34,
            shadow: true,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
