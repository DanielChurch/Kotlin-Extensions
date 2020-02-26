@TestOn('vm')

import 'extensions/iterable_extensions_test.dart' as iterable_extension_tests;
import 'extensions/list_extensions_test.dart' as list_extension_tests;
import 'extensions/map_extensions_test.dart' as map_extension_tests;
import 'extensions/object_extensions_test.dart' as object_extension_tests;
import 'extensions/set_extensions_test.dart' as set_extension_tests;
import 'objects/pair_test.dart' as pair_extension_tests;

import 'package:test/test.dart';

void main() {
  group('kt_xt', () {
    iterable_extension_tests.main();
    list_extension_tests.main();
    map_extension_tests.main();
    object_extension_tests.main();
    set_extension_tests.main();
    pair_extension_tests.main();
  });
}