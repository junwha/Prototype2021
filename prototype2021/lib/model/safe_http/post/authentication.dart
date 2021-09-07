import 'package:prototype2021/model/safe_http/base.dart';

class PhoneAuthInput implements SafeHttpDataInput {
  final String phoneNumber;

  PhoneAuthInput({required this.phoneNumber});

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
      };
}

class EmailAuthInput implements SafeHttpDataInput {
  final String email;

  EmailAuthInput({required this.email});

  Map<String, dynamic> toJson() => {"email": email};
}

class AuthOutput implements SafeHttpDataOutput {
  final String token;
  final DateTime expiringTime;

  AuthOutput.fromJson({required Map<String, dynamic> json})
      : token = json['token'],
        expiringTime = DateTime.parse(json['expiring_time']);
}
