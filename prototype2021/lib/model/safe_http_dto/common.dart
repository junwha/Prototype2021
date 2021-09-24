import 'package:prototype2021/model/safe_http_dto/base.dart';

abstract class Pagination<T> {
  abstract final int count;
  abstract final int? next;
  abstract final int? previous;
  abstract final List<T> results;
}

class PaginationOutput extends SafeHttpDataOutput {
  final int count;
  final int? next;
  final int? previous;

  PaginationOutput.fromJson({required Map<String, dynamic> json})
      : count = json["count"] as int,
        next = nullable<int>(json["next"]),
        previous = nullable<int>(json["previous"]);
}

T? nullable<T>(T? value) => value == null ? null : value as T;
