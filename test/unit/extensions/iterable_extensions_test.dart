import 'package:test/test.dart';

import 'iterable/iterable_comparable_test.dart' as iterable_comparable_test;
import 'iterable/iterable_iterable_test.dart' as iterable_iterable_test;
import 'iterable/iterable_map_test.dart' as iterable_map_test;
import 'iterable/iterable_num_test.dart' as iterable_num_test;
import 'iterable/iterable_object_test.dart' as iterable_object_test;

void main() {
  group('Iterable Extensions', () {
    iterable_comparable_test.main();
    iterable_iterable_test.main();
    iterable_map_test.main();
    iterable_num_test.main();
    iterable_object_test.main();
  });
}
