import 'dart:io';

import 'package:prototype2021/data/dto/contents/content_detail.dart';
import 'package:prototype2021/data/dto/contents/content_preview.dart';
import 'package:prototype2021/data/dto/contents/content_type.dart';
import 'package:prototype2021/data/dto/safe_http/base.dart';
import 'package:prototype2021/data/dto/safe_http/common.dart';

// ========================= ContentsList ========================= //

class ContentsListInput extends SafeHttpDataInput {
  final int? areaCode;
  final int? areaDetailCode;
  final String? keyword;
  final ContentType? typeId;

  ContentsListInput({
    this.areaCode,
    this.areaDetailCode,
    this.keyword,
    this.typeId,
  });

  Map<String, dynamic> toJson() => {
        "area_code": areaCode,
        "area_detail_code": areaDetailCode == null ? null : "($areaDetailCode)",
        "keyword": keyword,
        "typeid": contentTypeId[typeId],
      };

  Map<String, String>? getUrlParams() => null;
}

class ContentsListOutput extends PaginationOutput
    implements Pagination<ContentPreview> {
  final List<ContentPreview> results;

  ContentsListOutput.fromJson({required Map<String, dynamic> json})
      : results = (json["results"] as List<dynamic>)
            .map((result) =>
                ContentPreview.fromJson(json: result as Map<String, dynamic>))
            .toList(),
        super.fromJson(json: json);
}

// =================== Wishlist =================== //

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
        "typeid": typeId
      };

  Map<String, String>? getUrlParams() => null;
}

class ContentsWishlistOutput extends PaginationOutput
    implements Pagination<WishlistContentPreview> {
  final List<WishlistContentPreview> results;

  ContentsWishlistOutput.fromJson({required Map<String, dynamic> json})
      : results = (json["results"] as List<dynamic>)
            .map((result) => WishlistContentPreview.fromJson(
                json: result as Map<String, dynamic>))
            .toList(),
        super.fromJson(json: json);
}

// ========================= ContentsDetail ========================= //

class ContentsDetailInput extends SafeHttpDataInput {
  final int id;

  ContentsDetailInput({required this.id});

  Map<String, dynamic>? toJson() => null;

  Map<String, String> getUrlParams() => {
        ":id": id.toString(),
      };
}

class ContentsDetailOutput extends SafeHttpDataOutput {
  /* 
   * 모든 typeId에 따라 달라지는 Contents Detail DTO들은 ContentsDetailBase를 상속하므로
   * 아래와 같이 정의해 두었습니다
  */
  final ContentsDetail result;

  /* 
   * typeId를 먼저 확인한 뒤, typeId에 맞는 DTO를 불러옵니다
  */
  ContentsDetailOutput.fromJson({required Map<String, dynamic> json})
      : result = ContentsDetail.fromJson(json: json);
}
