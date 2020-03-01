@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('for an Iterable<T extends Comparable>', () {
    group('max', () {
      test('returns the max', () {
        [-10, 0, 10].max.expect(10);
        ['Hello', 'World'].max.expect('World');
      });

      test('returns null on an empty iterable', () {
        <int>[].max.expectEqualsNull();
        <num>[].max.expectEqualsNull();
      });
    });

    group('min', () {
      test('returns the min', () {
        [-10, 0, 10].min.expect(-10);
        ['Hello', 'World'].min.expect('Hello');
      });

      test('returns null on an empty iterable', () {
        <int>[].min.expectEqualsNull();
        <num>[].min.expectEqualsNull();
      });
    });
  });
}
