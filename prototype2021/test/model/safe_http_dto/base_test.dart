import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';

void main() {
  group('[Class] SafeHttpError', testSafeHttpError);
}

void testSafeHttpError() {
  test('should construct the class with error message', () {
    SafeHttpError error = new SafeHttpError(message: 'error msg');
    expect(error.message is String, true);
    expect(error.message.length > 0, true);
  });
}
