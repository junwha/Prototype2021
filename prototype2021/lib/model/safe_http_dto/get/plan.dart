import 'package:prototype2021/data/dto/plan/plan_preview.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/common.dart';

class PlanListInput extends SafeHttpDataInput {
  Map<String, dynamic> toJson() => {};

  Map<String, String>? getUrlParams() => null;
}

class PlanListOutput extends PaginationOutput
    implements Pagination<PlanPreview> {
  final List<PlanPreview> results;
  PlanListOutput.fromJson({required Map<String, dynamic> json})
      : results = (json["results"] as List<dynamic>)
            .map((result) =>
                PlanPreview.fromJson(json: result as Map<String, dynamic>))
            .toList(),
        super.fromJson(json: json);
}
