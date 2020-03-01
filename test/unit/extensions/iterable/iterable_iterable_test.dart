@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('for an Iterable<Iterable>', () {
    group('flatten', () {
      test('handles an empty Iterable<Iterable>', () {
        [[], []].flatten().expectEquals([]);
      });

      test('flattens nested iterables into a single one', () {
        [
          [0, 1],
          [2, 3]
        ].flatten().expectEquals([0, 1, 2, 3]);

        [
          [
            [0, 1],
            [2, 3]
          ],
          [4, 5]
        ].flatten().expectEquals([
          [0, 1],
          [2, 3],
          4,
          5
        ]);

        [
          [
            [0, 1],
            [2, 3]
          ].flatten(),
          [4, 5]
        ].flatten().expectEquals([0, 1, 2, 3, 4, 5]);
      });
    });
  });
}
