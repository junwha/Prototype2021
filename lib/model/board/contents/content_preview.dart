import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/utils/safe_http/common.dart';

class ContentPreview {
  final int id;
  final String title;
  final String overview;
  final ContentType typeId;

  /// URL of the photo
  final String? thumbnail;
  final String? address;

  /// catCode가 int가 아닌 것으로 보입니다.
  /// 예를들어 이런 식입니다: B0201
  final String catCode;
  final int heartNo;
  final bool hearted;

  ContentPreview.fromJson({required Map<String, dynamic> json})
      : id = json["id"] as int,
        title = json["title"] as String,
        overview = json["overview"] as String,
        typeId = idContentType[nullable<int>(json["typeid"]) ?? -1] ??
            ContentType.unknown,
        thumbnail = nullable<String>(json["thumbnail"]),
        address = nullable<String>(json["address"]),
        catCode = json["cat_code"] as String,
        heartNo = json["heart_no"] as int,
        hearted = nullable<bool>(json["hearted"]) ?? true;
}
