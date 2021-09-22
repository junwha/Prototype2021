import 'dart:io';

import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/post/signup.dart';
import 'package:prototype2021/model/safe_http_dto/get/verification.dart';
import 'package:prototype2021/model/safe_http_dto/post/authentication.dart';
import 'package:prototype2021/model/safe_http_dto/post/login.dart';
import 'package:prototype2021/model/signin_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/ui/signin_page/signin_term_view.dart';

const String defaultErrorMessage = "Unexpected Error";

class SigninLoader {
  // Custom Functions

  Future<bool> checkIfIdHasDuplicate(String id) async {
    IdVerificationInput params = new IdVerificationInput(id: id);
    SafeQueryInput<IdVerificationInput> dto =
        new SafeQueryInput(url: idVerificationUrl, params: params);
    SafeQueryOutput<IdVerificationOutput> result = await idVerification(dto);
    if (result.success && result.data?.exists != null)
      return result.data!.exists;
    throw HttpException(result.error?.message ?? defaultErrorMessage);
  }

  Future<String> requestAuth(
      String credential, VerificationMethod verificationMethod) async {
    String? errorMessage = "";
    if (verificationMethod == VerificationMethod.Email) {
      EmailAuthInput data = new EmailAuthInput(email: credential);
      SafeMutationInput<EmailAuthInput> dto =
          new SafeMutationInput(data: data, url: emailAuthUrl);
      SafeMutationOutput<AuthOutput> result = await emailAuth(dto);
      if (result.success && result.data?.token != null)
        return result.data!.token;
      errorMessage = result.error?.message;
    } else {
      PhoneAuthInput data = new PhoneAuthInput(phoneNumber: credential);
      SafeMutationInput<PhoneAuthInput> dto =
          new SafeMutationInput(data: data, url: phoneAuthUrl);
      SafeMutationOutput<AuthOutput> result = await phoneAuth(dto);
      if (result.success && result.data?.token != null)
        return result.data!.token;
      errorMessage = result.error?.message;
    }
    print(errorMessage);
    throw HttpException(errorMessage ?? defaultErrorMessage);
  }

  Future<String> requestCodeVerification(
      String token, int verificationCode) async {
    AuthVerificationInput params =
        new AuthVerificationInput(verificationCode: verificationCode);
    SafeQueryInput<AuthVerificationInput> dto = new SafeQueryInput(
        url: authVerificationUrl,
        params: params,
        token: token,
        authScheme: AuthScheme.none);
    SafeQueryOutput<AuthVerificationOutput> result =
        await authVerification(dto);
    if (result.success && result.data?.token != null) return result.data!.token;
    print(result.error?.message);
    throw HttpException(result.error?.message ?? defaultErrorMessage);
  }

  Future<int> requestSignup(SignInModel signInModel) async {
    SignupInput data = new SignupInput(
        username: signInModel.username,
        password: signInModel.password,
        gender: signInModel.gender,
        birth: signInModel.birth,
        name: signInModel.nickname,
        agreeMarketingTerms: signInModel.agreeMarketingTerms,
        agreeRequiredTerms: signInModel.agreeRequiredTerms);
    SafeMutationInput<SignupInput> dto =
        new SafeMutationInput(data: data, url: signUpUrl);
    SafeMutationOutput<SignupOutput> result = await signup(dto);
    if (result.success && result.data?.id != null) return result.data!.id;
    print(result.error?.message);
    throw HttpException(result.error?.message ?? defaultErrorMessage);
  }

  // Fetching Functions

  Future<SafeQueryOutput<IdVerificationOutput>> idVerification(
          SafeQueryInput<IdVerificationInput> dto) async =>
      await safeGET<IdVerificationInput, IdVerificationOutput>(dto);

  Future<SafeMutationOutput<AuthOutput>> phoneAuth(
          SafeMutationInput<PhoneAuthInput> dto) async =>
      await safePOST<PhoneAuthInput, AuthOutput>(dto);

  Future<SafeMutationOutput<AuthOutput>> emailAuth(
          SafeMutationInput<EmailAuthInput> dto) async =>
      await safePOST<EmailAuthInput, AuthOutput>(dto, 200);

  Future<SafeQueryOutput<AuthVerificationOutput>> authVerification(
          SafeQueryInput<AuthVerificationInput> dto) async =>
      await safeGET<AuthVerificationInput, AuthVerificationOutput>(dto);

  Future<SafeMutationOutput<SignupOutput>> signup(
          SafeMutationInput<SignupInput> dto) async =>
      await safeMultipartPost(dto);

  // Endpoints

  String signUpUrl = "$apiBaseUrl/user/signup";
  String idVerificationUrl = "$apiBaseUrl/user/signup/:username/verification";
  String phoneAuthUrl = "$apiBaseUrl/user/signup/authentication/phone";
  String emailAuthUrl = "$apiBaseUrl/user/signup/authentication/email";
  String authVerificationUrl =
      "$apiBaseUrl/user/signup/authentication/verification";
}
