import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: LodgingList()));
}

class LodgingList extends StatefulWidget {
  @override
  LodgingListState createState() => LodgingListState();
}

class LodgingListState extends State<LodgingList> {
  List<bool> isChecked = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter List View Tutorial"),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    var listview = ListView(children: [
      servicecard(
        0,
        "https://cdn.crowdpic.net/detail-thumb/thumb_d_DD628C92AA01ABB62602667CDCF70976.jpg",
        "바닷가 낚시 체험",
        "개인",
      ),
      splitLine(),
      servicecard(
        1,
        "https://cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/LVOAF2GDJHJTWD3TTE7S4ITSCU.jpg",
        "트립 아일랜드 유람선 탑승",
        "그룹 / 6명",
      ),
      splitLine(),
      servicecard(
        2,
        "https://d1blyo8czty997.cloudfront.net/tour-photos/84/1200x600/9343853710.jpg",
        "트립 아일랜드 야경 명소 탐방",
        "그룹 / 8명",
      ),
      splitLine(),
      servicecard(
        3,
        "https://img.kr.news.samsung.com/kr/wp-content/uploads/2018/09/sc1.jpg",
        "트립 아일랜드 다이빙 스팟",
        "그룹 /  6명",
      ),
      splitLine(),
      servicecard(
        4,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Libya_5230_Wan_Caza_Dunes_Luca_Galuzzi_2007.jpg/220px-Libya_5230_Wan_Caza_Dunes_Luca_Galuzzi_2007.jpg",
        "트립아일랜드 사막 체험",
        "개인",
      ),
      splitLine(),
      servicecard(
        5,
        "https://pds.joins.com//news/component/htmlphoto_mmdata/201808/17/3da796db-8bf0-4d5e-9fa1-71081b6b4c34.jpg",
        "트립 아일랜드 산악 체험",
        "개인",
      ),
      splitLine(),
    ]);
    return listview;
  }

  Widget splitLine() {
    return Container(
      width: 500,
      height: 0.5,
      color: Colors.grey,
    );
  }

  Widget servicecard(
    int i,
    String image,
    String price,
    String text1,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked[i] = isChecked[i] ? false : true;
        });
      },
      child: Container(
        color: isChecked[i] ? Colors.blue[100] : Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    image,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.5,
                      color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  text1,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
