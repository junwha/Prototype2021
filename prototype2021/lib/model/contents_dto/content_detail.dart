import 'package:prototype2021/model/contents_dto/content_preview.dart';
import 'package:prototype2021/model/contents_dto/content_type.dart';

class ContentsDetailBase extends ContentPreviewBase {
  final double rating;
  final int reviewNo;

  final ContentType typeId;

  /// List of URLs of photos
  final List<String> photo;
  final int zipCode;

  /// Homepage web url
  final String homePage;

  /// Telephone number
  final String tel;

  ContentsDetailBase.fromJson({required Map<String, dynamic> json})
      : typeId = idContentType[json["typeid"] as int]!,
        photo = json["photo"] as List<String>,
        zipCode = json["zipcode"] as int,
        homePage = json["homepage"] as String,
        tel = json["tel"] as String,
        rating = json["rating"] as double,
        reviewNo = json["review_no"] as int,
        super.fromJson(json: json);
}

/// 관광지 Response
class ContentsDetail12 extends ContentsDetailBase {
  final int accomcount;
  final bool chkbabaycarriage;
  final bool chkcreditcard;
  final bool chkpet;
  final String expagerange;
  final bool heritage1;
  final bool heritage2;
  final bool heritage3;
  final String infocenter;
  final String paking;
  final String opendate; // Date
  final String restdate; // Date
  final String useseason; // Date
  final String usetime; // Date

  ContentsDetail12.fromJson({required Map<String, dynamic> json})
      : accomcount = json["accomcount"] as int,
        chkbabaycarriage = json["chkbabaycarriage"] as bool,
        chkcreditcard = json["chkcreditcard"] as bool,
        chkpet = json["chkpet"] as bool,
        expagerange = json["expagerange"] as String,
        heritage1 = json["heritage1"] as bool,
        heritage2 = json["heritage2"] as bool,
        heritage3 = json["heritage3"] as bool,
        infocenter = json["infocenter"] as String,
        paking = json["paking"] as String,
        opendate = json["opendate"] as String,
        restdate = json["restdate"] as String,
        useseason = json["useseason"] as String,
        usetime = json["usetime"] as String,
        super.fromJson(json: json);
}

/// 문화시설 Response
class ContentsDetail14 extends ContentsDetailBase {
  final int accomcount;
  final bool chkbabaycarriage;
  final bool chkcreditcard;
  final bool chkpet;
  final String discountInfo;
  final String infocenter;
  final String parking;
  final String parkingfee;
  final String usefee;
  final String usetime; // Date
  final String restdate;
  final String spendtime;
  final String scale;

  ContentsDetail14.fromJson({required Map<String, dynamic> json})
      : accomcount = json["accomcount"] as int,
        chkbabaycarriage = json["chkbabaycarriage"] as bool,
        chkcreditcard = json["chkcreditcard"] as bool,
        chkpet = json["chkpet"] as bool,
        discountInfo = json["discountInfo"] as String,
        infocenter = json["infocenter"] as String,
        parking = json["parking"] as String,
        parkingfee = json["parkingfee"] as String,
        usefee = json["usefee"] as String,
        usetime = json["usetime"] as String,
        restdate = json["restdate"] as String,
        spendtime = json["spendtime"] as String,
        scale = json["scale"] as String,
        super.fromJson(json: json);
}

/// 행사/공연/축제 Response
class ContentsDetail15 extends ContentsDetailBase {
  final int agelimit;
  final String bookingplace;
  final String discountInfo;
  final String homepage;
  final String grade;
  final String place;
  final String placeinfo;
  final String program;
  final String sponsor1;
  final String sponsor1tel;
  final String sponsor2;
  final String sponsor2tel;
  final String subevent;
  final String startdate; // Date
  final String enddate; // Date
  final String playtime;
  final String spendtime;
  final int usetimefestival;
  final int accomcount;

  ContentsDetail15.fromJson({required Map<String, dynamic> json})
      : agelimit = json["agelimit"] as int,
        bookingplace = json["bookingplace"] as String,
        discountInfo = json["discountInfo"] as String,
        homepage = json["homepage"] as String,
        grade = json["grade"] as String,
        place = json["place"] as String,
        placeinfo = json["placeinfo"] as String,
        program = json["program"] as String,
        sponsor1 = json["sponsor1"] as String,
        sponsor1tel = json["sponsor1tel"] as String,
        sponsor2 = json["sponsor2"] as String,
        sponsor2tel = json["sponsor2tel"] as String,
        subevent = json["subevent"] as String,
        startdate = json["startdate"] as String,
        enddate = json["enddate"] as String,
        playtime = json["playtime"] as String,
        spendtime = json["spendtime"] as String,
        usetimefestival = json["usetimefestival"] as int,
        accomcount = json["accomcount"] as int,
        super.fromJson(json: json);
}

/// 레포츠 Response
class ContentsDetail28 extends ContentsDetailBase {
  final int accomcount;
  final bool chkbabaycarriage;
  final bool chkcreditcard;
  final bool chkpet;
  final String expagerange;
  final String infocerter;
  final String parking;
  final int parkingfee;
  final String reservation;
  final int usefee;
  final String openpriod;
  final String usetime;
  final String restdate;
  final String scale;

  ContentsDetail28.fromJson({required Map<String, dynamic> json})
      : accomcount = json["accomcount"] as int,
        chkbabaycarriage = json["chkbabaycarriage"] as bool,
        chkcreditcard = json["chkcreditcard"] as bool,
        chkpet = json["chkpet"] as bool,
        expagerange = json["expagerange"] as String,
        infocerter = json["infocerter"] as String,
        parking = json["parking"] as String,
        parkingfee = json["parkingfee"] as int,
        reservation = json["reservation"] as String,
        usefee = json["usefee"] as int,
        openpriod = json["openpriod"] as String,
        usetime = json["usetime"] as String,
        restdate = json["restdate"] as String,
        scale = json["scale"] as String,
        super.fromJson(json: json);
}

/// 숙박 Response
class ContentsDetail32 extends ContentsDetailBase {
  final int accomcount;
  final bool benikia;
  final String checkintime;
  final String checkouttime;
  final bool chkcooking;
  final String foodplace;
  final bool goodstay;
  final bool hanok;
  final String infocenter;
  final String parking;
  final String pickup;
  final int roomcount;
  final String reservation;
  final String reservationurl;
  final String roomtype;
  final String scale;
  final String subfacility;
  final bool barbecue;
  final bool beverage;
  final bool campfire;
  final bool fitness;
  final bool karooke;
  final bool publicbath;
  final bool pubblicpc;
  final bool seminar;
  final bool sports;
  final String refundregulation;

  ContentsDetail32.fromJson({required Map<String, dynamic> json})
      : accomcount = json["accomcount"] as int,
        benikia = json["benikia"] as bool,
        checkintime = json["checkintime"] as String,
        checkouttime = json["checkouttime"] as String,
        chkcooking = json["chkcooking"] as bool,
        foodplace = json["foodplace"] as String,
        goodstay = json["goodstay"] as bool,
        hanok = json["hanok"] as bool,
        infocenter = json["infocenter"] as String,
        parking = json["parking"] as String,
        pickup = json["pickup"] as String,
        roomcount = json["roomcount"] as int,
        reservation = json["reservation"] as String,
        reservationurl = json["reservationurl"] as String,
        roomtype = json["roomtype"] as String,
        scale = json["scale"] as String,
        subfacility = json["subfacility"] as String,
        barbecue = json["barbecue"] as bool,
        beverage = json["beverage"] as bool,
        campfire = json["campfire"] as bool,
        fitness = json["fitness"] as bool,
        karooke = json["karooke"] as bool,
        publicbath = json["publicbath"] as bool,
        pubblicpc = json["pubblicpc"] as bool,
        seminar = json["seminar"] as bool,
        sports = json["sports"] as bool,
        refundregulation = json["refundregulation"] as String,
        super.fromJson(json: json);
}

class ContentsDetail38 extends ContentsDetailBase {
  final bool chkbabaycarriage;
  final bool chkcreditcard;
  final bool chkpet;
  final String curturlcenter;
  final String fairday; // Date
  final String infocenter;
  final String parking;
  final String restroom;
  final String saleitem;
  final String saleitemcost;
  final String shopguide;
  final String opendate; // Date
  final String opentime;
  final String restdate;
  final String scale;

  ContentsDetail38.fromJson({required Map<String, dynamic> json})
      : chkbabaycarriage = json["chkbabaycarriage"] as bool,
        chkcreditcard = json["chkcreditcard"] as bool,
        chkpet = json["chkpet"] as bool,
        curturlcenter = json["curturlcenter"] as String,
        fairday = json["fairday"] as String,
        infocenter = json["infocenter"] as String,
        parking = json["parking"] as String,
        restroom = json["restroom"] as String,
        saleitem = json["saleitem"] as String,
        saleitemcost = json["saleitemcost"] as String,
        shopguide = json["shopguide"] as String,
        opendate = json["opendate"] as String,
        opentime = json["opentime"] as String,
        restdate = json["restdate"] as String,
        scale = json["scale"] as String,
        super.fromJson(json: json);
}

class ContentsDetail39 extends ContentsDetailBase {
  final bool chkcreditcard;
  final String discountInfo;
  final String firstmenu;
  final String infocenter;
  final String expagerange;
  final String kidsfacility;
  final bool packing;
  final String parking;
  final String reservation;
  final int seat;
  final bool smoking;
  final String treatmenu;
  final String opendate; // Date
  final String opentime;
  final String restdate;
  final int lcnson;

  ContentsDetail39.fromJson({required Map<String, dynamic> json})
      : chkcreditcard = json["chkcreditcard"] as bool,
        discountInfo = json["discountInfo"] as String,
        firstmenu = json["firstmenu"] as String,
        infocenter = json["infocenter"] as String,
        expagerange = json["expagerange"] as String,
        kidsfacility = json["kidsfacility"] as String,
        packing = json["packing"] as bool,
        parking = json["parking"] as String,
        reservation = json["reservation"] as String,
        seat = json["seat"] as int,
        smoking = json["smoking"] as bool,
        treatmenu = json["treatmenu"] as String,
        opendate = json["opendate"] as String,
        opentime = json["opentime"] as String,
        restdate = json["restdate"] as String,
        lcnson = json["lcnson"] as int,
        super.fromJson(json: json);
}
