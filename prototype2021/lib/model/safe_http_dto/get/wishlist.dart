import 'package:prototype2021/model/safe_http_dto/base.dart';

class ContentsWishlistInput extends SafeHttpDataInput {
  final String? areaCode;
  final String? detailAreaCode;
  final String? typeId;

  ContentsWishlistInput({
    this.areaCode,
    this.detailAreaCode,
    this.typeId,
  });

  Map<String, dynamic> toJson() => {
        "area_code": areaCode,
        "detail_area_code": detailAreaCode,
        "typeid": typeId,
      };

  Map<String, String>? getUrlParams() => null;
}

class ContentPreview {
  final int id;
  final String titie;
  final String overview;
  final String photo;
  final String address;
  final double numRating;
  final int numHeart;
  final int catCode;
  final bool hearted;

  ContentPreview({
    required this.id,
    required this.titie,
    required this.overview,
    required this.photo,
    required this.address,
    required this.numRating,
    required this.numHeart,
    required this.catCode,
    required this.hearted,
  });
}

T _parseValue<T>(dynamic value, T defaultValue) {
  if (value is T)
    return value;
  else
    return defaultValue;
}

class ContentsWishlistOutput extends SafeHttpDataOutput {
  final int count;
  final int? next;
  final int? previous;
  final List<ContentPreview> results;

  ContentsWishlistOutput.fromJson({required Map<String, dynamic> json})
      : count = _parseValue<int>(json['count'], 0),
        next = _parseValue<int?>(json['next'], null),
        previous = _parseValue<int?>(json['previous'], null),
        results = _parseValue<List<ContentPreview>>(json['results'], []);
}
