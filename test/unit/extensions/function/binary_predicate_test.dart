import 'package:test/test.dart';

import 'package:kotlin_extensions/function.dart';
import 'package:kotlin_extensions/object.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('on BinaryPredicate (bool Function(K, V))', () {
    bool areEqual(int v1, int v2) => v1 == v2;
    bool isSumOverTwo(int v1, int v2) => v1 + v2 > 2;

    bool areEitherNull(int e1, int e2) => e1 == null || e2 == null;
    bool areBothNonNull(int e1, int e2) => e1 != null && e2 != null;

    group('negate', () {
      test('negates the predicate', () {
        areEqual
          ..call(1, 2).expectIsFalse()
          ..negate()(1, 2).expectIsTrue()
          // -----------------------------
          ..call(1, 1).expectIsTrue()
          ..negate()(1, 1).expectIsFalse();

        isSumOverTwo
          ..call(0, 1).expectIsFalse()
          ..negate()(0, 1).expectIsTrue()
          // -----------------------------
          ..call(2, 1).expectIsTrue()
          ..negate()(2, 1).expectIsFalse();

        areEitherNull
          ..call(null, 1).expectIsTrue()
          ..negate()(null, 1).expectIsFalse()
          // -----------------------------
          ..call(1, 2).expectIsFalse()
          ..negate()(1, 2).expectIsTrue();
      });
    });

    group('and', () {
      test('combines the predicates with AND', () {
        areEqual
          ..call(1, 1).expectIsTrue()
          ..and(isSumOverTwo)(1, 1).expectIsFalse()
          ..and(isSumOverTwo)(5, 1).expectIsFalse()
          ..and(isSumOverTwo)(2, 2).expectIsTrue();

        areBothNonNull
          ..call(2, 1).expectIsTrue()
          ..call(null, 2).expectIsFalse()
          ..and(isSumOverTwo)(0, 0).expectIsFalse()
          ..and(isSumOverTwo)(5, 2).expectIsTrue()
          ..and(isSumOverTwo)(null, 9).expectIsFalse();
      });

      test('order of the predicates matters', () {
        areBothNonNull.and(isSumOverTwo)(null, 9).expectIsFalse();

        expectFailsWith<NoSuchMethodError>(() {
          isSumOverTwo.and(areBothNonNull)(null, 9);
        }).also((error) {
          final errorMessage =
              "NoSuchMethodError: The method '+' was called on null.";

          error.toString().contains(errorMessage).expectIsTrue();
        });
      });
    });

    group('or', () {
      test('combines the predicates with OR', () {
        areEqual
          ..call(1, 1).expectIsTrue()
          ..or(isSumOverTwo)(1, 1).expectIsTrue()
          // -----------------------------
          ..call(1, 2).expectIsFalse()
          ..or(isSumOverTwo)(1, 2).expectIsTrue()
          // -----------------------------
          ..or(isSumOverTwo)(0, 0).expectIsTrue();

        areEitherNull
          ..call(2, 1).expectIsFalse()
          ..call(null, 2).expectIsTrue()
          ..or(isSumOverTwo)(0, 0).expectIsFalse()
          ..or(isSumOverTwo)(5, 2).expectIsTrue()
          ..or(isSumOverTwo)(null, 9).expectIsTrue();
      });

      test('order of the predicates matters', () {
        areEitherNull.or(isSumOverTwo)(null, 9).expectIsTrue();

        expectFailsWith<NoSuchMethodError>(() {
          isSumOverTwo.or(areEitherNull)(null, 9).expectIsTrue();
        }).also((error) {
          final errorMessage =
              'NoSuchMethodError: The method \'+\' was called on null.';

          '$error'.contains(errorMessage).expectIsTrue();
        });
      });
    });
  });
}
