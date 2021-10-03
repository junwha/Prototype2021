import 'package:prototype2021/data/dto/safe_http/base.dart';

enum Gender { M, F, None }

const GenderStringMapping = <Gender, String>{
  Gender.M: 'M',
  Gender.F: 'F',
  Gender.None: 'None'
};

class SignupInput extends SafeHttpDataInput {
  final String username;
  final String password;
  final String? photo;
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
    Map<String, String> baseMap = {
      "username": username,
      "password": password,
      "gender": GenderStringMapping[gender]!,
      "birth": _formatDateTime(birth),
      "name": name,
    };
    if (photo != null) {
      baseMap["photo"] = photo!;
    }
    /* 
     * Since the Multipart Request's fields part must be a Map<String, String>
     * We send boolean field as string 'true' if it should be true
     * and omit the field if it should be false
     * 
     * Ref: https://www.django-rest-framework.org/api-guide/fields/#booleanfield
    */
    if (agreeRequiredTerms) {
      baseMap.addAll({
        "agree_required_terms": agreeRequiredTerms.toString(),
      });
    }
    if (agreeMarketingTerms) {
      baseMap.addAll({
        "agree_marketing_terms": agreeMarketingTerms.toString(),
      });
    }
    print(phoneNumber);
    print(email);
    if (phoneNumber != null) {
      baseMap.addAll({"phone_number": phoneNumber!});
    }
    if (email != null) {
      baseMap.addAll({"email": email!});
    }
    return baseMap;
  }

  // @override
  // Map<String, XFile>? getFiles() {
  //   if (photo == null) return null;
  //   return {
  //     "photo": photo!,
  //   };
  // }

  String _formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month =
        dateTime.month < 10 ? "0${dateTime.month}" : dateTime.month.toString();
    String day =
        dateTime.day < 10 ? "0${dateTime.day}" : dateTime.day.toString();
    return "$year-$month-$day";
  }

  Map<String, String>? getUrlParams() => null;
}

class SignupOutput extends SafeHttpDataOutput {
  final int id;

  SignupOutput.fromJson({required Map<String, dynamic> json})
      : id = json['id'] as int;
}
