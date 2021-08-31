import 'dart:io';

import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/signup.dart';
import 'package:prototype2021/model/safe_http_dto/get/verification.dart';
import 'package:prototype2021/model/safe_http_dto/post/authentication.dart';
import 'package:prototype2021/model/safe_http_dto/post/login.dart';
import 'package:prototype2021/settings/constants.dart';

class SigninLoader {
  Future<bool> checkIfIdHasDuplicate(String id) async {
    IdVerificationInput params = new IdVerificationInput(id: id);
    SafeQueryInput<IdVerificationInput> dto = new SafeQueryInput(
        url: "$apiBaseUrl/signup/id/verification", params: params);
    SafeQueryOutput<IdVerificationOutput> result = await idVerification(dto);
    print(result.error?.message);
    if (result.success && result.data?.exists != null)
      return result.data!.exists;
    throw HttpException(result.error?.message ?? "Unexpected error");
  }

  Future<SafeMutationOutput<LoginOutput>> login(
          SafeMutationInput<LoginInput> dto) async =>
      await safePOST<LoginInput, LoginOutput>(dto);

  Future<SafeQueryOutput<IdVerificationOutput>> idVerification(
          SafeQueryInput<IdVerificationInput> dto) async =>
      await safeGET<IdVerificationInput, IdVerificationOutput>(dto);

  Future<SafeMutationOutput<AuthOutput>> phoneAuth(
          SafeMutationInput<PhoneAuthInput> dto) async =>
      await safePOST<PhoneAuthInput, AuthOutput>(dto);

  Future<SafeMutationOutput<AuthOutput>> emailAuth(
          SafeMutationInput<EmailAuthInput> dto) async =>
      await safePOST<EmailAuthInput, AuthOutput>(dto);

  Future<SafeQueryOutput<AuthVerificationOutput>> authVerification(
          SafeQueryInput<AuthVerificationInput> dto) async =>
      safeGET<AuthVerificationInput, AuthVerificationOutput>(dto);

  Future<SafeMutationOutput<SignupOutput>> signup(
          SafeMutationInput<SignupInput> dto) async =>
      safePOST(dto);
}
