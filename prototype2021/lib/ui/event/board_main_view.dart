import 'package:flutter/material.dart';
import 'package:prototype2021/ui/event/my_page_view.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

class _BoardMainViewState extends State<BoardMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: Text("asdf"),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        color: Colors.black,
        icon: Image.asset("assets/icons/ic_remove_x.png"),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset("assets/icons/ic_main_search.png"),
        ),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          icon: Image.asset(
            "assets/icons/ic_main_heart_default.png",
          ),
        ),
        IconButton(
          color: Colors.black,
          onPressed: () {},
          icon: Image.asset("assets/icons/ic_hamburger_menu.png"),
        ),
      ],
    );
  }
}
