import 'package:prototype2021/model/contents_dto/content_preview.dart';
import 'package:prototype2021/model/contents_dto/content_type.dart';
import 'package:prototype2021/model/safe_http_dto/common.dart';

class ContentsDetail extends ContentPreview {
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

class DetailInfo {
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
  final String? agelimit;
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
  final String? eventstartdate; // Date
  final String? eventenddate; // Date
  final String? playtime;
  final String? usetimefestival;
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
  final int? accomcountculture;
  final bool? chkbabaycarriageculture;
  final bool? chkcreditcardculture;
  final bool? chkpetculture;
  final String? infocenterculture;
  final String? parkingculture;
  final String? parkingfeeculture;
  final String? usetimeculture; // Date
  final String? restdateculture;
  final String? discountinfofestival;
  final String? eventhomepage;
  final String? festivalgrade;
  final String? eventplace;
  final int? accomcountleports;
  final bool? chkbabaycarriageleports;
  final bool? chkcreditcardleports;
  final bool? chkpetleports;
  final String? expagerangeleports;
  final String? infocerterleports;
  final String? parkingleports;
  final String? parkingfeeleports;
  final String? usefeeleports;
  final String? usetimeleports;
  final String? restdateleports;
  final String? scaleleports;
  final bool? chkbabaycarriageshopping;
  final bool? chkcreditcardshopping;
  final bool? chkpetshopping;
  final String? infocentershopping;
  final String? parkingshopping;
  final String? opendateshopping; // Date
  final String? restdateshopping;
  final bool? chkcreditcardfood;
  final String? discountInfofood;
  final String? infocenterfood;
  final String? parkingfood;
  final String? reservationfood;
  final String? opendatefood; // Date
  final String? opentimefood;

  DetailInfo.fromJson({required Map<String, dynamic> json})
      : agelimit = nullable<String>(json["detailInfo"]["agelimit"]),
        chkcreditcardfood =
            nullable<bool>(json["detailInfo"]["chkcreditcardfood"]),
        discountInfofood =
            nullable<String>(json["detailInfo"]["discountInfofood"]),
        infocenterfood = nullable<String>(json["detailInfo"]["infocenterfood"]),
        parkingfood = nullable<String>(json["detailInfo"]["parkingfood"]),
        reservationfood =
            nullable<String>(json["detailInfo"]["reservationfood"]),
        opendatefood = nullable<String>(json["detailInfo"]["opendatefood"]),
        opentimefood = nullable<String>(json["detailInfo"]["opentimefood"]),
        chkbabaycarriageshopping =
            nullable<bool>(json["detailInfo"]["chkbabaycarriageshopping"]),
        chkcreditcardshopping =
            nullable<bool>(json["detailInfo"]["chkcreditcardshopping"]),
        chkpetshopping = nullable<bool>(json["detailInfo"]["chkpetshopping"]),
        infocentershopping =
            nullable<String>(json["detailInfo"]["infocentershopping"]),
        parkingshopping =
            nullable<String>(json["detailInfo"]["parkingshopping"]),
        opendateshopping =
            nullable<String>(json["detailInfo"]["opendateshopping"]),
        restdateshopping =
            nullable<String>(json["detailInfo"]["restdateshopping"]),
        accomcountleports =
            nullable<int>(json["detailInfo"]["accomcountleports"]),
        chkbabaycarriageleports =
            nullable<bool>(json["detailInfo"]["chkbabaycarriageleports"]),
        chkcreditcardleports =
            nullable<bool>(json["detailInfo"]["chkcreditcardleports"]),
        chkpetleports = nullable<bool>(json["detailInfo"]["chkpetleports"]),
        expagerangeleports =
            nullable<String>(json["detailInfo"]["expagerangeleports"]),
        infocerterleports =
            nullable<String>(json["detailInfo"]["infocerterleports"]),
        parkingleports = nullable<String>(json["detailInfo"]["parkingleports"]),
        parkingfeeleports =
            nullable<String>(json["detailInfo"]["parkingfeeleports"]),
        usefeeleports = nullable<String>(json["detailInfo"]["usefeeleports"]),
        usetimeleports = nullable<String>(json["detailInfo"]["usetimeleports"]),
        restdateleports =
            nullable<String>(json["detailInfo"]["restdateleports"]),
        scaleleports = nullable<String>(json["detailInfo"]["scaleleports"]),
        discountinfofestival =
            nullable<String>(json["detailInfo"]["discountinfofestival"]),
        eventhomepage = nullable<String>(json["detailInfo"]["eventhomepage"]),
        festivalgrade = nullable<String>(json["detailInfo"]["festivalgrade"]),
        eventplace = nullable<String>(json["detailInfo"]["eventplace"]),
        accomcountculture =
            nullable<int>(json["detailInfo"]["accomcountculture"]),
        chkbabaycarriageculture =
            nullable<bool>(json["detailInfo"]["chkbabaycarriageculture"]),
        chkcreditcardculture =
            nullable<bool>(json["detailInfo"]["chkcreditcardculture"]),
        chkpetculture = nullable<bool>(json["detailInfo"]["chkpetculture"]),
        infocenterculture =
            nullable<String>(json["detailInfo"]["infocenterculture"]),
        parkingculture = nullable<String>(json["detailInfo"]["parkingculture"]),
        parkingfeeculture =
            nullable<String>(json["detailInfo"]["parkingfeeculture"]),
        usetimeculture = nullable<String>(json["detailInfo"]["usetimeculture"]),
        restdateculture =
            nullable<String>(json["detailInfo"]["restdateculture"]),
        discountInfo = nullable<String>(json["detailInfo"]["discountInfo"]),
        firstmenu = nullable<String>(json["detailInfo"]["firstmenu"]),
        infocenter = nullable<String>(json["detailInfo"]["infocenter"]),
        expagerange = nullable<String>(json["detailInfo"]["expagerange"]),
        kidsfacility = nullable<String>(json["detailInfo"]["kidsfacility"]),
        packing = nullable<bool>(json["detailInfo"]["packing"]),
        parking = nullable<String>(json["detailInfo"]["parking"]),
        reservation = nullable<String>(json["detailInfo"]["reservation"]),
        seat = nullable<int>(json["detailInfo"]["seat"]),
        smoking = nullable<bool>(json["detailInfo"]["smoking"]),
        treatmenu = nullable<String>(json["detailInfo"]["treatmenu"]),
        opendate = nullable<String>(json["detailInfo"]["opendate"]),
        opentime = nullable<String>(json["detailInfo"]["opentime"]),
        restdate = nullable<String>(json["detailInfo"]["restdate"]),
        lcnson = nullable<int>(json["detailInfo"]["lcnson"]),
        chkcreditcard = nullable<bool>(json["detailInfo"]["chkcreditcard"]),
        chkpet = nullable<bool>(json["detailInfo"]["chkpet"]),
        curturlcenter = nullable<String>(json["detailInfo"]["curturlcenter"]),
        fairday = nullable<String>(json["detailInfo"]["fairday"]),
        restroom = nullable<String>(json["detailInfo"]["restroom"]),
        saleitem = nullable<String>(json["detailInfo"]["saleitem"]),
        saleitemcost = nullable<String>(json["detailInfo"]["saleitemcost"]),
        shopguide = nullable<String>(json["detailInfo"]["shopguide"]),
        scale = nullable<String>(json["detailInfo"]["scale"]),
        benikia = nullable<bool>(json["detailInfo"]["benikia"]),
        checkintime = nullable<String>(json["detailInfo"]["checkintime"]),
        checkouttime = nullable<String>(json["detailInfo"]["checkouttime"]),
        chkcooking = nullable<bool>(json["detailInfo"]["chkcooking"]),
        foodplace = nullable<String>(json["detailInfo"]["foodplace"]),
        goodstay = nullable<bool>(json["detailInfo"]["goodstay"]),
        hanok = nullable<bool>(json["detailInfo"]["hanok"]),
        pickup = nullable<String>(json["detailInfo"]["pickup"]),
        roomcount = nullable<int>(json["detailInfo"]["roomcount"]),
        reservationurl = nullable<String>(json["detailInfo"]["reservationurl"]),
        roomtype = nullable<String>(json["detailInfo"]["roomtype"]),
        subfacility = nullable<String>(json["detailInfo"]["subfacility"]),
        barbecue = nullable<bool>(json["detailInfo"]["barbecue"]),
        beverage = nullable<bool>(json["detailInfo"]["beverage"]),
        campfire = nullable<bool>(json["detailInfo"]["campfire"]),
        fitness = nullable<bool>(json["detailInfo"]["fitness"]),
        karooke = nullable<bool>(json["detailInfo"]["karooke"]),
        publicbath = nullable<bool>(json["detailInfo"]["publicbath"]),
        pubblicpc = nullable<bool>(json["detailInfo"]["pubblicpc"]),
        seminar = nullable<bool>(json["detailInfo"]["seminar"]),
        sports = nullable<bool>(json["detailInfo"]["sports"]),
        refundregulation =
            nullable<String>(json["detailInfo"]["refundregulation"]),
        chkbabaycarriage =
            nullable<bool>(json["detailInfo"]["chkbabaycarriage"]),
        infocerter = nullable<String>(json["detailInfo"]["infocerter"]),
        openpriod = nullable<String>(json["detailInfo"]["openpriod"]),
        usetime = nullable<String>(json["detailInfo"]["usetime"]),
        bookingplace = nullable<String>(json["detailInfo"]["bookingplace"]),
        homepage = nullable<String>(json["detailInfo"]["homepage"]),
        grade = nullable<String>(json["detailInfo"]["grade"]),
        place = nullable<String>(json["detailInfo"]["place"]),
        placeinfo = nullable<String>(json["detailInfo"]["placeinfo"]),
        program = nullable<String>(json["detailInfo"]["program"]),
        sponsor1 = nullable<String>(json["detailInfo"]["sponsor1"]),
        sponsor1tel = nullable<String>(json["detailInfo"]["sponsor1tel"]),
        sponsor2 = nullable<String>(json["detailInfo"]["sponsor2"]),
        sponsor2tel = nullable<String>(json["detailInfo"]["sponsor2tel"]),
        subevent = nullable<String>(json["detailInfo"]["subevent"]),
        startdate = nullable<String>(json["detailInfo"]["startdate"]),
        enddate = nullable<String>(json["detailInfo"]["enddate"]),
        playtime = nullable<String>(json["detailInfo"]["playtime"]),
        spendtime = nullable<String>(json["detailInfo"]["spendtime"]),
        usetimefestival =
            nullable<String>(json["detailInfo"]["usetimefestival"]),
        accomcount = nullable<int>(json["detailInfo"]["accomcount"]),
        parkingfee = nullable<String>(json["detailInfo"]["parkingfee"]),
        usefee = nullable<String>(json["detailInfo"]["usefee"]),
        heritage1 = nullable<bool>(json["detailInfo"]["heritage1"]),
        heritage2 = nullable<bool>(json["detailInfo"]["heritage2"]),
        heritage3 = nullable<bool>(json["detailInfo"]["heritage3"]),
        paking = nullable<String>(json["detailInfo"]["paking"]),
        eventstartdate = nullable<String>(json["detailInfo"]["eventstartdate"]),
        eventenddate = nullable<String>(json["detailInfo"]["eventenddate"]),
        useseason = nullable<String>(json["detailInfo"]["useseason"]);
}
