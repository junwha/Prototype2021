import 'package:flutter/material.dart';
import 'package:prototype2020/templates/product_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
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

  Widget buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 45,
            child: FlatButton(
              child: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  searchOn = false;
                });
              },
            ),
          ),
          Expanded(
            child: TextFormField(
              //https://kyungsnim.tistory.com/131 Search Bar document
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (str) {
                setState(() {
                  if (str == null)
                    searchData = '';
                  else
                    searchData = str;
                });
              },
              onFieldSubmitted: (str) {
                searchData = str;
                searchOn = false;
              },
            ),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        searchOn ? buildSearchBar() : buildButtonBar(),
        Expanded(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext _context, int i) {
                  return cards[i];
                },
              ),
              buildSearchResultView(searchData),
            ],
          ),
        ),
      ],
    );
  }
}

class SelectBarButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  SelectBarButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.grey)),
      child: this.child,
    );
  }
}
