import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  group('[Class] SimpleStorage', testSimpleStorage);
}

void testSimpleStorage() {
  final String strData = "example";
  final int intData = 0;
  final double doubleData = 0.0;
  final bool boolData = true;
  final Map<String, dynamic> mapData = {
    "key1": "value",
    "key2": 1,
    "key3": false,
    "key4": 0.1
  };
  final List<dynamic> listData = ["value", 2, 2.4, false];

  group('Write methods (writeSting, writeInt, etc...)', () {
    test('should write string', () async {
      await SimpleStorage.writeString('str', strData);
    });

    test('should write int', () async {
      await SimpleStorage.writeInt('int', intData);
    });

    test('should write double', () async {
      await SimpleStorage.writeDouble('double', doubleData);
    });

    test('should write bool', () async {
      await SimpleStorage.writeBool('bool', boolData);
    });

    test('should write map', () async {
      await SimpleStorage.writeMap('map', mapData);
    });

    test('should write list', () async {
      await SimpleStorage.writeList('list', listData);
    });
  });

  group('Reading methods (readString, readInt, etc...)', () {
    test('should read string', () async {
      expect(await SimpleStorage.readString('str'), strData);
    });

    test('should read int', () async {
      expect(await SimpleStorage.readInt('int'), intData);
    });

    test('should read double', () async {
      expect(await SimpleStorage.readDouble('double'), doubleData);
    });

    test('should read bool', () async {
      expect(await SimpleStorage.readBool('bool'), boolData);
    });

    test('should read map', () async {
      expect(await SimpleStorage.readMap('map'), mapData);
    });

    test('should read list', () async {
      expect(await SimpleStorage.readList('list'), listData);
    });
  });
}
