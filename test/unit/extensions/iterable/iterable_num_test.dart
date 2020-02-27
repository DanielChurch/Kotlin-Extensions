@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';

void main() {
  group('for an Iterable<num>', () {
    group('average', () {
      test('calculates the average of a list of nums', () {
        expect(<num>[-5, 0, 5].average, 0);
        expect(<num>[2, 2, 2].average, 2);
        expect(<num>[10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average, 1);
      });

      test('returns NaN when empty', () {
        expect(<num>[].average, isNaN);
      });
    });

    group('sum', () {
      test('calculates the average of a list of nums', () {
        expect(<num>[-5, 0, 5].average, 0);
        expect(<num>[2, 2, 2].average, 2);
        expect(<num>[10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average, 1);
      });

      test('returns 0 when empty', () {
        expect(<num>[].sum, 0);
      });
    });
  });

  group('for an Iterable<int>', () {
    group('average', () {
      test('calculates the average of a list of nums', () {
        expect([-5, 0, 5].average, 0);
        expect([2, 2, 2].average, 2);
        expect([10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average, 1);
      });

      test('returns NaN when empty', () {
        expect(<int>[].average, isNaN);
      });
    });

    group('sum', () {
      test('calculates the average of a list of nums', () {
        expect([-5, 0, 5].average, 0);
        expect([2, 2, 2].average, 2);
        expect([10, 0, 0, 0, 0, 0, 0, 0, 0, 0].average, 1);
      });

      test('returns 0 when empty', () {
        expect(<int>[].sum, 0);
      });
    });
  });
}
