import 'package:test/test.dart';

import 'function/binary_predicate_test.dart' as binary_predicate_tests;
import 'function/predicate_test.dart' as predicate_tests;

void main() {
  group('Function extensions', () {
    binary_predicate_tests.main();
    predicate_tests.main();
  });
}
