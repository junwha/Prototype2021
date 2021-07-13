import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/card.dart';
import 'package:prototype2021/ui/event/my_page_view.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

class _BoardMainViewState extends State<BoardMainView> {
  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>['Pla ', 'Content'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey[100],
                title: buildCurrentLocation(),
              ),
              SliverAppBar(
                elevation: 0,
                pinned: true,
                backgroundColor: Colors.white,
                title: buildTabBar(),
              ),
            ];
          },
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                 
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                  Text("플랜"),
                  SizedBox(height: 100),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                  Text("컨텐츠"),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      unselectedLabelColor: Color(0xffbdbdbd),
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      indicatorWeight: 1 * pt,
      tabs: [
        Tab(
          child: Container(
            child: Text(
              '플랜',
              style: TextStyle(
                fontSize: 15 * pt,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Tab(
          child: Text(
            '컨텐츠',
            style: TextStyle(
              fontSize: 15 * pt,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        color: Colors.black,
        icon: Image.asset("assets/icons/ic_remove_x.png"),
        onPressed: () {},
      ),
      toolbarHeight: 60,
      actions: [

         AppBarTextButton(
           onPressed: (){},
           icon:              Image.asset("assets/icons/ic_main_search.png"),

           text: "검색"
         ),
         AppBarTextButton(
           onPressed: (){},
           icon:              Image.asset("assets/icons/ic_main_heart_default.png"),

           text: "찜목록"
         ),
         AppBarTextButton(
           onPressed: (){},
           icon:              Image.asset("assets/icons/ic_hamburger_menu.png"),

           text: "메뉴"
         ),
                
        
      ],
    );
  }
}

class AppBarTextButton extends StatelessWidget {
  Function() onPressed;
  Image icon;
  String text;

  AppBarTextButton({
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
         onPressed: this.onPressed,
         icon: Column(
           children: [
             this.icon,
             Text(this.text,
     style: TextStyle(
       color: Color(0xff555555),
       fontSize: 10,
       fontFamily: 'Roboto',
     ),
        ),   
           ],
         ),
       );
  }
}

Widget buildCurrentLocation() {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15 * pt, 12 * pt, 15 * pt, 29 * pt),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Row(
              children: [
                Text(
                  '국내 전체',
                  style: TextStyle(
                    color: Color(0xff444444),
                    fontSize: 24 * pt,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 10 * pt),
                ImageIcon(
                  AssetImage("assets/icons/ic_area_arrow_down_unfold.png"),
                  color: Colors.black,
                  size: 14 * pt,
                ),
              ],
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/icons/ic_filter_gray.png"),
          ),
        ],
      ),
    ),
  );
}
