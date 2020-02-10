@TestOn('vm')

import 'package:test/test.dart';

import 'map/map_object_test.dart' as map_object_test;

void main() {
  group('Map Extensions', () {
    map_object_test.main();
  });
}
