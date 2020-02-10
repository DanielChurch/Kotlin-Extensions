@TestOn('vm')

import 'package:test/test.dart';

import 'object/object_test.dart' as object_test;

void main() {
  group('Object Extensions', () {
    object_test.main();
  });
}
