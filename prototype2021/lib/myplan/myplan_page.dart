import 'package:flutter/material.dart';
import 'package:prototype2021/templates/product_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MyPlanPage extends StatefulWidget {
  @override
  _MyPlanPageState createState() => _MyPlanPageState();
}

class _MyPlanPageState extends State<MyPlanPage>
    with AutomaticKeepAliveClientMixin<MyPlanPage> {
  @override
  bool get wantKeepAlive => true;

  final List<ProductCard> cards = List.generate(
      10,
      (index) => ProductCard(
            preview: 'images/preview.png',
            title: '포르투갈',
            cost: 10000000,
            period: '4주',
            tags: ['여행 감상', '맛집 탐방', '액티비티'],
            matchPercent: 99,
            tendencies: [0, 1, 2],
          ));

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();

    return FloatingSearchBar(
      shadowColor: Colors.transparent,
      backdropColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      height: 45,
      backgroundColor: const Color(0xFFEDECEC),
      controller: controller,
      title: Row(
        children: [Icon(Icons.search), Text('여행을 떠나보세요')],
      ),
      hint: 'search',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
      transitionDuration: const Duration(milliseconds: 1000),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      automaticallyImplyBackButton: false,
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
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => FilterPage()),
              // );
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        children: [
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                          Form(
                            key: _applyKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text("Submitß"),
                                    onPressed: () {
                                      if (_applyKey.currentState.validate()) {
                                        _applyKey.currentState.save();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        FloatingSearchBarAction.back(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
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
        ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext _context, int i) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: (i == 0)
                  ? Column(
                      children: [
                        SizedBox(height: 65.0),
                        Row(children: [
                          SizedBox(width: 5),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  color: Colors.teal[200],
                                  child: Icon(Icons.airplanemode_active,
                                      color: Colors.white, size: 20),
                                ),
                              ),
                              Container(
                                height: 5,
                                width: 2,
                                color: Colors.black,
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          Text(
                            '마이 플랜',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ]),
                        cards[i],
                      ],
                    )
                  : cards[i],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: buildFloatingSearchBar(),
        ),
      ],
    );
  }
}
