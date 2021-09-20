import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:prototype2021/model/simple_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SimpleStorage])
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

  final SimpleStorage storage = new SimpleStorage();

  group('Write methods (writeSting, writeInt, etc...)', () {
    test('should write string', () async {
      await storage.writeString('str', strData);
    });

    test('should write int', () async {
      await storage.writeInt('int', intData);
    });

    test('should write double', () async {
      await storage.writeDouble('double', doubleData);
    });

    test('should write bool', () async {
      await storage.writeBool('bool', boolData);
    });

    test('should write map', () async {
      await storage.writeMap('map', mapData);
    });

    test('should write list', () async {
      await storage.writeList('list', listData);
    });
  });

  group('Reading methods (readString, readInt, etc...)', () {
    test('should read string', () async {
      expect(await storage.readString('str'), strData);
    });

    test('should read int', () async {
      expect(await storage.readInt('int'), intData);
    });

    test('should read double', () async {
      expect(await storage.readDouble('double'), doubleData);
    });

    test('should read bool', () async {
      expect(await storage.readBool('bool'), boolData);
    });

    test('should read map', () async {
      expect(await storage.readMap('map'), mapData);
    });

    test('should read list', () async {
      expect(await storage.readList('list'), listData);
    });
  });
}
