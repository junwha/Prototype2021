import 'package:flutter/material.dart';
import 'package:prototype2021/templates/product_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:prototype2021/templates/select_button.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage>
    with AutomaticKeepAliveClientMixin<BoardPage> {
  @override
  bool get wantKeepAlive => true;

  final List<ProductCard> cards = List.generate(
      10,
      (index) => ProductCard(
          title: '포르투갈',
          cost: 10000000,
          period: '4주',
          companion: 2,
          season: '여름',
          travelType: '자유여행',
          preview: 'images/preview.png'));

  bool searchOn = false;
  String searchData = '';

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Widget buildButtonBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        SelectBarButton(
          child: Icon(Icons.search),
          onPressed: () {
            setState(() {
              searchOn = true;
            });
          },
        ),
        SelectBarButton(child: Text('국가'), onPressed: () {}),
        SelectBarButton(child: Text('비용'), onPressed: () {}),
        SelectBarButton(child: Text('계절'), onPressed: () {}),
        SelectBarButton(child: Text('기간'), onPressed: () {}),
      ],
    );
  }

  Widget buildSearchResultView(String searchData) {
    bool isDataNull = searchData == '';
    print(searchData);
    if (!isDataNull) {
      return Container(
        color: Colors.white,
        width: double.maxFinite,
        height: 200,
        alignment: Alignment.center,
        child: Text('검색 결과'),
      );
    } else {
      return SizedBox(height: 0, width: 0);
    }
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();

    return FloatingSearchBar(
      controller: controller,
      hint: '여행을 떠나보세요',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
      transitionDuration: const Duration(milliseconds: 1000),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(
                    height: 112,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Search Result Test',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ));
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 65.0),
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (BuildContext _context, int i) {
              return cards[i];
            },
          ),
        ),
        buildSearchResultView(searchData),
        searchOn ? buildFloatingSearchBar() : buildButtonBar(),
      ],
    );
  }
}
