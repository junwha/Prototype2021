import 'package:prototype2021/model/safe_http_dto/base.dart';

abstract class Pagination<T> {
  abstract final int count;
  abstract final int next;
  abstract final int previous;
  abstract final List<T> results;
}

class PaginationOutput extends SafeHttpDataOutput {
  final int count;
  final int next;
  final int previous;

  PaginationOutput.fromJson({required Map<String, dynamic> json})
      : count = json["count"] as int,
        next = json["next"] as int,
        previous = json["previous"] as int;
}
