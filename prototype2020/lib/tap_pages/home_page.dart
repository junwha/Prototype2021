import 'package:flutter/material.dart';
import 'package:prototype2020/templates/product_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ProductCard> cards = [
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png'),
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png'),
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png'),
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png'),
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png'),
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png'),
    ProductCard(
        title: '포르투갈',
        cost: 10000000,
        period: '4주',
        companion: 2,
        season: '여름',
        travelType: '자유여행',
        preview: 'images/preview.png')
  ];

  Widget buttonRow;
  Widget searchBar;
  bool searchOn = false;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    buttonRow = ButtonBar(
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
    searchBar = TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
      ),
      onFieldSubmitted: (str) {
        setState(() {
          searchOn = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        searchOn ? searchBar : buttonRow,
        Expanded(
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (BuildContext _context, int i) {
              return cards[i];
            },
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
