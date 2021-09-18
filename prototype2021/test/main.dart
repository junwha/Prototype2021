import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';

void main() {
  test('should return mutated headers', () {
    final String token = 'sometoken';
    Map<String, String> copyOfHeaders = {};
    defaultHeaders.entries.forEach((element) {
      copyOfHeaders[element.key] = element.value;
    });
    copyOfHeaders['Authorization'] = 'jwt $token';
    expect(copyOfHeaders['Authorization'], 'jwt $token');
  });
}
