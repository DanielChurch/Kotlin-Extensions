@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('for an Iterable<Map>', () {
    group('toMap', () {
      test('handles an empty iterable', () {
        expect(<Map>[].toMap(), {});
      });

      test('converts an iterable of maps to a single map', () {
        [
          {1: 2},
          {3: 4},
        ].toMap().expect({1: 2, 3: 4});

        expect(
          [1, 2].map((i) => {'test$i': i}).toMap(),
          {'test1': 1, 'test2': 2},
        );
      });

      test('provides the last value for a given key', () {
        expect(
          [
            {'a': 1},
            {'a': 2},
            {'b': 3},
            {'b': 4},
          ].toMap(),
          {'a': 2, 'b': 4},
        );
      });
    });
  });
}
