import 'package:prototype2021/model/safe_http_dto/base.dart';

class PhoneAuthInput extends SafeHttpDataInput {
  final String phoneNumber;

  PhoneAuthInput({required this.phoneNumber});

  @override
  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
      };
}

class EmailAuthInput extends SafeHttpDataInput {
  final String email;

  EmailAuthInput({required this.email});

  @override
  Map<String, dynamic> toJson() => {"email": email};
}

class AuthOutput extends SafeHttpDataOutput {
  final String token;
  final DateTime expiringTime;

  AuthOutput.fromJson({required Map<String, dynamic> json})
      : token = json['token'],
        expiringTime = DateTime.parse(json['expiring_time']);
}
