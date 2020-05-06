import 'package:test/test.dart';

import 'function/comparator_test.dart' as comparator_tests;
import 'function/binary_predicate_test.dart' as binary_predicate_tests;
import 'function/predicate_test.dart' as predicate_tests;

void main() {
  group('Function extensions', () {
    comparator_tests.main();
    binary_predicate_tests.main();
    predicate_tests.main();
  });
}
