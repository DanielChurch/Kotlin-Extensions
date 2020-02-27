@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/list.dart';
import 'package:kotlin_extensions/object.dart';

class Box<T extends Comparable> implements Comparable<Box<T>> {
  T value;

  Box([this.value]);

  @override
  int compareTo(Box<T> other) => value.compareTo(other.value);
}

void main() {
  group('distinct', () {
    test('handles an empty list', () {
      expect([].distinct(), []);
    });

    test('returns unique elements', () {
      expect(
        [0, 0, 1, 1, 2, 2, 3, 3].distinct(),
        [0, 1, 2, 3],
      );
    });

    test("doesn't modify the original list", () {
      [0, 1, 2, 3].let((originalList) {
        originalList.distinct();

        expect(originalList, [0, 1, 2, 3]);
      });
    });

    test('returns the correct type', () {
      expect(<int>[0].distinct(), isA<List<int>>());
      expect(<String>[''].distinct(), isA<List<String>>());
    });
  });

  group('distinctBy', () {
    test('handles an empty iterable', () {
      expect([].distinctBy((s) => false), []);
    });

    test('returns unique elements based on the passed transform', () {
      expect(
        ['Hello', 'World', 'Foo'].distinctBy((s) => s.length),
        ['Hello', 'Foo'],
      );
    });

    test('passes the correct type & value', () {
      var passedValue;
      <int>[0].distinctBy((i) => passedValue = i);

      expect(passedValue, isA<int>());
      expect(passedValue, 0);

      ['test'].distinctBy((i) => passedValue = i);

      expect(passedValue, isA<String>());
      expect(passedValue, 'test');
    });

    test("doesn't modify the original list", () {
      final originalList = [0, 1, 2, 3];
      originalList.distinctBy((i) => 0);

      expect(originalList, [0, 1, 2, 3]);
    });

    test('returns the correct type', () {
      expect(<int>[0].distinctBy((i) => i), isA<List<int>>());
      expect([''].distinctBy((s) => s.length), isA<List<String>>());
    });
  });

  group('sortedWith', () {
    test('handles an empty list', () {
      expect([].sortedWith((i, j) => 1), []);
    });

    test('sorts the values of the returned list', () {
      expect([2, 3, 1].sortedWith((i, j) => i > j ? 1 : -1), [1, 2, 3]);
    });

    test('returns a new copy of the list', () {
      final originalList = [2, 3, 1];
      final sortedList = originalList.sortedWith((i, j) => i > j ? i : j);
      sortedList.remove(3);

      expect(originalList, [2, 3, 1]);
    });

    test('returns the correct type', () {
      expect(
        <int>[0, 1].sortedWith((i, j) => 1),
        isA<List<int>>(),
      );

      expect(
        ['Hello', 'World'].sortedWith((i, j) => 1),
        isA<List<String>>(),
      );
    });

    test('passes the correct type', () {
      var passedFirstElement, passedSecondElement;
      <int>[0, 1].sortedWith((i, j) {
        passedFirstElement = i;
        passedSecondElement = j;

        return 1;
      });

      expect(passedFirstElement, isA<int>());
      expect(passedSecondElement, isA<int>());

      ['Hello', 'World'].sortedWith((i, j) {
        passedFirstElement = i;
        passedSecondElement = j;

        return 1;
      });

      expect(passedFirstElement, isA<String>());
      expect(passedSecondElement, isA<String>());
    });

    test('preserves sort order for equal elements (stable sort)', () {
      final boxedInt1 = Box(3);
      final boxedInt2 = Box(3);
      final list = [Box(5), Box(4), boxedInt1, boxedInt2];
      final result = list.sortedWith(
        (b1, b2) => b1.value.compareTo(b2.value),
      );

      // Ensure the references are different
      expect(boxedInt1, isNot(boxedInt2));

      expect(result.indexOf(boxedInt1), 0);
      expect(result.indexOf(boxedInt2), 1);
    });
  });

  group('sortedBy', () {
    test('handles an empty iterable', () {
      expect([].sortedBy((i) => 5), []);
    });

    test('sorts the values of the returned list', () {
      expect([2, 3, 1].sortedBy((i) => -i), [3, 2, 1]);
    });

    test('returns a new copy of the list', () {
      [2, 3, 1].let((originalList) {
        final sortedList = originalList.sortedBy((i) => -i);
        sortedList.remove(3);

        expect(originalList, [2, 3, 1]);
      });
    });

    test('passes the correct type', () {
      var passedValue;
      <int>[0, 1].sortedBy((i) => passedValue = i);

      expect(passedValue, isA<int>());

      [''].sortedBy((i) => passedValue = i);

      expect(passedValue, isA<String>());
    });

    test('returns the correct type', () {
      expect(<int>[0, 1].sortedBy((i) => i), isA<List<int>>());
      expect([''].sortedBy((i) => i), isA<List<String>>());
    });

    test('preserves sort order for equal elements (stable sort)', () {
      final boxedInt1 = Box(3);
      final boxedInt2 = Box(3);
      final list = [Box(5), Box(4), boxedInt1, boxedInt2];
      final result = list.sortedBy((b) => b.value);

      expect(boxedInt1, isNot(boxedInt2));

      expect(result.indexOf(boxedInt1), 0);
      expect(result.indexOf(boxedInt2), 1);
    });
  });

  group('sortedByDescending', () {
    test('handles an empty iterable', () {
      expect([].sortedByDescending((i) => 5), []);
    });

    test('sorts the values of the returned list', () {
      expect(
        ['a', 'bb', 'ccc'].sortedByDescending((s) => s.length),
        ['ccc', 'bb', 'a'],
      );
    });

    test('returns a new copy of the list', () {
      [2, 3, 1].let((originalList) {
        final sortedList = originalList.sortedByDescending((i) => i);
        sortedList.remove(3);

        expect(originalList, [2, 3, 1]);
      });
    });

    test('returns the correct type', () {
      expect(<int>[0].sortedByDescending((i) => ''), isA<List<int>>());
      expect([''].sortedByDescending((i) => i.length), isA<List<String>>());
    });

    test('preserves sort order for equal elements (stable sort)', () {
      final boxedInt1 = Box(3);
      final boxedInt2 = Box(3);
      final list = [Box(5), Box(4), boxedInt1, boxedInt2];
      final result = list.sortedByDescending((i) => i);

      expect(boxedInt1, isNot(boxedInt2));

      expect(result.indexOf(boxedInt1), 3);
      expect(result.indexOf(boxedInt2), 2);
    });
  });
}
