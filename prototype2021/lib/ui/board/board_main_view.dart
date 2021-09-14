import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/app_bar.dart';
import 'package:prototype2021/theme/board/board_list_view.dart';
import 'package:prototype2021/theme/board/header_silver.dart';
import 'package:prototype2021/theme/board/helpers.dart';
import 'package:prototype2021/theme/cards/contents_card.dart';
import 'package:prototype2021/theme/cards/contents_card_base.dart';
import 'package:prototype2021/theme/cards/product_card.dart';
import 'package:prototype2021/theme/cards/product_card_base.dart';
import 'package:prototype2021/ui/board/content_detail_view.dart';
import 'package:prototype2021/ui/board/plan_make_view.dart';
import 'package:prototype2021/ui/board/select_location_toggle_view.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

enum BoardMainViewMode { main, search, result }

class _BoardMainViewState extends State<BoardMainView>
    with
        BoardMainHeaderSilverMixin,
        BoardMainViewAppBarMixin,
        BoardMainViewHelpers {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  BoardMainViewMode viewMode = BoardMainViewMode.main;

  void setViewMode(BoardMainViewMode _viewMode) => setState(() {
        viewMode = _viewMode;
      });

  TextEditingController textEditingController = new TextEditingController();
  String searchInput = "";
  void setSearchInput(String _searchInput) => setState(() {
        searchInput = _searchInput;
      });

  // Need Refactor
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};
  // Need to apply individual cards
  bool heartSelected = false;
  bool heartSelected2 = false;

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  _BoardMainViewState() : super();

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context,
          viewMode: viewMode,
          setViewMode: setViewMode,
          textController: textEditingController,
          onTextFieldChanged: setSearchInput),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: buildHeaderBuilder(context),
          body: viewMode == BoardMainViewMode.search
              ? SizedBox()
              : TabBarView(children: [
                  buildPlanListView(context),
                  buildContentListView(context),
                ]),
        ),
      ),
    );
  }

  List<SliverAppBar> Function(BuildContext, bool) buildHeaderBuilder(
      BuildContext context) {
    // Need Refactor
    void onLeadingPressed() {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (context) => SelectLocationToggleView(
                    mainLocation: location["mainLocation"] ?? "",
                    subLocation: location["subLocation"] ?? "",
                  ))).then((value) {
        setState(() {
          Map<String, String> _location = value as Map<String, String>;
          if (_location.containsKey("mainLocation") &&
              _location.containsKey("subLocation")) {
            location = _location;
          }
        });
      });
    }

    return buildHeaderSilverBuilder(
        location: location,
        onLeadingPressed: onLeadingPressed,
        viewMode: viewMode);
  }

  /* 
   * This(buildPlanListView and buildContentListView) is temporary implementation. 
   * isHeartSelected state should be handled  
   * at the individual ProductCard or ContentsCard level, 
   * not at the root widget level(BoardMainView)
   */
  BoardListView buildPlanListView(BuildContext context) {
    return BoardListView<ProductCardBaseProps>(
      data: generatePseudoPlanData((bool isSelected) {
        setState(() {
          heartSelected = isSelected;
        });
      }, heartSelected),
      builder: (props) => ProductCard(props: props),
      routeBuilder: (_) => PlanMakeView(),
    );
  }

  BoardListView buildContentListView(BuildContext context) {
    return BoardListView<ContentsCardBaseProps>(
      data: generatePseudoContentData((bool isSelected) {
        setState(() {
          heartSelected2 = isSelected;
        });
      }, heartSelected2),
      builder: (props) => ContentsCard(props: props),
      routeBuilder: (_) => ContentDetailView(),
    );
  }
}
