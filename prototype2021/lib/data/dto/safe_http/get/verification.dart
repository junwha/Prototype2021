import 'package:prototype2021/data/dto/safe_http/base.dart';

class AuthVerificationInput extends SafeHttpDataInput {
  final int verificationCode;

  AuthVerificationInput({required this.verificationCode});

  @override
  Map<String, dynamic> toJson() => {
        "verification_code": verificationCode,
      };
}

class AuthVerificationOutput extends SafeHttpDataOutput {
  final String token;
  final String expiringTime; // Why it's not integer
  final String? phoneNumberOrEmail;

  AuthVerificationOutput.fromJson({required Map<String, dynamic> json})
      : token = json['token'] as String,
        expiringTime = json['expiring_time'] as String,
        phoneNumberOrEmail = json['phoneNumberOrEmail'] as String?;
}

class IdVerificationInput extends SafeHttpDataInput {
  final String id;

  IdVerificationInput({required this.id});

  @override
  Map<String, String> getUrlParams() => {
        ":username": id,
      };
}

class IdVerificationOutput extends SafeHttpDataOutput {
  final bool exists;

  IdVerificationOutput.fromJson({required Map<String, dynamic> json})
      : exists = json['exists'] as bool;
}
