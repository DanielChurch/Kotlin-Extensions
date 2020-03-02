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
  group('distinct', () {
    test('handles an empty list', () {
      [].distinct().expectEquals([]);
    });

    test('returns unique elements', () {
      [0, 0, 1, 1, 2, 2, 3, 3].distinct().expectEquals([0, 1, 2, 3]);
    });

    test("doesn't modify the original list", () {
      [0, 1, 2, 3].let((originalList) {
        originalList.expectNotReference(originalList.distinct());
      });
    });
  });

  group('distinctBy', () {
    test('handles an empty iterable', () {
      [].distinctBy((s) => false).expectEquals([]);
    });

    test('returns unique elements based on the passed transform', () {
      ['Hello', 'World', 'Foo']
          .distinctBy((s) => s.length)
          .expectEquals(['Hello', 'Foo']);
    });

    test("doesn't modify the original list", () {
      [0, 1, 2, 3].let((originalList) {
        originalList.expectNotReference(originalList.distinctBy((i) => i));
      });
    });
  });

  group('sortedWith', () {
    test('handles an empty list', () {
      [].sortedWith((i, j) => 1).expectEquals([]);
    });

    test('sorts the values of the returned list', () {
      [2, 3, 1].sortedWith((i, j) => i > j ? 1 : -1).expectEquals([1, 2, 3]);
    });

    test('returns a new copy of the list', () {
      [2, 3, 1].let((originalList) {
        originalList.expectNotReference(
          originalList.sortedWith((i, j) => i > j ? i : j),
        );
      });
    });

    test('preserves sort order for equal elements (stable sort)', () {
      final boxedInt1 = Box(3);
      final boxedInt2 = Box(3);
      final list = [Box(5), Box(4), boxedInt1, boxedInt2];
      final result = list.sortedWith(
        (b1, b2) => b1.value.compareTo(b2.value),
      );

      // Ensure the references are different
      boxedInt1.expect(isNot(boxedInt2));

      result.indexOf(boxedInt1).expectEquals(0);
      result.indexOf(boxedInt2).expectEquals(1);
    });
  });

  group('sortedBy', () {
    test('handles an empty iterable', () {
      [].sortedBy((i) => 5).expectEquals([]);
    });

    test('sorts the values of the returned list', () {
      [2, 3, 1].sortedBy((i) => -i).expectEquals([3, 2, 1]);
    });

    test('returns a new copy of the list', () {
      [2, 3, 1].let((originalList) {
        originalList.expectNotReference(originalList.sortedBy((i) => -i));
      });
    });

    test('preserves sort order for equal elements (stable sort)', () {
      final boxedInt1 = Box(3);
      final boxedInt2 = Box(3);
      final list = [Box(5), Box(4), boxedInt1, boxedInt2];
      final result = list.sortedBy((b) => b.value);

      boxedInt1.expect(isNot(boxedInt2));

      result.indexOf(boxedInt1).expectEquals(0);
      result.indexOf(boxedInt2).expectEquals(1);
    });
  });

  group('sortedByDescending', () {
    test('handles an empty iterable', () {
      [].sortedByDescending((i) => 5).expectEquals([]);
    });

    test('sorts the values of the returned list', () {
      ['a', 'bb', 'ccc']
          .sortedByDescending((s) => s.length)
          .expectEquals(['ccc', 'bb', 'a']);
    });

    test('returns a new copy of the list', () {
      [2, 3, 1].let((originalList) {
        originalList.expectNotReference(
          originalList.sortedByDescending((i) => i),
        );
      });
    });

    test('preserves sort order for equal elements (stable sort)', () {
      final boxedInt1 = Box(3);
      final boxedInt2 = Box(3);
      final list = [Box(5), Box(4), boxedInt1, boxedInt2];
      final result = list.sortedByDescending((i) => i);

      boxedInt1.expect(isNot(boxedInt2));

      result.indexOf(boxedInt1).expectEquals(3);
      result.indexOf(boxedInt2).expectEquals(2);
    });
  });
}
