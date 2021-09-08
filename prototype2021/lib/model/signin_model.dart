import 'package:image_picker/image_picker.dart';
import 'package:prototype2021/model/safe_http_dto/post/signup.dart';
import 'package:prototype2021/model/state_manager.dart';
import 'package:prototype2021/ui/signin_page/signin_term_view.dart';

class SignInModel extends StateManager {
  String _username = "";
  String _password = "";
  PickedFile? _photo;
  String _nickname = "";
  Gender _gender = Gender.M;
  DateTime _birth = DateTime(1999, 1, 1);
  // email or phone number
  String _verifier = "";
  bool _agreeRequiredTerms = false;
  bool _agreeMarketingTerms = false;
  VerificationMethod _method = VerificationMethod.Phone;

  String get username => _username;
  String get password => _password;
  PickedFile? get photo => _photo;
  String get nickname => _nickname;
  Gender get gender => _gender;
  DateTime get birth => _birth;
  String get verifier => _verifier;
  bool get agreeRequiredTerms => _agreeRequiredTerms;
  bool get agreeMarketingTerms => _agreeMarketingTerms;
  VerificationMethod get method => _method;

  void setCredentials(String username, String password) => setState(() {
        _username = username;
        _password = password;
      });

  void setPhoto(PickedFile photo) => setState(() {
        _photo = photo;
      });

  void setNickname(String nickname) => setState(() {
        _nickname = nickname;
      });

  void setGender(Gender gender) => setState(() {
        _gender = gender;
      });

  void setBirth(DateTime birth) => setState(() {
        _birth = birth;
      });

  void setAgreeRequiredTerms(bool agreeRequiredTerms) => setState(() {
        _agreeRequiredTerms = agreeRequiredTerms;
      });

  void setAgreeMarketingTerms(bool agreeMarketingTerms) => setState(() {
        _agreeMarketingTerms = agreeMarketingTerms;
      });

  void setMethod(VerificationMethod method) => setState(() {
        _method = method;
      });

  /* 
   * This method is just for readability purpose
   * Use this when you need to pass the change notifier model
   * to next page route
  */
  SignInModel inherit() => this;
}
