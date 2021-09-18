import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/output_dto_factory.dart';

void main() {
  group('[Class] SafeHttpError', testSafeHttpError);
  group('[Class] SafeHttpInput', testSafeHttpInput);
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
  SafeHttpInput input;
  final String url = 'http://something.com';
  final String headersAuthToken = 'Bearer sthadsfkljasdfadsklfajsd';
  final Map<String, String> headers = {
    "Content-Type": "text/html",
    'Authorization': headersAuthToken,
  };
  final String token = 'sth';
  test('Input should use default header when no headers passed', () {
    input = new SafeHttpInput(url: url);
    expect(input.getHeaders(), defaultHeaders);
  });

  test('Input should use overridden headers when headers passed', () {
    input = new SafeHttpInput(url: url, headers: headers);
    expect(input.getHeaders(), headers);
  });

  test('Input should use auth token when passed', () {
    input = new SafeHttpInput(url: url, token: token);
    expect(input.getHeaders()!['Authorization'], "jwt $token");
  });

  test(
      'Input should use overridden auth token when both headers and token are passed',
      () {
    input = new SafeHttpInput(url: url, token: token, headers: headers);
    expect(input.getHeaders()!['Authorization'], headersAuthToken);
  });
}

void testSafeHttpOutput() {
  SafeHttpOutput<ExampleOutput> output;
  final Map<String, dynamic> json = {"prop": "sth"};

  test('should construct the class of error case', () {
    output = new SafeHttpOutput<ExampleOutput>(
        success: false, error: SafeHttpError(message: 'error msg'));
    expect(output.success, false);
    expect(output.error is SafeHttpError, true);
    expect(output.data, null);
  });

  test('should construct the class of success case', () {
    output = new SafeHttpOutput<ExampleOutput>(
        success: true, rawData: jsonEncode(json));
    expect(output.success, true);
    expect(output.error, null);
    expect(output.data is ExampleOutput, true);
  });
}
