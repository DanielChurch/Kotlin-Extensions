import 'extensions/function/binary_predicate_test.dart' as binary_predicate_tests;
import 'extensions/function/predicate_test.dart' as predicate_tests;
import 'extensions/iterable_extensions_test.dart' as iterable_extension_tests;
import 'extensions/list_extensions_test.dart' as list_extension_tests;
import 'extensions/map_extensions_test.dart' as map_extension_tests;
import 'extensions/object_extensions_test.dart' as object_extension_tests;
import 'extensions/set_extensions_test.dart' as set_extension_tests;
import 'objects/pair_test.dart' as pair_extension_tests;

import 'package:test/test.dart';

void main() {
  group('kotlin_extensions', () {
    binary_predicate_tests.main();
    predicate_tests.main();
    iterable_extension_tests.main();
    list_extension_tests.main();
    map_extension_tests.main();
    object_extension_tests.main();
    set_extension_tests.main();
    pair_extension_tests.main();
  });
}
