import 'package:flutter/material.dart';
import 'package:prototype2021/data/dto/contents/content_detail.dart';
import 'package:prototype2021/theme/board/contents_detail/helpers.dart';

/// 페이지의 내용물 렌더링을 담당하는 믹스인
mixin ContentsDetailViewBodyMixin {
  /// 관광지의 제목과 설명의 글을 렌더링합니다
  Padding buildTextArea(ContentsDetail props) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Text(
            htmlToStringContent(props.title),
            style: TextStyle(
              height: 1.3,
              color: Color(0xff010101),
              fontSize: 21,
              letterSpacing: 1.5,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            htmlToStringContent(props.overview),
            style: TextStyle(
              color: Colors.black,
              height: 1.5,
              fontSize: 15,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  String _handlePriceData(ContentsDetail props) {
    List<List<String>> useFees = [];
    String? usefee = pickNonNull([
      props.detailInfo.usefee,
      props.detailInfo.usetimefestival == null
          ? null
          : props.detailInfo.usetimefestival.toString(),
      props.detailInfo.usefeeleports,
    ]);
    if (usefee != null) {
      useFees.add(['이용요금', usefee]);
    }
    String? discountInfo = pickNonNull([
      props.detailInfo.discountInfo,
      props.detailInfo.discountInfofood,
      props.detailInfo.discountinfofestival,
    ]);
    if (discountInfo != null) {
      useFees.add(['할인 정보', discountInfo]);
    }
    String? refundRegulation = pickNonNull([
      props.detailInfo.refundregulation,
    ]);
    if (refundRegulation != null) {
      useFees.add(['환불 정책', refundRegulation]);
    }
    String? parking = pickNonNull([
      props.detailInfo.parking,
      props.detailInfo.parkingculture,
      props.detailInfo.parkingleports,
      props.detailInfo.parkingshopping,
      props.detailInfo.parkingfood,
    ]);
    if (parking != null) {
      useFees.add(['주차 시설', parking]);
    }
    String? parkingFee = pickNonNull([
      props.detailInfo.parkingfee,
      props.detailInfo.parkingfeeculture,
      props.detailInfo.parkingfeeleports,
    ]);
    if (parkingFee != null) {
      useFees.add(['주차 요금', parkingFee]);
    }
    if (props.detailInfo.saleitem != null) {
      useFees.add(['판매 품목', props.detailInfo.saleitem!]);
      if (props.detailInfo.saleitemcost != null) {
        useFees.add(['품목별 가격', props.detailInfo.saleitemcost!]);
      }
    }

    return useFees.fold<String>("", (acc, cur) {
      return acc + cur[0] + " " + cur[1] + '\n';
    });
  }

  /// 관광지의 이용료에 관한 정보를 렌더링합니다
  Widget buildPriceArea(ContentsDetail props) {
    String priceData = _handlePriceData(props);
    if (priceData.length == 0) {
      return SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("이용료",
                  style: const TextStyle(
                      color: const Color(0xff080808),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.5,
                      fontSize: 17.0)),
              SizedBox(
                width: 4,
              ),
              // Text(
              //   "유료",
              //   style: const TextStyle(
              //       color: const Color(0xff004af7),
              //       fontWeight: FontWeight.w700,
              //       fontFamily: "Roboto",
              //       fontStyle: FontStyle.normal,
              //       letterSpacing: 1.5,
              //       fontSize: 17.0),
              // )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            htmlToStringContent(priceData),
            style: TextStyle(
              color: Color(0xff707070),
              height: 1.9,
              fontSize: 15,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  String _handleTimeData(ContentsDetail props) {
    List<List<String>> useTimes = [];
    String? openDate = pickNonNull([
      props.detailInfo.opendate,
      props.detailInfo.opendatefood,
      props.detailInfo.opendateshopping,
    ]);
    if (openDate != null) {
      useTimes.add(['오픈 일자', openDate]);
    }
    // Need close date
    String? openPeriod = pickNonNull([
      props.detailInfo.openpriod,
    ]);
    if (openPeriod != null) {
      useTimes.add(['오픈 기간', openPeriod]);
    }
    String? openTime = pickNonNull([
      props.detailInfo.opentime,
      props.detailInfo.opentimefood,
    ]);
    if (openTime != null) {
      useTimes.add(['영업시간', openTime]);
    }
    String? restDate = pickNonNull([
      props.detailInfo.restdate,
      props.detailInfo.restdateculture,
      props.detailInfo.restdateleports,
      props.detailInfo.restdateshopping,
    ]);
    if (restDate != null) {
      useTimes.add(['쉬는날', restDate]);
    }
    String? useSeason = pickNonNull([
      props.detailInfo.useseason,
    ]);
    if (useSeason != null) {
      useTimes.add(['이용시즌', useSeason]);
    }
    String? useTime = pickNonNull([
      props.detailInfo.usetime,
      props.detailInfo.usetimeculture,
      props.detailInfo.usetimeleports,
      // props.detailInfo.usetimefestival // 이게 왜 요금인지 모르겠음. 하여간 정부 API는 ㄹㅇ 이상함
    ]);
    if (useTime != null) {
      useTimes.add(['이용시간', useTime]);
    }
    String? spendTime = pickNonNull([
      props.detailInfo.spendtime,
    ]);
    if (spendTime != null) {
      useTimes.add(['관람 소요시간', spendTime]);
    }
    String? playtime = pickNonNull([
      props.detailInfo.playtime,
    ]);
    if (playtime != null) {
      useTimes.add(["공연시간", playtime]);
    }
    if (props.detailInfo.checkintime != null) {
      useTimes.add(['입실 시간', props.detailInfo.checkintime!]);
    }
    if (props.detailInfo.checkouttime != null) {
      useTimes.add(['퇴실 시간', props.detailInfo.checkouttime!]);
    }
    return useTimes.fold<String>("", (acc, cur) {
      return acc + cur[0] + " " + cur[1] + "\n";
    });
  }

  /// 관광지의 영엽시간, 휴뮤일에 관한 정보를 렌더링합니다
  Widget buildTimeArea(ContentsDetail props) {
    String timeData = _handleTimeData(props);
    if (timeData.length == 0) {
      return SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('영업 시간, 휴무일',
                style: TextStyle(
                    color: Color(0xff080808),
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5),
                textAlign: TextAlign.left),
            SizedBox(
              height: 3,
            ),
            Text(
              htmlToStringContent(timeData),
              style: TextStyle(
                fontFamily: 'Roboto',
                height: 1.9,
                color: Color(0xff707070),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  /// String인 key-value를 TextSpan으로 렌더링하기 위한 헬퍼 메서드입니다.
  /// 필요한 곳이 있다면 사용하셔도 좋고,
  /// 다른 페이지에서 쓰여야 한다면 독립적인 위젯으로 분리해주세요.
  List<TextSpan> buildKeyValueSpan(String key, String value) {
    key = key + " ";
    value = value + "\n";
    return [
      TextSpan(
        text: key,
        style: const TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xff040404),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          height: 2,
        ),
      ),
      TextSpan(
        text: htmlToStringContent(value),
        style: const TextStyle(
            fontFamily: 'Roboto',
            color: Color(0x80080808),
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            height: 2),
      ),
    ];
  }

  List<TextSpan> _handleLocationInfo(ContentsDetail props) {
    List<TextSpan> locationInfo = [];
    if (props.address != null) {
      locationInfo.addAll(buildKeyValueSpan('주소', props.address!));
    }
    if (props.tel != null) {
      locationInfo.addAll(buildKeyValueSpan("전화", props.tel!));
    }
    if (props.homePage != null) {
      locationInfo.addAll(buildKeyValueSpan("홈페이지", props.homePage!));
    }
    return locationInfo;
  }

  /// 관광지의 위치, 신상 등 여러 정보를 렌더링합니다
  Widget buildLocationArea(ContentsDetail props) {
    List<TextSpan> locationInfo = _handleLocationInfo(props);
    if (locationInfo.length == 0) {
      return SizedBox();
    }
    // API에 가는 방법에 대한 데이터가 없어서 지도가 빠져있습니다
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '위치 및 가는 법',
            style: TextStyle(
              color: Color(0xff080808),
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // ** NEED REAL MAP HERE **
          // Image.asset('assets/icons/mapimage.png'),
          SizedBox(
            height: 10,
          ),
          RichText(text: new TextSpan(children: locationInfo))
        ],
      ),
    );
  }
}
