import 'package:prototype2021/model/contents_dto/content_preview.dart';
import 'package:prototype2021/model/contents_dto/content_type.dart';
import 'package:prototype2021/model/safe_http_dto/common.dart';

class ContentsDetail extends ContentPreviewBase {
  final int? rating;
  final double? reviewNo;

  final ContentType typeId;

  /// List of URLs of photos
  final List<String> photo;
  final String? zipCode;

  /// Homepage web url
  final String? homePage;

  /// Telephone number
  final String? tel;

  /// Detail Info, use abstract classes for each types
  final DetailInfo detailInfo;

  ContentsDetail.fromJson({required Map<String, dynamic> json})
      : typeId =
            idContentType[nullable<int>(json["typeid"])] ?? ContentType.unknown,
        zipCode = nullable<String>(json["zipcode"]),
        homePage = nullable<String>(json["homepage"]),
        tel = nullable<String>(json["tel"]),
        rating = nullable<int>(json["rating"]),
        reviewNo = nullable<double>(json["review_n"]),
        photo = (json["photo"] as List<dynamic>)
            .map((url) => url as String)
            .toList(),
        detailInfo = DetailInfo.fromJson(json: json),
        super.fromJson(json: json);
}

class DetailInfo
    implements
        ContentsDetail12,
        ContentsDetail14,
        ContentsDetail15,
        ContentsDetail28,
        ContentsDetail32,
        ContentsDetail38,
        ContentsDetail39 {
  final int? accomcount;
  final bool? chkbabaycarriage;
  final bool? chkcreditcard;
  final bool? chkpet;
  final String? expagerange;
  final bool? heritage1;
  final bool? heritage2;
  final bool? heritage3;
  final String? infocenter;
  final String? paking;
  final String? opendate; // Date
  final String? restdate; // Date
  final String? useseason; // Date
  final String? usetime; // Date
  final String? discountInfo;
  final String? parking;
  final String? parkingfee;
  final String? usefee;
  final String? spendtime;
  final String? scale;
  final int? agelimit;
  final String? bookingplace;
  final String? homepage;
  final String? grade;
  final String? place;
  final String? placeinfo;
  final String? program;
  final String? sponsor1;
  final String? sponsor1tel;
  final String? sponsor2;
  final String? sponsor2tel;
  final String? subevent;
  final String? startdate; // Date
  final String? enddate; // Date
  final String? playtime;
  final int? usetimefestival;
  final String? infocerter;
  // final int? parkingfee;
  final String? reservation;
  // final int? usefee;
  final String? openpriod;
  final bool? benikia;
  final String? checkintime;
  final String? checkouttime;
  final bool? chkcooking;
  final String? foodplace;
  final bool? goodstay;
  final bool? hanok;
  final String? pickup;
  final int? roomcount;
  final String? reservationurl;
  final String? roomtype;
  final String? subfacility;
  final bool? barbecue;
  final bool? beverage;
  final bool? campfire;
  final bool? fitness;
  final bool? karooke;
  final bool? publicbath;
  final bool? pubblicpc;
  final bool? seminar;
  final bool? sports;
  final String? refundregulation;
  final String? curturlcenter;
  final String? fairday; // Date
  final String? restroom;
  final String? saleitem;
  final String? saleitemcost;
  final String? shopguide;
  final String? opentime;
  final String? firstmenu;
  final String? kidsfacility;
  final bool? packing;
  final int? seat;
  final bool? smoking;
  final String? treatmenu;
  final int? lcnson;

  DetailInfo.fromJson({required Map<String, dynamic> json})
      : agelimit = nullable<int>(json["agelimit"]),
        discountInfo = nullable<String>(json["discountInfo"]),
        firstmenu = nullable<String>(json["firstmenu"]),
        infocenter = nullable<String>(json["infocenter"]),
        expagerange = nullable<String>(json["expagerange"]),
        kidsfacility = nullable<String>(json["kidsfacility"]),
        packing = nullable<bool>(json["packing"]),
        parking = nullable<String>(json["parking"]),
        reservation = nullable<String>(json["reservation"]),
        seat = nullable<int>(json["seat"]),
        smoking = nullable<bool>(json["smoking"]),
        treatmenu = nullable<String>(json["treatmenu"]),
        opendate = nullable<String>(json["opendate"]),
        opentime = nullable<String>(json["opentime"]),
        restdate = nullable<String>(json["restdate"]),
        lcnson = nullable<int>(json["lcnson"]),
        chkcreditcard = nullable<bool>(json["chkcreditcard"]),
        chkpet = nullable<bool>(json["chkpet"]),
        curturlcenter = nullable<String>(json["curturlcenter"]),
        fairday = nullable<String>(json["fairday"]),
        restroom = nullable<String>(json["restroom"]),
        saleitem = nullable<String>(json["saleitem"]),
        saleitemcost = nullable<String>(json["saleitemcost"]),
        shopguide = nullable<String>(json["shopguide"]),
        scale = nullable<String>(json["scale"]),
        benikia = nullable<bool>(json["benikia"]),
        checkintime = nullable<String>(json["checkintime"]),
        checkouttime = nullable<String>(json["checkouttime"]),
        chkcooking = nullable<bool>(json["chkcooking"]),
        foodplace = nullable<String>(json["foodplace"]),
        goodstay = nullable<bool>(json["goodstay"]),
        hanok = nullable<bool>(json["hanok"]),
        pickup = nullable<String>(json["pickup"]),
        roomcount = nullable<int>(json["roomcount"]),
        reservationurl = nullable<String>(json["reservationurl"]),
        roomtype = nullable<String>(json["roomtype"]),
        subfacility = nullable<String>(json["subfacility"]),
        barbecue = nullable<bool>(json["barbecue"]),
        beverage = nullable<bool>(json["beverage"]),
        campfire = nullable<bool>(json["campfire"]),
        fitness = nullable<bool>(json["fitness"]),
        karooke = nullable<bool>(json["karooke"]),
        publicbath = nullable<bool>(json["publicbath"]),
        pubblicpc = nullable<bool>(json["pubblicpc"]),
        seminar = nullable<bool>(json["seminar"]),
        sports = nullable<bool>(json["sports"]),
        refundregulation = nullable<String>(json["refundregulation"]),
        chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
        infocerter = nullable<String>(json["infocerter"]),
        openpriod = nullable<String>(json["openpriod"]),
        usetime = nullable<String>(json["usetime"]),
        bookingplace = nullable<String>(json["bookingplace"]),
        homepage = nullable<String>(json["homepage"]),
        grade = nullable<String>(json["grade"]),
        place = nullable<String>(json["place"]),
        placeinfo = nullable<String>(json["placeinfo"]),
        program = nullable<String>(json["program"]),
        sponsor1 = nullable<String>(json["sponsor1"]),
        sponsor1tel = nullable<String>(json["sponsor1tel"]),
        sponsor2 = nullable<String>(json["sponsor2"]),
        sponsor2tel = nullable<String>(json["sponsor2tel"]),
        subevent = nullable<String>(json["subevent"]),
        startdate = nullable<String>(json["startdate"]),
        enddate = nullable<String>(json["enddate"]),
        playtime = nullable<String>(json["playtime"]),
        spendtime = nullable<String>(json["spendtime"]),
        usetimefestival = nullable<int>(json["usetimefestival"]),
        accomcount = nullable<int>(json["accomcount"]),
        parkingfee = nullable<String>(json["parkingfee"]),
        usefee = nullable<String>(json["usefee"]),
        heritage1 = nullable<bool>(json["heritage1"]),
        heritage2 = nullable<bool>(json["heritage2"]),
        heritage3 = nullable<bool>(json["heritage3"]),
        paking = nullable<String>(json["paking"]),
        useseason = nullable<String>(json["useseason"]);
}

/// 관광지 Response
abstract class ContentsDetail12 {
  abstract final int? accomcount;
  abstract final bool? chkbabaycarriage;
  abstract final bool? chkcreditcard;
  abstract final bool? chkpet;
  abstract final String? expagerange;
  abstract final bool? heritage1;
  abstract final bool? heritage2;
  abstract final bool? heritage3;
  abstract final String? infocenter;
  abstract final String? paking;
  abstract final String? opendate; // Date
  abstract final String? restdate; // Date
  abstract final String? useseason; // Date
  abstract final String? usetime; // Date

  // ContentsDetail12.fromJson({required Map<String, dynamic> json})
  //     : accomcount = nullable<int>(json["accomcount"]),
  //       chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
  //       chkcreditcard = nullable<bool>(json["chkcreditcard"]),
  //       chkpet = nullable<bool>(json["chkpet"]),
  //       expagerange = nullable<String>(json["expagerange"]),
  //       heritage1 = nullable<bool>(json["heritage1"]),
  //       heritage2 = nullable<bool>(json["heritage2"]),
  //       heritage3 = nullable<bool>(json["heritage3"]),
  //       infocenter = nullable<String>(json["infocenter"]),
  //       paking = nullable<String>(json["paking"]),
  //       opendate = nullable<String>(json["opendate"]),
  //       restdate = nullable<String>(json["restdate"]),
  //       useseason = nullable<String>(json["useseason"]),
  //       usetime = nullable<String>(json["usetime"]),
  //       super.fromJson(json: json);
}

/// 문화시설 Response
abstract class ContentsDetail14 {
  abstract final int? accomcount;
  abstract final bool? chkbabaycarriage;
  abstract final bool? chkcreditcard;
  abstract final bool? chkpet;
  abstract final String? discountInfo;
  abstract final String? infocenter;
  abstract final String? parking;
  abstract final String? parkingfee;
  abstract final String? usefee;
  abstract final String? usetime; // Date
  abstract final String? restdate;
  abstract final String? spendtime;
  abstract final String? scale;

  // ContentsDetail14.fromJson({required Map<String, dynamic> json})
  //     : accomcount = nullable<int>(json["accomcount"]),
  //       chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
  //       chkcreditcard = nullable<bool>(json["chkcreditcard"]),
  //       chkpet = nullable<bool>(json["chkpet"]),
  //       discountInfo = nullable<String>(json["discountInfo"]),
  //       infocenter = nullable<String>(json["infocenter"]),
  //       parking = nullable<String>(json["parking"]),
  //       parkingfee = nullable<String>(json["parkingfee"]),
  //       usefee = nullable<String>(json["usefee"]),
  //       usetime = nullable<String>(json["usetime"]),
  //       restdate = nullable<String>(json["restdate"]),
  //       spendtime = nullable<String>(json["spendtime"]),
  //       scale = nullable<String>(json["scale"]),
  //       super.fromJson(json: json);
}

/// 행사/공연/축제 Response
abstract class ContentsDetail15 {
  abstract final int? agelimit;
  abstract final String? bookingplace;
  abstract final String? discountInfo;
  abstract final String? homepage;
  abstract final String? grade;
  abstract final String? place;
  abstract final String? placeinfo;
  abstract final String? program;
  abstract final String? sponsor1;
  abstract final String? sponsor1tel;
  abstract final String? sponsor2;
  abstract final String? sponsor2tel;
  abstract final String? subevent;
  abstract final String? startdate; // Date
  abstract final String? enddate; // Date
  abstract final String? playtime;
  abstract final String? spendtime;
  abstract final int? usetimefestival;
  abstract final int? accomcount;

  // ContentsDetail15.fromJson({required Map<String, dynamic> json})
  //     : agelimit = nullable<int>(json["agelimit"]),
  //       bookingplace = nullable<String>(json["bookingplace"]),
  //       discountInfo = nullable<String>(json["discountInfo"]),
  //       homepage = nullable<String>(json["homepage"]),
  //       grade = nullable<String>(json["grade"]),
  //       place = nullable<String>(json["place"]),
  //       placeinfo = nullable<String>(json["placeinfo"]),
  //       program = nullable<String>(json["program"]),
  //       sponsor1 = nullable<String>(json["sponsor1"]),
  //       sponsor1tel = nullable<String>(json["sponsor1tel"]),
  //       sponsor2 = nullable<String>(json["sponsor2"]),
  //       sponsor2tel = nullable<String>(json["sponsor2tel"]),
  //       subevent = nullable<String>(json["subevent"]),
  //       startdate = nullable<String>(json["startdate"]),
  //       enddate = nullable<String>(json["enddate"]),
  //       playtime = nullable<String>(json["playtime"]),
  //       spendtime = nullable<String>(json["spendtime"]),
  //       usetimefestival = nullable<int>(json["usetimefestival"]),
  //       accomcount = nullable<int>(json["accomcount"]),
  //       super.fromJson(json: json);
}

/// 레포츠 Response
abstract class ContentsDetail28 {
  abstract final int? accomcount;
  abstract final bool? chkbabaycarriage;
  abstract final bool? chkcreditcard;
  abstract final bool? chkpet;
  abstract final String? expagerange;
  abstract final String? infocerter;
  abstract final String? parking;
  // abstract final int? parkingfee;
  abstract final String? parkingfee;
  abstract final String? reservation;
  // abstract final int? usefee;
  abstract final String? usefee;
  abstract final String? openpriod;
  abstract final String? usetime;
  abstract final String? restdate;
  abstract final String? scale;

  // ContentsDetail28.fromJson({required Map<String, dynamic> json})
  //     : accomcount = nullable<int>(json["accomcount"]),
  //       chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
  //       chkcreditcard = nullable<bool>(json["chkcreditcard"]),
  //       chkpet = nullable<bool>(json["chkpet"]),
  //       expagerange = nullable<String>(json["expagerange"]),
  //       infocerter = nullable<String>(json["infocerter"]),
  //       parking = nullable<String>(json["parking"]),
  //       parkingfee = nullable<int>(json["parkingfee"]),
  //       reservation = nullable<String>(json["reservation"]),
  //       usefee = nullable<int>(json["usefee"]),
  //       openpriod = nullable<String>(json["openpriod"]),
  //       usetime = nullable<String>(json["usetime"]),
  //       restdate = nullable<String>(json["restdate"]),
  //       scale = nullable<String>(json["scale"]),
  //       super.fromJson(json: json);
}

/// 숙박 Response
abstract class ContentsDetail32 {
  abstract final int? accomcount;
  abstract final bool? benikia;
  abstract final String? checkintime;
  abstract final String? checkouttime;
  abstract final bool? chkcooking;
  abstract final String? foodplace;
  abstract final bool? goodstay;
  abstract final bool? hanok;
  abstract final String? infocenter;
  abstract final String? parking;
  abstract final String? pickup;
  abstract final int? roomcount;
  abstract final String? reservation;
  abstract final String? reservationurl;
  abstract final String? roomtype;
  abstract final String? scale;
  abstract final String? subfacility;
  abstract final bool? barbecue;
  abstract final bool? beverage;
  abstract final bool? campfire;
  abstract final bool? fitness;
  abstract final bool? karooke;
  abstract final bool? publicbath;
  abstract final bool? pubblicpc;
  abstract final bool? seminar;
  abstract final bool? sports;
  abstract final String? refundregulation;

  // ContentsDetail32.fromJson({required Map<String, dynamic> json})
  //     : accomcount = nullable<int>(json["accomcount"]),
  //       benikia = nullable<bool>(json["benikia"]),
  //       checkintime = nullable<String>(json["checkintime"]),
  //       checkouttime = nullable<String>(json["checkouttime"]),
  //       chkcooking = nullable<bool>(json["chkcooking"]),
  //       foodplace = nullable<String>(json["foodplace"]),
  //       goodstay = nullable<bool>(json["goodstay"]),
  //       hanok = nullable<bool>(json["hanok"]),
  //       infocenter = nullable<String>(json["infocenter"]),
  //       parking = nullable<String>(json["parking"]),
  //       pickup = nullable<String>(json["pickup"]),
  //       roomcount = nullable<int>(json["roomcount"]),
  //       reservation = nullable<String>(json["reservation"]),
  //       reservationurl = nullable<String>(json["reservationurl"]),
  //       roomtype = nullable<String>(json["roomtype"]),
  //       scale = nullable<String>(json["scale"]),
  //       subfacility = nullable<String>(json["subfacility"]),
  //       barbecue = nullable<bool>(json["barbecue"]),
  //       beverage = nullable<bool>(json["beverage"]),
  //       campfire = nullable<bool>(json["campfire"]),
  //       fitness = nullable<bool>(json["fitness"]),
  //       karooke = nullable<bool>(json["karooke"]),
  //       publicbath = nullable<bool>(json["publicbath"]),
  //       pubblicpc = nullable<bool>(json["pubblicpc"]),
  //       seminar = nullable<bool>(json["seminar"]),
  //       sports = nullable<bool>(json["sports"]),
  //       refundregulation = nullable<String>(json["refundregulation"]),
  //       super.fromJson(json: json);
}

abstract class ContentsDetail38 {
  abstract final bool? chkbabaycarriage;
  abstract final bool? chkcreditcard;
  abstract final bool? chkpet;
  abstract final String? curturlcenter;
  abstract final String? fairday; // Date
  abstract final String? infocenter;
  abstract final String? parking;
  abstract final String? restroom;
  abstract final String? saleitem;
  abstract final String? saleitemcost;
  abstract final String? shopguide;
  abstract final String? opendate; // Date
  abstract final String? opentime;
  abstract final String? restdate;
  abstract final String? scale;

  // ContentsDetail38.fromJson({required Map<String, dynamic> json})
  //     : chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
  //       chkcreditcard = nullable<bool>(json["chkcreditcard"]),
  //       chkpet = nullable<bool>(json["chkpet"]),
  //       curturlcenter = nullable<String>(json["curturlcenter"]),
  //       fairday = nullable<String>(json["fairday"]),
  //       infocenter = nullable<String>(json["infocenter"]),
  //       parking = nullable<String>(json["parking"]),
  //       restroom = nullable<String>(json["restroom"]),
  //       saleitem = nullable<String>(json["saleitem"]),
  //       saleitemcost = nullable<String>(json["saleitemcost"]),
  //       shopguide = nullable<String>(json["shopguide"]),
  //       opendate = nullable<String>(json["opendate"]),
  //       opentime = nullable<String>(json["opentime"]),
  //       restdate = nullable<String>(json["restdate"]),
  //       scale = nullable<String>(json["scale"]),
  //       super.fromJson(json: json);
}

abstract class ContentsDetail39 {
  abstract final bool? chkcreditcard;
  abstract final String? discountInfo;
  abstract final String? firstmenu;
  abstract final String? infocenter;
  abstract final String? expagerange;
  abstract final String? kidsfacility;
  abstract final bool? packing;
  abstract final String? parking;
  abstract final String? reservation;
  abstract final int? seat;
  abstract final bool? smoking;
  abstract final String? treatmenu;
  abstract final String? opendate; // Date
  abstract final String? opentime;
  abstract final String? restdate;
  abstract final int? lcnson;

  // ContentsDetail39.fromJson({required Map<String, dynamic> json})
  //     : chkcreditcard = nullable<bool>(json["chkcreditcard"]),
  //       discountInfo = nullable<String>(json["discountInfo"]),
  //       firstmenu = nullable<String>(json["firstmenu"]),
  //       infocenter = nullable<String>(json["infocenter"]),
  //       expagerange = nullable<String>(json["expagerange"]),
  //       kidsfacility = nullable<String>(json["kidsfacility"]),
  //       packing = nullable<bool>(json["packing"]),
  //       parking = nullable<String>(json["parking"]),
  //       reservation = nullable<String>(json["reservation"]),
  //       seat = nullable<int>(json["seat"]),
  //       smoking = nullable<bool>(json["smoking"]),
  //       treatmenu = nullable<String>(json["treatmenu"]),
  //       opendate = nullable<String>(json["opendate"]),
  //       opentime = nullable<String>(json["opentime"]),
  //       restdate = nullable<String>(json["restdate"]),
  //       lcnson = nullable<int>(json["lcnson"]),
  //       super.fromJson(json: json);
}
