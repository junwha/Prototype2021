import 'dart:io';

import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/model/signin/http/verification.dart';
import 'package:prototype2021/model/signin/http/authentication.dart';
import 'package:prototype2021/model/login/http/login.dart';
import 'package:prototype2021/model/signin/http/signup.dart';
import 'package:prototype2021/utils/aws_s3_uploader/s3_uploader.dart';
import 'package:prototype2021/utils/safe_http/safe_http.dart';
import 'package:prototype2021/handler/signin/signin_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/signin/signin_term_view.dart';

const String defaultErrorMessage = "Unexpected Error";

class SigninLoader {
  // Custom Functions

  Future<bool> checkIfIdHasDuplicate(String id) async {
    IdVerificationInput params = new IdVerificationInput(id: id);
    SafeQueryInput<IdVerificationInput> dto =
        new SafeQueryInput(url: idVerificationUrl, params: params);
    SafeQueryOutput<IdVerificationOutput> result = await idVerification(dto);
    if (result.success && result.data?.exists != null) {
      return result.data!.exists;
    } else if (result.data?.exists == true) {
      return true;
    }
    return true;
    // throw HttpException(result.error?.message ?? defaultErrorMessage);
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
    Logger.errorWithInfo(errorMessage, "signin_loader");
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
    Logger.errorWithInfo(result.error?.message, "signin_loader");
    throw HttpException(result.error?.message ?? defaultErrorMessage);
  }

  Future<int> requestSignup(SignInHandler signInModel) async {
    String? photoUrl;

    if (signInModel.photo != null) {
      photoUrl = await S3Uploader.uploadToS3AndGetUrl(
          File(signInModel.photo!.path), signInModel.username + ".png");
    }

    SignupInput data = new SignupInput(
      username: signInModel.username,
      password: signInModel.password,
      gender: signInModel.gender,
      birth: signInModel.birth,
      name: signInModel.nickname,
      agreeMarketingTerms: signInModel.agreeMarketingTerms,
      photo: photoUrl,
      agreeRequiredTerms: signInModel.agreeRequiredTerms,
      email: signInModel.method == VerificationMethod.Email
          ? signInModel.verifier
          : null,
      phoneNumber: signInModel.method == VerificationMethod.Phone
          ? signInModel.verifier
          : null,
    );
    SafeMutationInput<SignupInput> dto =
        new SafeMutationInput(data: data, url: signUpUrl);
    SafeMutationOutput<SignupOutput> result = await signup(dto);
    if (result.success && result.data?.id != null) return result.data!.id;
    Logger.errorWithInfo(result.error?.message, "signin_loader");
    throw HttpException(result.error?.message ?? defaultErrorMessage);
  }

  // Fetching Functions
  Future<SafeMutationOutput<LoginOutput>> login(
          SafeMutationInput<LoginInput> dto) async =>
      await safePOST<LoginInput, LoginOutput>(dto, 200);

  Future<SafeQueryOutput<IdVerificationOutput>> idVerification(
          SafeQueryInput<IdVerificationInput> dto) async =>
      await safeGET<IdVerificationInput, IdVerificationOutput>(dto);

  Future<SafeMutationOutput<AuthOutput>> phoneAuth(
          SafeMutationInput<PhoneAuthInput> dto) async =>
      await safePOST<PhoneAuthInput, AuthOutput>(dto, 200);

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
