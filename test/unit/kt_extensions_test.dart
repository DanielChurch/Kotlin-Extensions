@TestOn('vm')

import 'extensions/iterable_extensions_test.dart' as iterable;
import 'extensions/list_extensions_test.dart' as list;
import 'extensions/map_extensions_test.dart' as map;
import 'extensions/object_extensions_test.dart' as object;
import 'objects/pair_test.dart' as pair;

import 'package:test/test.dart';

void main() {
  group('kt_xt', () {
    iterable.main();
    list.main();
    map.main();
    object.main();
    pair.main();
  });
}
