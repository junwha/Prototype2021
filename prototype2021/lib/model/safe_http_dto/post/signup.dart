import 'package:image_picker/image_picker.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';

enum Gender { M, F, None }

const GenderStringMapping = <Gender, String>{
  Gender.M: 'M',
  Gender.F: 'F',
  Gender.None: 'None'
};

class SignupInput extends SafeHttpDataInput {
  final String username;
  final String password;
  final XFile? photo;
  final Gender gender;
  final DateTime birth;
  final String? phoneNumber;
  final String? email;
  final String name;
  final bool agreeRequiredTerms;
  final bool agreeMarketingTerms;

  SignupInput({
    required this.username,
    required this.password,
    required this.gender,
    required this.birth,
    required this.name,
    required this.agreeMarketingTerms,
    required this.agreeRequiredTerms,
    this.photo,
    this.email,
    this.phoneNumber,
  });

  @override
  Map<String, String> toJson() {
    print(agreeRequiredTerms.toString());
    Map<String, String> baseMap = {
      "username": username,
      "password": password,
      "gender": GenderStringMapping[gender]!,
      "birth": _formatDateTime(birth),
      "name": name,
      "agreeRequiredTerms": agreeRequiredTerms.toString(),
      "agreeMarketingTerms": agreeMarketingTerms.toString(),
    };
    if (phoneNumber != null) {
      baseMap.addAll({"phoneNumber": phoneNumber!});
    }
    if (email != null) {
      baseMap.addAll({"email": email!});
    }
    return baseMap;
  }

  @override
  Map<String, XFile>? getFiles() => photo != null
      ? {
          "photo": photo!,
        }
      : null;

  String _formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month =
        dateTime.month < 10 ? "0${dateTime.month}" : dateTime.month.toString();
    String day =
        dateTime.day < 10 ? "0${dateTime.day}" : dateTime.day.toString();
    return "$year-$month-$day";
  }
}

class SignupOutput extends SafeHttpDataOutput {
  final int id;

  SignupOutput.fromJson({required Map<String, dynamic> json})
      : id = json['id'] as int;
}
