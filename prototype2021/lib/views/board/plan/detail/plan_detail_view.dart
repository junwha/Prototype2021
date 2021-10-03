import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/data/pseudo_place_data.dart';
import 'package:prototype2021/model/board/plan/plan_map_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/board/plan/make/map/plan_map.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/shapes/tb_contenttag.dart';
import 'package:prototype2021/widgets/cards/tb_foldable_card.dart';
import 'package:prototype2021/widgets/radio/tb_radio_bar.dart';
import 'package:provider/provider.dart';

class PlanDetailView extends StatefulWidget {
  int pid;
  PlanDetailView({required this.pid, Key? key}) : super(key: key);

  @override
  _PlanDetailViewState createState() => _PlanDetailViewState();
}

class _PlanDetailViewState extends State<PlanDetailView> {
  /* =================================/=============================== */
  /* =========================STATES & METHODS======================== */
  /* =================================/=============================== */

  // Simulate API call
  PlanDataProps getPlanDetail(int pid) {
    Future.delayed(Duration(seconds: 3));
    return pseudoPlanData;
  }

  bool isLoaded = false;

  late PlanDataProps planData;

  // Flatten the place data double list
  late PlanMapModel mapModel;

  Future<void> loadPlanDetail() async {
    planData = getPlanDetail(this.widget.pid);
    mapModel = PlanMapModel(planData.planItemList[0][0].location);
    // Update PlaceData and polyline when map is completely loaded
    mapModel.setMapLoadListener(
        () => {mapModel.updatePlaceData(planData.planItemList)});
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPlanDetail();
  }

  /* =================================/=============================== */
  /* ===============================Widget============================ */
  /* =================================/=============================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: isLoaded
          ? SingleChildScrollView(
              child: Column(
              children: [
                buildColumnWithDivider(children: [
                  buildDescription(),
                  buildTripStyleView(planData),
                  buildMap(),
                ]),
                buildAllDayPlan(planData)
              ],
            ))
          : buildLoading(),
    );
  }

  /*
   * 현규님이 다른 곳에서 구현하신 것과 동일한 메소드입니다.
   * 아이템 사이사이에 Divider를 끼워넣습니다
   */
  Widget buildColumnWithDivider({List<Widget> children = const []}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            children.length * 2,
            (index) => (index % 2 == 0)
                ? Padding(
                    padding: EdgeInsets.all(20),
                    child: (children[(index ~/ 2)]))
                : buildDivider()));
  }

  // TODO: replace this loading page to implemented loading page widget
  Widget buildLoading() {
    return Text("loading");
  }

  Widget buildDivider() {
    return Container(
      height: 0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffe8e8e8),
          width: 1,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Text(
        '플랜 정보',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15 * pt,
          fontFamily: 'Roboto',
        ),
      ),
      elevation: 3,
      shadowColor: Colors.white,
      leading: IconButton(
        icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${planData.title}',
              style: TextStyle(
                color: Color(0xff444444),
                fontSize: 18 * pt,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Image.asset(
                // TODO: replace this part with newly implemented heart widget
                true
                    ? "assets/icons/ic_product_heart_fill.png"
                    : "assets/icons/ic_product_heart_default.png",
              ),
            ),
          ],
        ),
        Text(
          '${planData.region}',
          style: TextStyle(
            color: Color(0xff555555),
            fontSize: 12 * pt,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 8),
        Text(
          '${planData.period.duration.inDays}일',
          style: TextStyle(
            color: Color(0xff555555),
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          '${planData.budget}',
          style: TextStyle(
            color: Color(0xff555555),
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [TBContentTag(contentTitle: "asdf")],
        )
      ],
    );
  }

  /*
   * initState에서 생성한 PlanMapModel을 사용합니다
   */
  Widget buildMap() {
    return ChangeNotifierProvider<PlanMapModel>.value(
        value: mapModel,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PlanMapModel>(
                builder: (BuildContext ctx, PlanMapModel model, Widget? _) {
              return Container(
                height: 200,
                child: mapModel.mapLoaded ? PlanMap() : SizedBox(height: 200),
              );
            }),
            SizedBox(
              height: 30,
            ),
            Text(
              '일정',
              style: TextStyle(
                fontSize: 15 * pt,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ));
  }

  /*
   * placeList로부터 일자마다 foldable한 컨텐츠/메모 칼럼을 생성합니다
   */
  Widget buildDailyPlan(List<PlaceDataProps> placeList) {
    return Column(
        children: placeList.map((data) {
      if (data is MemoData) {
        return ContentsCard.fromProps(
          props: ContentsCardBaseProps(
            id: 1,
            hearted: true,
            backgroundColor: Colors.white,
            preview: placeHolder,
            title: "Custom Memo",
            place: "",
            explanation: "${data.memo}",
            rating: 0,
            ratingNumbers: 0,
            tags: [],
          ),
        );
      } else if (data is PseudoPlaceData) {
        PseudoPlaceData placeData = data;
        return ContentsCard.fromProps(
          props: ContentsCardBaseProps(
            id: 1,
            hearted: true,
            backgroundColor: Colors.white,
            preview: placeHolder,
            title: "${placeData.name}",
            place: "대한민국, 울산",
            explanation: "다양한 놀이 기구와 운동 시설을 갖춘 도심 공원, 울산대공원'",
            rating: 5,
            ratingNumbers: 34,
            tags: ["액티비티", "관광명소", "인생사진"],
          ),
        );
      }
      return SizedBox();
    }).toList());
  }

  /*
   * planData로부터 모든 일자에 대해 컨텐츠/메모 뷰를 생성합니다
   */
  Widget buildAllDayPlan(PlanDataProps planData) {
    return buildColumnWithDivider(
      children: planData.planItemList
          .map(
            (placeList) => TBFoldableCard(
              text: "${planData.planItemList.indexOf(placeList) + 1} 일차",
              child: buildDailyPlan(placeList),
            ),
          )
          .toList(),
    );
  }

  /*
   * RadioBar를 각각 생성합니다
   */
  Widget buildTripStyleView(PlanDataProps planData) {
    return TBFoldableCard(
      text: "이 여행의 스타일 보기",
      child: Column(
        children: [
          _buildRadioBars(1, 3), //TODO: process with planData
        ],
      ),
    );
  }

  Widget _buildRadioBars(int p1, int p2) {
    //TODO: rename this two variables
    return Column(
      children: [
        TBRadioBar(
          selectedRadio: p1,
          onChanged: (_) {},
          minimumText: '여유롭고 \n느긋한 여행',
          maximumText: "바쁘더라도\n알찬 여행",
        ),
        TBRadioBar(
          selectedRadio: p2,
          onChanged: (_) {},
          minimumText: "불편해도\n 저렴하게",
          maximumText: "비싸더라도\n 편안하게",
        ),
      ],
    );
  }
}
