import 'package:kotlin_extensions/function.dart';
import 'package:kotlin_extensions/list.dart';
import 'package:kotlin_extensions/pair.dart';
import 'package:test/test.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('on Comparator<T> (int Function(T, T)', () {
    group('compareBy', () {
      test('handles null input', () {
        expectReturnsNormally(() => compareBy(null));
        expectReturnsNormally(() => compareBy(
            null, null, null, null, null, null, null, null, null, null));
      });

      test('returns the correct value', () {
        final values = [
          Pair(2, 'A'),
          Pair(1, 'B'),
          Pair(2, 'ZZ'),
          Pair(1, 'A'),
          Pair(3, '-'),
        ];

        values.sortedWith(compareBy((pair) => pair.second))
          ..map(Pair.getFirst).expectEquals([3, 2, 1, 1, 2])
          ..map(Pair.getSecond).expectEquals(['-', 'A', 'A', 'B', 'ZZ']);

        values.sortedWith(compareBy(
          Pair.getFirst,
          (pair) => pair.second.length,
          Pair.getSecond,
        ))
          ..map(Pair.getFirst).expectEquals([1, 1, 2, 2, 3])
          ..map(Pair.getSecond).expectEquals(['A', 'B', 'A', 'ZZ', '-']);

        values.sortedWith(compareBy(null, null, null, Pair.getFirst,
            (pair) => pair.second.length, Pair.getSecond))
          ..map(Pair.getFirst).expectEquals([1, 1, 2, 2, 3])
          ..map(Pair.getSecond).expectEquals(['A', 'B', 'A', 'ZZ', '-']);

        values.sortedWith(compareBy(null, null, null, null, null, null, null,
            Pair.getFirst, (pair) => pair.second.length, Pair.getSecond))
          ..map(Pair.getFirst).expectEquals([1, 1, 2, 2, 3])
          ..map(Pair.getSecond).expectEquals(['A', 'B', 'A', 'ZZ', '-']);
      });
    });

    group('compareByDescending', () {
      test('returns the correct value', () {
        final values = [
          Pair(2, 'A'),
          Pair(1, 'B'),
          Pair(2, 'ZZ'),
          Pair(1, 'A'),
          Pair(3, '-'),
        ];

        values.sortedWith(compareByDescending((pair) => pair.second))
          ..map(Pair.getFirst).expectEquals([2, 1, 2, 1, 3])
          ..map(Pair.getSecond).expectEquals(['ZZ', 'B', 'A', 'A', '-']);

        values.sortedWith(compareByDescending(
          Pair.getFirst,
          (pair) => pair.second.length,
          Pair.getSecond,
        ))
          ..map(Pair.getFirst).expectEquals([3, 2, 2, 1, 1])
          ..map(Pair.getSecond).expectEquals(['-', 'ZZ', 'A', 'B', 'A']);

        values.sortedWith(compareByDescending(null, null, null, Pair.getFirst,
            (pair) => pair.second.length, Pair.getSecond))
          ..map(Pair.getFirst).expectEquals([3, 2, 2, 1, 1])
          ..map(Pair.getSecond).expectEquals(['-', 'ZZ', 'A', 'B', 'A']);

        values.sortedWith(compareByDescending(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          Pair.getFirst,
          (pair) => pair.second.length,
          Pair.getSecond,
        ))
          ..map(Pair.getFirst).expectEquals([3, 2, 2, 1, 1])
          ..map(Pair.getSecond).expectEquals(['-', 'ZZ', 'A', 'B', 'A']);
      });
    });

    group('reversed', () {
      test('returns the correct value', () {
        final data = ['Foo', 'Hello', 'Baz', 'World', 'Four'];

        data
            .sortedWith(compareBy((s) => s.length))
            .expectEquals(['Foo', 'Baz', 'Four', 'Hello', 'World']);
        data
            .sortedWith(compareBy<String>((s) => s.length).reversed)
            .expectEquals(['Hello', 'World', 'Four', 'Foo', 'Baz']);
      });
    });

    group('then', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() {
          compareBy<String>((s) => s).then(null);
        }).verifyArgumentError(
          name: 'comparator',
          message: 'Must not be null',
        );
      });

      test('chains the comparators together', () {
        final data = ['Foo', 'Hello', 'Baz', 'World', 'Four'];

        final comparator = compareBy<String>(
          (s) => s.length,
        ).then(compareBy((s) => s));

        data.sortedWith(comparator)
          ..expectEquals(['Baz', 'Foo', 'Four', 'Hello', 'World']);
      });
    });

    group('thenBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() {
          compareBy<String>((s) => s).thenBy(null);
        }).verifyArgumentError(
          name: 'selector',
          message: 'Must not be null',
        );
      });

      test('chains the comparators together', () {
        final data = ['Foo', 'Hello', 'Baz', 'World', 'Four'];

        data.sortedWith(compareBy<String>((s) => s.length).thenBy((s) => s))
          ..expectEquals(['Baz', 'Foo', 'Four', 'Hello', 'World']);
      });
    });

    group('thenByDescending', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() {
          compareBy<String>((s) => s).thenByDescending(null);
        }).verifyArgumentError(
          name: 'selector',
          message: 'Must not be null',
        );
      });

      test('chains the comparators together', () {
        final data = ['Foo', 'Hello', 'Baz', 'World', 'Four'];

        data.sortedWith(compareBy<String>(
          (s) => s.length,
        ).thenByDescending((s) => s))
          ..expectEquals(['Foo', 'Baz', 'Four', 'World', 'Hello']);
      });
    });

    group('thenComparator', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() {
          compareBy<String>((s) => s).then(null);
        }).verifyArgumentError(
          name: 'comparator',
          message: 'Must not be null',
        );
      });

      test('chains the comparators together', () {
        final data = ['Foo', 'Hello', 'Baz', 'World', 'Four'];

        final comparator = compareBy<String>(
          (s) => s.length,
        ).thenComparator(compareBy((s) => s));

        data.sortedWith(comparator)
          ..expectEquals(['Baz', 'Foo', 'Four', 'Hello', 'World']);
      });
    });

    group('thenDescending', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() {
          compareBy<String>((s) => s).thenDescending(null);
        }).verifyArgumentError(
          name: 'comparator',
          message: 'Must not be null',
        );
      });

      test('chains the comparators together', () {
        final data = ['Foo', 'Hello', 'Baz', 'World', 'Four'];

        data.sortedWith(compareBy<String>((s) => s.length)
            .thenDescending(compareBy((s) => s)))
          ..expectEquals(['Foo', 'Baz', 'Four', 'World', 'Hello']);
      });
    });
  });
}
