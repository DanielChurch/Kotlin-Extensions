import 'package:test/test.dart';

import 'package:kotlin_extensions/list.dart';
import 'package:kotlin_extensions/object.dart';

import '../../util/expect_extensions.dart';

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
        <int>[].sorted().expectEquals([]);
      });

      test('sorts the values of the returned list', () {
        [2, 3, 1].sorted().expectEquals([1, 2, 3]);
      });

      test('returns a new copy of the list', () {
        [2, 3, 1].let((originalList) {
          originalList.expectNotReference(originalList.sorted());
        });
      });

      test('preserves sort order for equal elements (stable sort)', () {
        final boxedInt1 = Box(3);
        final boxedInt2 = Box(3);
        final list = [Box(5), Box(4), boxedInt1, boxedInt2];
        final result = list.sorted();

        boxedInt1.expect(isNot(boxedInt2));

        result.indexOf(boxedInt1).expectEquals(0);
        result.indexOf(boxedInt2).expectEquals(1);
      });
    });

    group('sortedDescending', () {
      test('handles an empty iterable', () {
        <int>[].sortedDescending().expectEquals([]);
      });

      test('sorts the values of the returned list', () {
        [2, 3, 1].sortedDescending().expectEquals([3, 2, 1]);
      });

      test('returns a new copy of the list', () {
        [2, 3, 1].let((originalList) {
          originalList.expectNotReference(originalList.sortedDescending());
        });
      });

      test('preserves sort order for equal elements (stable sort)', () {
        final boxedInt1 = Box(3);
        final boxedInt2 = Box(3);
        final list = [Box(5), Box(4), boxedInt1, boxedInt2];
        final result = list.sortedDescending();

        boxedInt1.expect(isNot(boxedInt2));

        result.indexOf(boxedInt1).expectEquals(3);
        result.indexOf(boxedInt2).expectEquals(2);
      });
    });
  });
}
