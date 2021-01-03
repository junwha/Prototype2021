import 'package:flutter/material.dart';
// import 'package:prototype2021/board/board_page.dart';
import 'package:prototype2021/templates/borded_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('000 님의 여행 MBTI는',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              Text('발랄한 모험가 형 입니다.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              Container(
                height: 250,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ExpandedButton(text: '여행 제작', onPressed: () {}),
                          SizedBox(width: 10),
                          ExpandedButton(
                              text: '여행 게시판',
                              onPressed: () {
                                Navigator.pushNamed(context, '/board');
                              })
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ExpandedButton(text: '여행 후기', onPressed: () {}),
                          SizedBox(width: 10),
                          ExpandedButton(text: '마이 플랜', onPressed: () {}),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                '특가 이벤트',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ImageButton(
                      title: '두바이 마리나\n유람선 할인',
                      backgroundImageDir:
                          'assets/images/home_page/dubai_marina.jpg',
                    ),
                    SizedBox(width: 10),
                    ImageButton(
                      title: '두바이 몰\n시즌 특가 세일',
                      backgroundImageDir:
                          'assets/images/home_page/dubai_mall.jpg',
                    ),
                    SizedBox(width: 10),
                    ImageButton(
                      title: '2021\n두바이 엑스포',
                      backgroundImageDir:
                          'assets/images/home_page/dubai_marina.jpg',
                    ),
                    SizedBox(width: 10),
                    ImageButton(
                      title: '버즈 알 아랍\n호캉스 찬스',
                      backgroundImageDir:
                          'assets/images/home_page/dubai_mall.jpg',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                '여행지 추천',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 15),
              ImageButton(
                title: '아부다비 대통령 궁,\n두바이 정치의 중심지',
                backgroundImageDir: 'assets/images/home_page/dubai_mall.jpg',
                width: MediaQuery.of(context).size.width,
                height: 300,
                textAlignment: Alignment.bottomLeft,
                fontSize: 25,
              ),
              SizedBox(height: 10),
              ImageButton(
                title: '아부다비 대통령 궁,\n두바이 정치의 중심지',
                backgroundImageDir: 'assets/images/home_page/dubai_mall.jpg',
                width: MediaQuery.of(context).size.width,
                height: 300,
                textAlignment: Alignment.bottomLeft,
                fontSize: 25,
              ),
              SizedBox(height: 10),
              ImageButton(
                title: '아부다비 대통령 궁,\n두바이 정치의 중심지',
                backgroundImageDir: 'assets/images/home_page/dubai_mall.jpg',
                width: MediaQuery.of(context).size.width,
                height: 300,
                textAlignment: Alignment.bottomLeft,
                fontSize: 25,
              ),
              SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: BordedButton(
                    child: Text(
                      '여행지 추천 더보기',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    onPressed: () {},
                    radius: 40,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double fontSize;
  final double radius;

  const ExpandedButton(
      {this.text, this.onPressed, this.fontSize = 20, this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BordedButton(
        child: Text(
          this.text,
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: this.fontSize),
        ),
        onPressed: this.onPressed,
        radius: this.radius,
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final String backgroundImageDir;
  final String title;
  final double width;
  final double height;
  final Alignment textAlignment;
  final double fontSize;

  const ImageButton({
    this.backgroundImageDir,
    this.title,
    this.width = 180,
    this.height = 250,
    this.textAlignment = Alignment.bottomCenter,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage(this.backgroundImageDir),
          fit: BoxFit.cover,
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () {},
        child: Align(
          alignment: this.textAlignment,
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: this.fontSize),
          ),
        ),
      ),
    );
  }
}
