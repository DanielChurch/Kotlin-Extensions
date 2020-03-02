import 'package:test/test.dart';

import 'package:kotlin_extensions/function.dart';
import 'package:kotlin_extensions/object.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('on Predicate (bool Function(T))', () {
    bool isLessThanFive(int value) => value < 5;
    bool isMoreThanThree(int value) => value > 3;
    bool isNine(int value) => value == 9;
    bool isNull(int element) => element == null;
    bool isNotNull(int element) => element != null;

    group('negate', () {
      test('negates the predicate', () {
        [4, 5, 6]
          ..where(isLessThanFive).expectEquals([4])
          ..where(isLessThanFive.negate()).expectEquals([5, 6]);

        [null, 2, null, 3, null, 4]
          ..where(isNull).expectEquals([null, null, null])
          ..where(isNull.negate()).expectEquals([2, 3, 4]);
      });
    });

    group('and', () {
      test('combines the predicates with AND', () {
        [2, 3, 4, 5, 6]
            .where(isLessThanFive.and(isMoreThanThree))
            .expectEquals([4]);

        [null, 2, null, 3, null, 4, 8, 9]
          ..where(isNotNull.and(isLessThanFive)).expectEquals([2, 3, 4])
          ..where(isNotNull.and(isMoreThanThree)).expectEquals([4, 8, 9]);
      });

      test('order of the predicates matters', () {
        [null, 1].where(isNotNull.and(isLessThanFive)).expectEquals([1]);

        expectFailsWith<NoSuchMethodError>(() {
          [null, 1].where(isLessThanFive.and(isNotNull)).toList();
        }).also((error) {
          final errorMessage =
              'NoSuchMethodError: The method \'<\' was called on null.';

          '$error'.contains(errorMessage).expectIsTrue();
        });
      });
    });

    group('or', () {
      test('combines the predicates with OR', () {
        [2, 3, 4, 5, 6, 9]
            .where(isLessThanFive.or(isNine))
            .expectEquals([2, 3, 4, 9]);

        [null, 2, null, 3, null, 4, 8, 9]
          ..where(isNotNull.and(isLessThanFive)).expectEquals([2, 3, 4])
          ..where(isNotNull.and(isMoreThanThree)).expectEquals([4, 8, 9]);
      });

      test('order of the predicates matters', () {
        [null, 1, 8].where(isNull.or(isLessThanFive)).expectEquals([null, 1]);

        expectFailsWith<NoSuchMethodError>(() {
          [null, 1, 8].where(isLessThanFive.or(isNull)).toList();
        }).also((error) {
          final errorMessage =
              'NoSuchMethodError: The method \'<\' was called on null.';

          '$error'.contains(errorMessage).expectIsTrue();
        });
      });
    });
  });
}
