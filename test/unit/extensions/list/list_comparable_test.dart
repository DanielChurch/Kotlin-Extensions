@TestOn('vm')

import 'package:test/test.dart';

import 'package:kt_xt/kt_xt.dart';

class Box<T extends Comparable> implements Comparable<Box<T>> {
  T value;

  Box([this.value]);

  @override
  int compareTo(Box<T> other) => value.compareTo(other.value);
}

void main() {
  group('for List<T extends Comparable>', () {
    group('sorted', () {
      test('handles an empty list', () {
        expect(<int>[].sorted(), []);
      });

      test('sorts the values of the returned list', () {
        expect([2, 3, 1].sorted(), [1, 2, 3]);
      });

      test('returns a new copy of the list', () {
        [2, 3, 1].let((originalList) {
          final sortedList = originalList.sorted();
          sortedList.remove(3);

          expect(originalList, [2, 3, 1]);
        });
      });

      test('returns the correct type', () {
        expect(<int>[0].sorted(), isA<List<int>>());
        expect([''].sorted(), isA<List<String>>());
      });

      test('preserves sort order for equal elements (stable sort)', () {
        final boxedInt1 = Box(3);
        final boxedInt2 = Box(3);
        final list = [Box(5), Box(4), boxedInt1, boxedInt2];
        final result = list.sorted();

        expect(boxedInt1, isNot(boxedInt2));

        expect(result.indexOf(boxedInt1), 0);
        expect(result.indexOf(boxedInt2), 1);
      });
    });

    group('sortedDescending', () {
      test('handles an empty iterable', () {
        expect(<int>[].sortedDescending(), []);
      });

      test('sorts the values of the returned list', () {
        expect([2, 3, 1].sortedDescending(), [3, 2, 1]);
      });

      test('returns a new copy of the list', () {
        [2, 3, 1].let((originalList) {
          final sortedList = originalList.sortedDescending();
          sortedList.remove(3);

          expect(originalList, [2, 3, 1]);
        });
      });

      test('returns the correct type', () {
        expect(<int>[0].sortedDescending(), isA<List<int>>());
        expect([''].sortedDescending(), isA<List<String>>());
      });

      test('preserves sort order for equal elements (stable sort)', () {
        final boxedInt1 = Box(3);
        final boxedInt2 = Box(3);
        final list = [Box(5), Box(4), boxedInt1, boxedInt2];
        final result = list.sortedDescending();

        expect(boxedInt1, isNot(boxedInt2));

        expect(result.indexOf(boxedInt1), 3);
        expect(result.indexOf(boxedInt2), 2);
      });
    });
  });
}
