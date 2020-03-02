import 'package:test/test.dart';

import 'map/map_comparable_test.dart' as map_comparable_test;
import 'map/map_object_test.dart' as map_object_test;

void main() {
  group('Map Extensions', () {
    map_comparable_test.main();
    map_object_test.main();
  });
}
