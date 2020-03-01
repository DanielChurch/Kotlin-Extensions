@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('for an Iterable<T extends Comparable>', () {
    group('max', () {
      test('returns the max', () {
        [-10, 0, 10].max.expectEquals(10);
        ['Hello', 'World'].max.expectEquals('World');
      });

      test('returns null on an empty iterable', () {
        <int>[].max.expectIsNull();
        <num>[].max.expectIsNull();
      });
    });

    group('min', () {
      test('returns the min', () {
        [-10, 0, 10].min.expectEquals(-10);
        ['Hello', 'World'].min.expectEquals('Hello');
      });

      test('returns null on an empty iterable', () {
        <int>[].min.expectIsNull();
        <num>[].min.expectIsNull();
      });
    });
  });
}
