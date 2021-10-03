import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/data/dto/safe_http/get/verification.dart';
import 'package:prototype2021/utils/safe_http/output_dto_factory.dart';
import 'package:prototype2021/data/dto/safe_http/post/authentication.dart';
import 'package:prototype2021/data/dto/safe_http/post/login.dart';
import 'package:prototype2021/data/dto/safe_http/post/signup.dart';

void main() {
  group('[Class] SafeHttpError', testSafeHttpError);
  group('[Class] SafeHttpInput', testSafeHttpInput);
  group('[Class] SafeHttpOutput', testSafeHttpOutput);
  group('[Class] SafeMutationInput', testSafeMutationInput);
  group('[Class] SafeMutationOutput', testSafeMutationOutput);
  group('[Class] SafeQueryInput', testSafeQueryInput);
  group('[Class] SafeQueryOutput', testSafeQueryOutput);
}

void testSafeHttpError() {
  SafeHttpError error;
  test('should construct the class with error message', () {
    error = new SafeHttpError(message: 'error msg');
    expect(error.message is String, true);
    expect(error.message.length > 0, true);
  });
}

void testSafeHttpInput() {
  final String url = 'http://something.com';
  final String headersAuthToken = 'Bearer sthadsfkljasdfadsklfajsd';
  final Map<String, String> headers = {
    "Content-Type": "text/html",
    'Authorization': headersAuthToken,
  };
  final String token = 'sth';
  test('Input should use default header when no headers passed', () {
    SafeHttpInput input = new SafeHttpInput(url: url);
    expect(input.getHeaders(), defaultHeaders);
  });

  test('Input should use overridden headers when headers passed', () {
    SafeHttpInput input = new SafeHttpInput(url: url, headers: headers);
    expect(input.getHeaders(), headers);
  });

  test('Input should use auth token when passed', () {
    SafeHttpInput input = new SafeHttpInput(url: url, token: token);
    expect(input.getHeaders()!['Authorization'], "jwt $token");
  });

  test(
      'Input should use overridden auth token when both headers and token are passed',
      () {
    SafeHttpInput input =
        new SafeHttpInput(url: url, token: token, headers: headers);
    expect(input.getHeaders()!['Authorization'], headersAuthToken);
  });
}

void testSafeHttpOutput() {
  final Map<String, dynamic> json = {"prop": "sth"};

  test('should construct the class of error case', () {
    SafeHttpOutput<ExampleOutput> output = new SafeHttpOutput<ExampleOutput>(
        success: false, error: SafeHttpError(message: 'error msg'));
    expect(output.success, false);
    expect(output.error is SafeHttpError, true);
    expect(output.data, null);
  });

  test('should construct the class of success case', () {
    SafeHttpOutput<ExampleOutput> output = new SafeHttpOutput<ExampleOutput>(
        success: true, rawData: jsonEncode(json));
    expect(output.success, true);
    expect(output.error, null);
    expect(output.data is ExampleOutput, true);
  });
}

void testSafeMutationInput() {
  PhoneAuthInput phoneAuthInput =
      new PhoneAuthInput(phoneNumber: '010-9048-9550');
  EmailAuthInput emailAuthInput =
      new EmailAuthInput(email: 'joseph95501@gmail.com');
  LoginInput loginInput =
      new LoginInput(username: 'joseph2002', password: 'joseph2002**');
  SignupInput signupInput = new SignupInput(
      username: 'joseph2002',
      password: 'joseph2002**',
      gender: Gender.M,
      birth: new DateTime(2002, 12, 9),
      name: 'some nickname',
      agreeMarketingTerms: true,
      agreeRequiredTerms: true);

  test('should get json string from SafeMutationInput', () {
    SafeMutationInput<PhoneAuthInput> testCase1 =
        new SafeMutationInput<PhoneAuthInput>(
            data: phoneAuthInput, url: 'http://someurl.com');
    expect(testCase1.data, phoneAuthInput);
    expect(testCase1.getJsonString(), jsonEncode(testCase1.data.toJson()));
    SafeMutationInput<EmailAuthInput> testCase2 =
        new SafeMutationInput<EmailAuthInput>(
            data: emailAuthInput, url: 'http://someurl.com');
    expect(testCase2.data, emailAuthInput);
    expect(testCase2.getJsonString(), jsonEncode(testCase2.data.toJson()));
    SafeMutationInput<LoginInput> testCase3 = new SafeMutationInput<LoginInput>(
        data: loginInput, url: 'http://someurl.com');
    expect(testCase3.data, loginInput);
    expect(testCase3.getJsonString(), jsonEncode(testCase3.data.toJson()));
    SafeMutationInput<SignupInput> testCase4 =
        new SafeMutationInput<SignupInput>(
            data: signupInput, url: 'http://someurl.com');
    expect(testCase4.data, signupInput);
    expect(testCase4.getJsonString(), jsonEncode(testCase4.data.toJson()));
  });
}

void testSafeMutationOutput() {
  AuthOutput authOutput = new AuthOutput.fromJson(
      json: {"token": "sth", "expiring_time": new DateTime.now().toString()});
  LoginOutput loginOutput =
      new LoginOutput.fromJson(json: {"token": "sth", "id": 1});
  SignupOutput signupOutput = new SignupOutput.fromJson(json: {"id": 1});

  test('should construct class from json', () {
    expect(authOutput is AuthOutput, true);
    expect(loginOutput is LoginOutput, true);
    expect(signupOutput is SignupOutput, true);
  });

  test('should initialize class with right prop types', () {
    expect(authOutput.expiringTime is DateTime, true);
    expect(authOutput.token is String, true);
    expect(loginOutput.token is String, true);
    expect(loginOutput.id is int, true);
    expect(signupOutput.id is int, true);
  });
}

void testSafeQueryInput() {
  AuthVerificationInput authVerificationInput =
      new AuthVerificationInput(verificationCode: 1234);
  IdVerificationInput idVerificationInput =
      new IdVerificationInput(id: 'someId');

  test('should get toJson from AuthVerificationInput', () {
    expect(authVerificationInput.toJson() is Map<String, dynamic>, true);
  });

  test('should getUrlParams from IdVerficationInput', () {
    expect(idVerificationInput.getUrlParams() is Map<String, String>, true);
  });

  test('should getUrlWithParams from IdVerificationInput inputed dto', () {
    SafeQueryInput<IdVerificationInput> testCase1 =
        new SafeQueryInput<IdVerificationInput>(
            url: 'http://someurl.com/:username/sth',
            params: idVerificationInput);
    expect(testCase1.getUrlWithParams(),
        Uri.parse('http://someurl.com/someId/sth'));
  });
}

void testSafeQueryOutput() {
  AuthVerificationOutput authVerificationOutput =
      new AuthVerificationOutput.fromJson(json: {
    "token": "sth",
    "expiring_time": 1234,
    "phoneNumberOrEmail": "010-9048-9550"
  });
  IdVerificationOutput idVerificationOutput =
      new IdVerificationOutput.fromJson(json: {"exists": true});

  test('should construct class from json', () {
    expect(authVerificationOutput is AuthVerificationOutput, true);
    expect(idVerificationOutput is IdVerificationOutput, true);
  });

  test('should initialize class with right prop types', () {
    expect(authVerificationOutput.token is String, true);
    expect(authVerificationOutput.expiringTime is int, true);
    expect(authVerificationOutput.phoneNumberOrEmail is String, true);
    expect(idVerificationOutput.exists is bool, true);
  });
}
