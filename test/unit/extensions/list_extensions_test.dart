@TestOn('vm')

import 'package:test/test.dart';

import 'list/list_comparable_test.dart' as list_comparable_test;
import 'list/list_object_test.dart' as list_object_test;

void main() {
  group('List Extensions', () {
    list_comparable_test.main();
    list_object_test.main();
  });
}
