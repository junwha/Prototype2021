import 'package:prototype2021/data/dto/safe_http/common.dart';

class ContentPreviewBase {
  final int id;
  final String title;
  final String overview;

  /// URL of the photo
  final String? thumbnail;
  final String? address;

  /// catCode가 int가 아닌 것으로 보입니다.
  /// 예를들어 이런 식입니다: B0201
  final String catCode;
  final int heartNo;
  final bool hearted;

  ContentPreviewBase.fromJson({required Map<String, dynamic> json})
      : id = int.parse(json["id"] as String), // dart recieves it as String
        title = json["title"] as String,
        overview = json["overview"] as String,
        thumbnail = nullable<String>(json["thumbnail"]),
        address = nullable<String>(json["address"]),
        catCode = json["cat_code"] as String,
        heartNo = json["heart_no"] as int,
        hearted = json["hearted"] as bool;
}

// 이 DTO가 맞지 않는 것 같습니다
class ContentPreview extends ContentPreviewBase {
  final int? rating;
  final double? reviewNo;

  ContentPreview.fromJson({required Map<String, dynamic> json})
      : rating = nullable<int>(json["rating"]),
        reviewNo = nullable<double>(json["review_no"]),
        super.fromJson(json: json);
}

class WishlistContentPreview extends ContentPreview {
  final double? ratingNo;

  WishlistContentPreview.fromJson({required Map<String, dynamic> json})
      : ratingNo = nullable<double>(json["rating_n"]),
        super.fromJson(json: json);
}
