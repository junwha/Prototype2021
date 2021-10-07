import 'package:prototype2021/utils/safe_http/base.dart';

class PlanHeartInput extends SafeHttpDataInput {
  final String planId;

  PlanHeartInput({required this.planId});

  Map<String, dynamic>? toJson() => null;

  Map<String, String> getUrlParams() => {
        ":planId": planId,
      };
}

class PlanHeartOutput extends SafeHttpDataOutput {
  PlanHeartOutput.fromJson({Map<String, dynamic> json = const {}});
}

class ContentsHeartInput extends SafeHttpDataInput {
  final String contentsId;

  ContentsHeartInput({required this.contentsId});

  Map<String, dynamic>? toJson() => null;

  Map<String, String> getUrlParams() => {
        ":id": contentsId,
      };
}

class ContentsHeartOutput extends SafeHttpDataOutput {
  ContentsHeartOutput.fromJson({Map<String, dynamic> json = const {}});
}
