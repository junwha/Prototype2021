import 'package:prototype2021/model/contents_dto/content_detail.dart';
import 'package:prototype2021/model/contents_dto/content_type.dart';

final _factories =
    <ContentType, ContentsDetailBase Function(Map<String, dynamic>)>{
  ContentType.unknown: (json) => ContentsDetailBase.fromJson(json: json),
  ContentType.spot: (json) => ContentsDetail12.fromJson(json: json),
  ContentType.cultureInfra: (json) => ContentsDetail14.fromJson(json: json),
  ContentType.events: (json) => ContentsDetail15.fromJson(json: json),
  ContentType.leisureSports: (json) => ContentsDetail28.fromJson(json: json),
  ContentType.accomodations: (json) => ContentsDetail32.fromJson(json: json),
  ContentType.shopping: (json) => ContentsDetail38.fromJson(json: json),
  ContentType.restaurants: (json) => ContentsDetail39.fromJson(json: json),
};

ContentsDetailBase generateContentsData(
    {required ContentType type, required Map<String, dynamic> json}) {
  return _factories[type]!(json);
}
