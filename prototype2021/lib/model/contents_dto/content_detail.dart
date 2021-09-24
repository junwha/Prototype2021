import 'package:prototype2021/model/contents_dto/content_preview.dart';
import 'package:prototype2021/model/contents_dto/content_type.dart';
import 'package:prototype2021/model/safe_http_dto/common.dart';

class ContentsDetailBase extends ContentPreviewBase {
  final double? rating;
  final int? reviewNo;

  final ContentType typeId;

  /// List of URLs of photos
  final List<String> photo;
  final int? zipCode;

  /// Homepage web url
  final String? homePage;

  /// Telephone number
  final String? tel;

  ContentsDetailBase.fromJson({required Map<String, dynamic> json})
      : typeId = idContentType[nullable<int>(json["typeid"]) ?? -1]!,
        zipCode = nullable<int>(json["zipcode"]),
        homePage = nullable<String>(json["homepage"]),
        tel = nullable<String>(json["tel"]),
        rating = nullable<double>(json["rating"]),
        reviewNo = nullable<int>(json["review_n"]),
        photo = (json["photo"] as List<dynamic>)
            .map((url) => url as String)
            .toList(),
        super.fromJson(json: json);
}

/// 관광지 Response
class ContentsDetail12 extends ContentsDetailBase {
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

  ContentsDetail12.fromJson({required Map<String, dynamic> json})
      : accomcount = nullable<int>(json["accomcount"]),
        chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
        chkcreditcard = nullable<bool>(json["chkcreditcard"]),
        chkpet = nullable<bool>(json["chkpet"]),
        expagerange = nullable<String>(json["expagerange"]),
        heritage1 = nullable<bool>(json["heritage1"]),
        heritage2 = nullable<bool>(json["heritage2"]),
        heritage3 = nullable<bool>(json["heritage3"]),
        infocenter = nullable<String>(json["infocenter"]),
        paking = nullable<String>(json["paking"]),
        opendate = nullable<String>(json["opendate"]),
        restdate = nullable<String>(json["restdate"]),
        useseason = nullable<String>(json["useseason"]),
        usetime = nullable<String>(json["usetime"]),
        super.fromJson(json: json);
}

/// 문화시설 Response
class ContentsDetail14 extends ContentsDetailBase {
  final int? accomcount;
  final bool? chkbabaycarriage;
  final bool? chkcreditcard;
  final bool? chkpet;
  final String? discountInfo;
  final String? infocenter;
  final String? parking;
  final String? parkingfee;
  final String? usefee;
  final String? usetime; // Date
  final String? restdate;
  final String? spendtime;
  final String? scale;

  ContentsDetail14.fromJson({required Map<String, dynamic> json})
      : accomcount = nullable<int>(json["accomcount"]),
        chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
        chkcreditcard = nullable<bool>(json["chkcreditcard"]),
        chkpet = nullable<bool>(json["chkpet"]),
        discountInfo = nullable<String>(json["discountInfo"]),
        infocenter = nullable<String>(json["infocenter"]),
        parking = nullable<String>(json["parking"]),
        parkingfee = nullable<String>(json["parkingfee"]),
        usefee = nullable<String>(json["usefee"]),
        usetime = nullable<String>(json["usetime"]),
        restdate = nullable<String>(json["restdate"]),
        spendtime = nullable<String>(json["spendtime"]),
        scale = nullable<String>(json["scale"]),
        super.fromJson(json: json);
}

/// 행사/공연/축제 Response
class ContentsDetail15 extends ContentsDetailBase {
  final int? agelimit;
  final String? bookingplace;
  final String? discountInfo;
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
  final String? spendtime;
  final int? usetimefestival;
  final int? accomcount;

  ContentsDetail15.fromJson({required Map<String, dynamic> json})
      : agelimit = nullable<int>(json["agelimit"]),
        bookingplace = nullable<String>(json["bookingplace"]),
        discountInfo = nullable<String>(json["discountInfo"]),
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
        super.fromJson(json: json);
}

/// 레포츠 Response
class ContentsDetail28 extends ContentsDetailBase {
  final int? accomcount;
  final bool? chkbabaycarriage;
  final bool? chkcreditcard;
  final bool? chkpet;
  final String? expagerange;
  final String? infocerter;
  final String? parking;
  final int? parkingfee;
  final String? reservation;
  final int? usefee;
  final String? openpriod;
  final String? usetime;
  final String? restdate;
  final String? scale;

  ContentsDetail28.fromJson({required Map<String, dynamic> json})
      : accomcount = nullable<int>(json["accomcount"]),
        chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
        chkcreditcard = nullable<bool>(json["chkcreditcard"]),
        chkpet = nullable<bool>(json["chkpet"]),
        expagerange = nullable<String>(json["expagerange"]),
        infocerter = nullable<String>(json["infocerter"]),
        parking = nullable<String>(json["parking"]),
        parkingfee = nullable<int>(json["parkingfee"]),
        reservation = nullable<String>(json["reservation"]),
        usefee = nullable<int>(json["usefee"]),
        openpriod = nullable<String>(json["openpriod"]),
        usetime = nullable<String>(json["usetime"]),
        restdate = nullable<String>(json["restdate"]),
        scale = nullable<String>(json["scale"]),
        super.fromJson(json: json);
}

/// 숙박 Response
class ContentsDetail32 extends ContentsDetailBase {
  final int? accomcount;
  final bool? benikia;
  final String? checkintime;
  final String? checkouttime;
  final bool? chkcooking;
  final String? foodplace;
  final bool? goodstay;
  final bool? hanok;
  final String? infocenter;
  final String? parking;
  final String? pickup;
  final int? roomcount;
  final String? reservation;
  final String? reservationurl;
  final String? roomtype;
  final String? scale;
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

  ContentsDetail32.fromJson({required Map<String, dynamic> json})
      : accomcount = nullable<int>(json["accomcount"]),
        benikia = nullable<bool>(json["benikia"]),
        checkintime = nullable<String>(json["checkintime"]),
        checkouttime = nullable<String>(json["checkouttime"]),
        chkcooking = nullable<bool>(json["chkcooking"]),
        foodplace = nullable<String>(json["foodplace"]),
        goodstay = nullable<bool>(json["goodstay"]),
        hanok = nullable<bool>(json["hanok"]),
        infocenter = nullable<String>(json["infocenter"]),
        parking = nullable<String>(json["parking"]),
        pickup = nullable<String>(json["pickup"]),
        roomcount = nullable<int>(json["roomcount"]),
        reservation = nullable<String>(json["reservation"]),
        reservationurl = nullable<String>(json["reservationurl"]),
        roomtype = nullable<String>(json["roomtype"]),
        scale = nullable<String>(json["scale"]),
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
        super.fromJson(json: json);
}

class ContentsDetail38 extends ContentsDetailBase {
  final bool? chkbabaycarriage;
  final bool? chkcreditcard;
  final bool? chkpet;
  final String? curturlcenter;
  final String? fairday; // Date
  final String? infocenter;
  final String? parking;
  final String? restroom;
  final String? saleitem;
  final String? saleitemcost;
  final String? shopguide;
  final String? opendate; // Date
  final String? opentime;
  final String? restdate;
  final String? scale;

  ContentsDetail38.fromJson({required Map<String, dynamic> json})
      : chkbabaycarriage = nullable<bool>(json["chkbabaycarriage"]),
        chkcreditcard = nullable<bool>(json["chkcreditcard"]),
        chkpet = nullable<bool>(json["chkpet"]),
        curturlcenter = nullable<String>(json["curturlcenter"]),
        fairday = nullable<String>(json["fairday"]),
        infocenter = nullable<String>(json["infocenter"]),
        parking = nullable<String>(json["parking"]),
        restroom = nullable<String>(json["restroom"]),
        saleitem = nullable<String>(json["saleitem"]),
        saleitemcost = nullable<String>(json["saleitemcost"]),
        shopguide = nullable<String>(json["shopguide"]),
        opendate = nullable<String>(json["opendate"]),
        opentime = nullable<String>(json["opentime"]),
        restdate = nullable<String>(json["restdate"]),
        scale = nullable<String>(json["scale"]),
        super.fromJson(json: json);
}

class ContentsDetail39 extends ContentsDetailBase {
  final bool? chkcreditcard;
  final String? discountInfo;
  final String? firstmenu;
  final String? infocenter;
  final String? expagerange;
  final String? kidsfacility;
  final bool? packing;
  final String? parking;
  final String? reservation;
  final int? seat;
  final bool? smoking;
  final String? treatmenu;
  final String? opendate; // Date
  final String? opentime;
  final String? restdate;
  final int? lcnson;

  ContentsDetail39.fromJson({required Map<String, dynamic> json})
      : chkcreditcard = nullable<bool>(json["chkcreditcard"]),
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
        super.fromJson(json: json);
}
