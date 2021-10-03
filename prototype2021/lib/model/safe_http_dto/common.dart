import 'package:prototype2021/model/safe_http_dto/base.dart';

abstract class Pagination<T> {
  abstract final int count;
  abstract final String? next;
  abstract final String? previous;
  abstract final List<T> results;
}

class PaginationOutput extends SafeHttpDataOutput {
  final int count;
  final String? next;
  final String? previous;

  PaginationOutput.fromJson({required Map<String, dynamic> json})
      : count = json["count"] as int,
        next = nullable<String>(json["next"]),
        previous = nullable<String>(json["previous"]);
}

T? nullable<T>(T? value) => value == null ? null : value as T;
