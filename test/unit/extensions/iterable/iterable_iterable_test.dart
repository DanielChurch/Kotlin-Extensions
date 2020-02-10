@TestOn('vm')

import 'package:test/test.dart';

import 'package:kt_xt/kt_xt.dart';

void main() {
  group('for an Iterable<Iterable>', () {
    group('flatten', () {
      test('handles an empty Iterable<Iterable>', () {
        expect([[], []].flatten(), []);
      });

      test('flattens nested iterables into a single one', () {
        expect(
          [
            [0, 1],
            [2, 3]
          ].flatten(),
          [0, 1, 2, 3],
        );

        expect(
          [
            [
              [0, 1],
              [2, 3]
            ],
            [4, 5]
          ].flatten(),
          [
            [0, 1],
            [2, 3],
            4,
            5
          ],
        );

        expect(
          [
            [
              [0, 1],
              [2, 3]
            ].flatten(),
            [4, 5]
          ].flatten(),
          [0, 1, 2, 3, 4, 5],
        );
      });
    });
  });
}
