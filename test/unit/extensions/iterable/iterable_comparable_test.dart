@TestOn('vm')

import 'package:test/test.dart';

import 'package:kt_xt/kt_xt.dart';

void main() {
  group('for an Iterable<T extends Comparable>', () {
    group('max', () {
      test('returns the max', () {
        expect([-10, 0, 10].max, 10);
        expect(['Hello', 'World'].max, 'World');
      });

      test('returns null on an empty iterable', () {
        expect(<int>[].max, null);
        expect(<num>[].max, null);
      });
    });

    group('min', () {
      test('returns the min', () {
        expect([-10, 0, 10].min, -10);
        expect(['Hello', 'World'].min, 'Hello');
      });

      test('returns null on an empty iterable', () {
        expect(<int>[].min, null);
        expect(<num>[].min, null);
      });
    });
  });
}
