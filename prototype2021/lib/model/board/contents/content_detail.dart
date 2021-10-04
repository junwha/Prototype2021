import 'dart:io';

import 'package:prototype2021/model/board/contents/content_preview.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/utils/safe_http/common.dart';

class ContentsDetail extends ContentPreview {
  final double? rating;
  final int? reviewNo;
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
      : typeId = idContentType[nullable<int>(json["typeid"]) ?? -1] ??
            ContentType.unknown,
        zipCode = nullable<String>(json["zipcode"]),
        homePage = nullable<String>(json["homepage"]),
        tel = nullable<String>(json["tel"]),
        rating = nullable<double>(json["rating"]),
        reviewNo = nullable<int>(json["review_n"]),
        photo = (json["photo"] as List<dynamic>)
            .map((url) => url as String)
            .toList(),
        detailInfo = DetailInfo.fromJson(json: json),
        super.fromJson(json: json);
}

class DetailInfo {
  final String? accomcount; // int
  final String? chkbabaycarriage; // bool
  final String? chkcreditcard; // bool
  final String? chkpet; // bool
  final String? expagerange;
  final String? heritage1; // bool
  final String? heritage2; // bool
  final String? heritage3; // bool
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
  // final String? parkingfee; // int
  final String? reservation;
  // final String? usefee; // int
  final String? openpriod;
  final String? benikia; // bool
  final String? checkintime;
  final String? checkouttime;
  final String? chkcooking; // bool
  final String? foodplace;
  final String? goodstay; // bool
  final String? hanok; // bool
  final String? pickup;
  final String? roomcount; // int
  final String? reservationurl;
  final String? roomtype;
  final String? subfacility;
  final String? barbecue; // bool
  final String? beverage; // bool
  final String? campfire; // bool
  final String? fitness; // bool
  final String? karooke; // bool
  final String? publicbath; // bool
  final String? pubblicpc; // bool
  final String? seminar; // bool
  final String? sports; // bool
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
  final String? packing; // bool
  final String? seat; // int
  final String? smoking; // bool
  final String? treatmenu;
  final String? lcnson; // int
  final String? accomcountculture; // int
  final String? chkbabaycarriageculture; // bool
  final String? chkcreditcardculture; // bool
  final String? chkpetculture; // bool
  final String? infocenterculture;
  final String? parkingculture;
  final String? parkingfeeculture;
  final String? usetimeculture; // Date
  final String? restdateculture;
  final String? discountinfofestival;
  final String? eventhomepage;
  final String? festivalgrade;
  final String? eventplace;
  final String? accomcountleports; // int
  final String? chkbabaycarriageleports; // bool
  final String? chkcreditcardleports; // bool
  final String? chkpetleports; // bool
  final String? expagerangeleports;
  final String? infocerterleports;
  final String? parkingleports;
  final String? parkingfeeleports;
  final String? usefeeleports;
  final String? usetimeleports;
  final String? restdateleports;
  final String? scaleleports;
  final String? chkbabaycarriageshopping; // bool
  final String? chkcreditcardshopping; // bool
  final String? chkpetshopping; // bool
  final String? infocentershopping;
  final String? parkingshopping;
  final String? opendateshopping; // Date
  final String? restdateshopping;
  final String? chkcreditcardfood; // bool
  final String? discountInfofood;
  final String? infocenterfood;
  final String? parkingfood;
  final String? reservationfood;
  final String? opendatefood; // Date
  final String? opentimefood;

  DetailInfo.fromJson({required Map<String, dynamic> json})
      : agelimit = nullable<String>(json["detailInfo"]["agelimit"]),
        chkcreditcardfood =
            nullable<String>(json["detailInfo"]["chkcreditcardfood"]),
        discountInfofood =
            nullable<String>(json["detailInfo"]["discountInfofood"]),
        infocenterfood = nullable<String>(json["detailInfo"]["infocenterfood"]),
        parkingfood = nullable<String>(json["detailInfo"]["parkingfood"]),
        reservationfood =
            nullable<String>(json["detailInfo"]["reservationfood"]),
        opendatefood = nullable<String>(json["detailInfo"]["opendatefood"]),
        opentimefood = nullable<String>(json["detailInfo"]["opentimefood"]),
        chkbabaycarriageshopping =
            nullable<String>(json["detailInfo"]["chkbabaycarriageshopping"]),
        chkcreditcardshopping =
            nullable<String>(json["detailInfo"]["chkcreditcardshopping"]),
        chkpetshopping = nullable<String>(json["detailInfo"]["chkpetshopping"]),
        infocentershopping =
            nullable<String>(json["detailInfo"]["infocentershopping"]),
        parkingshopping =
            nullable<String>(json["detailInfo"]["parkingshopping"]),
        opendateshopping =
            nullable<String>(json["detailInfo"]["opendateshopping"]),
        restdateshopping =
            nullable<String>(json["detailInfo"]["restdateshopping"]),
        accomcountleports =
            nullable<String>(json["detailInfo"]["accomcountleports"]),
        chkbabaycarriageleports =
            nullable<String>(json["detailInfo"]["chkbabaycarriageleports"]),
        chkcreditcardleports =
            nullable<String>(json["detailInfo"]["chkcreditcardleports"]),
        chkpetleports = nullable<String>(json["detailInfo"]["chkpetleports"]),
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
            nullable<String>(json["detailInfo"]["accomcountculture"]),
        chkbabaycarriageculture =
            nullable<String>(json["detailInfo"]["chkbabaycarriageculture"]),
        chkcreditcardculture =
            nullable<String>(json["detailInfo"]["chkcreditcardculture"]),
        chkpetculture = nullable<String>(json["detailInfo"]["chkpetculture"]),
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
        packing = nullable<String>(json["detailInfo"]["packing"]),
        parking = nullable<String>(json["detailInfo"]["parking"]),
        reservation = nullable<String>(json["detailInfo"]["reservation"]),
        seat = nullable<String>(json["detailInfo"]["seat"]),
        smoking = nullable<String>(json["detailInfo"]["smoking"]),
        treatmenu = nullable<String>(json["detailInfo"]["treatmenu"]),
        opendate = nullable<String>(json["detailInfo"]["opendate"]),
        opentime = nullable<String>(json["detailInfo"]["opentime"]),
        restdate = nullable<String>(json["detailInfo"]["restdate"]),
        lcnson = nullable<String>(json["detailInfo"]["lcnson"]),
        chkcreditcard = nullable<String>(json["detailInfo"]["chkcreditcard"]),
        chkpet = nullable<String>(json["detailInfo"]["chkpet"]),
        curturlcenter = nullable<String>(json["detailInfo"]["curturlcenter"]),
        fairday = nullable<String>(json["detailInfo"]["fairday"]),
        restroom = nullable<String>(json["detailInfo"]["restroom"]),
        saleitem = nullable<String>(json["detailInfo"]["saleitem"]),
        saleitemcost = nullable<String>(json["detailInfo"]["saleitemcost"]),
        shopguide = nullable<String>(json["detailInfo"]["shopguide"]),
        scale = nullable<String>(json["detailInfo"]["scale"]),
        benikia = nullable<String>(json["detailInfo"]["benikia"]),
        checkintime = nullable<String>(json["detailInfo"]["checkintime"]),
        checkouttime = nullable<String>(json["detailInfo"]["checkouttime"]),
        chkcooking = nullable<String>(json["detailInfo"]["chkcooking"]),
        foodplace = nullable<String>(json["detailInfo"]["foodplace"]),
        goodstay = nullable<String>(json["detailInfo"]["goodstay"]),
        hanok = nullable<String>(json["detailInfo"]["hanok"]),
        pickup = nullable<String>(json["detailInfo"]["pickup"]),
        roomcount = nullable<String>(json["detailInfo"]["roomcount"]),
        reservationurl = nullable<String>(json["detailInfo"]["reservationurl"]),
        roomtype = nullable<String>(json["detailInfo"]["roomtype"]),
        subfacility = nullable<String>(json["detailInfo"]["subfacility"]),
        barbecue = nullable<String>(json["detailInfo"]["barbecue"]),
        beverage = nullable<String>(json["detailInfo"]["beverage"]),
        campfire = nullable<String>(json["detailInfo"]["campfire"]),
        fitness = nullable<String>(json["detailInfo"]["fitness"]),
        karooke = nullable<String>(json["detailInfo"]["karooke"]),
        publicbath = nullable<String>(json["detailInfo"]["publicbath"]),
        pubblicpc = nullable<String>(json["detailInfo"]["pubblicpc"]),
        seminar = nullable<String>(json["detailInfo"]["seminar"]),
        sports = nullable<String>(json["detailInfo"]["sports"]),
        refundregulation =
            nullable<String>(json["detailInfo"]["refundregulation"]),
        chkbabaycarriage =
            nullable<String>(json["detailInfo"]["chkbabaycarriage"]),
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
        accomcount = nullable<String>(json["detailInfo"]["accomcount"]),
        parkingfee = nullable<String>(json["detailInfo"]["parkingfee"]),
        usefee = nullable<String>(json["detailInfo"]["usefee"]),
        heritage1 = nullable<String>(json["detailInfo"]["heritage1"]),
        heritage2 = nullable<String>(json["detailInfo"]["heritage2"]),
        heritage3 = nullable<String>(json["detailInfo"]["heritage3"]),
        paking = nullable<String>(json["detailInfo"]["paking"]),
        eventstartdate = nullable<String>(json["detailInfo"]["eventstartdate"]),
        eventenddate = nullable<String>(json["detailInfo"]["eventenddate"]),
        useseason = nullable<String>(json["detailInfo"]["useseason"]);
}
