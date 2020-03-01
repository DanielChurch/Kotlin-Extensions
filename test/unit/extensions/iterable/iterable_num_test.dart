@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('for an Iterable<num>', () {
    group('average', () {
      test('calculates the average of a list of nums', () {
        <num>[-5, 0, 5].average.expectEquals(0);
        <num>[2, 2, 2].average.expectEquals(2);
        <num>[10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average.expectEquals(1);
      });

      test('returns NaN when empty', () {
        <num>[].average.expect(isNaN);
      });
    });

    group('sum', () {
      test('calculates the average of a list of nums', () {
        <num>[-5, 0, 5].average.expectEquals(0);
        <num>[2, 2, 2].average.expectEquals(2);
        <num>[10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average.expectEquals(1);
      });

      test('returns 0 when empty', () {
        <num>[].sum.expectEquals(0);
      });
    });
  });

  group('for an Iterable<int>', () {
    group('average', () {
      test('calculates the average of a list of nums', () {
        [-5, 0, 5].average.expectEquals(0);
        [2, 2, 2].average.expectEquals(2);
        [10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average.expectEquals(1);
      });

      test('returns NaN when empty', () {
        <int>[].average.expect(isNaN);
      });
    });

    group('sum', () {
      test('calculates the average of a list of nums', () {
        [-5, 0, 5].average.expectEquals(0);
        [2, 2, 2].average.expectEquals(2);
        [10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average.expectEquals(1);
      });

      test('returns 0 when empty', () {
        <int>[].sum.expectEquals(0);
      });
    });
  });
}
