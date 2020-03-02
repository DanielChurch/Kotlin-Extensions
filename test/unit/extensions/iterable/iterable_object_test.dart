import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';
import 'package:kotlin_extensions/object.dart';
import 'package:kotlin_extensions/src/pair.dart';

import '../../util/expect_extensions.dart';

class TestObj {
  int x;

  TestObj([this.x]);
}

void main() {
  group('on Iterable<T>', () {
    group('associate', () {
      test('throws on null input', () {
        expectFailsWith<ArgumentError>(() => [].associate(null)).also(
          verifyArgumentError(name: 'transform', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        <int>[].associate((i) => i.to(i)).expectEquals({});
      });

      test('returns the correct value', () {
        ['Hello', 'World', 'Foo']
            .associate((str) => str.to(str.length))
            .expectEquals({'Hello': 5, 'World': 5, 'Foo': 3});
      });

      test('uses the last common key', () {
        [0, 1, 2].associate((i) => 0.to(i)).expectEquals({0: 2});
      });

      test('returns the correct type', () {
        ['Hello', 'World', 'Foo']
            .associate((str) => str.to(str.length))
            .expectIsA<Map<String, int>>();
      });
    });

    group('associateBy', () {
      test('throws on null input', () {
        expectFailsWith<ArgumentError>(
          () => [].associateBy(key: null, value: null),
        ).also(verifyArgumentError(message: 'key and value must not be null'));

        expectFailsWith<ArgumentError>(
          () => [].associateBy(key: null, value: (i) => i),
        ).also(verifyArgumentError(name: 'key', message: 'Must not be null'));

        expectFailsWith<ArgumentError>(
          () => [].associateBy(key: (i) => i, value: null),
        ).also(verifyArgumentError(name: 'value', message: 'Must not be null'));
      });

      test('handles an empty iterable', () {
        [].associateBy(key: (i) => i, value: (i) => i).expectEquals({});
      });

      test('returns the correct value', () {
        [0, 1, 2]
            .associateBy(key: (i) => i, value: (i) => '$i')
            .expectEquals({0: '0', 1: '1', 2: '2'});

        ['Hello', 'World']
            .associateBy(
                key: (str) => str.toLowerCase(),
                value: (str) => str.toUpperCase())
            .expectEquals({'hello': 'HELLO', 'world': 'WORLD'});
      });
    });

    group('associateWith', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].associateWith(null)).also(
          verifyArgumentError(
            name: 'valueSelector',
            message: 'Must not be null',
          ),
        );
      });

      test('handles an empty iterable', () {
        [].associateWith((i) => i).expectEquals({});
      });

      test('correctly applies the valueSelector', () {
        [0, 1, 2, 3]
            .associateWith((i) => -i)
            .values
            .expectEquals([0, -1, -2, -3]);
      });
    });

    group('containsAll', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].containsAll(null)).also(
          verifyArgumentError(name: 'elements', message: 'Must not be null'),
        );
      });

      test('handles empty iterables', () {
        [0, 1, 2].containsAll([]).expectIsTrue();
        [].containsAll([0, 1]).expectIsFalse();
        [].containsAll([]).expectIsTrue();
      });

      test('returns true when it contains all elements', () {
        [0, 1, 2].containsAll([0]).expectIsTrue();
        [0, 1, 2].containsAll([0, 1, 2]).expectIsTrue();
        ['Hello', 'World'].containsAll(['Hello']).expectIsTrue();
      });

      test('returns false when it does not contain all elements', () {
        [0, 1, 2].containsAll([4]).expectIsFalse();
        [0, 1, 2].containsAll([0, 1, 2, 8]).expectIsFalse();
        ['Hello', 'World'].containsAll(['Hello', 'Foo']).expectIsFalse();
      });
    });

    group('firstOrNull', () {
      test('returns null when the list is null or empty', () {
        Iterable<int> iter;
        iter.firstOrNull.expectIsNull();
        <String>[].firstOrNull.expectIsNull();
      });

      test('returns the first element', () {
        [0, 1, 2].firstOrNull.expectEquals(0);
        ['Hello', 'World'].firstOrNull.expectEquals('Hello');
      });
    });

    group('flatMap', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].flatMap(null)).also(
          verifyArgumentError(name: 'transform', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        [].flatMap((i) => [i]).expectEquals([]);
      });

      test('flattens the result', () {
        [1, 2, 3].flatMap((i) => [i, i * 5]).expectEquals([1, 5, 2, 10, 3, 15]);

        [
          [0, 1, 2],
          [3, 4, 5],
        ].flatMap((i) => i).expectEquals([0, 1, 2, 3, 4, 5]);
      });

      test('applies transform', () {
        [0, 1, 2].flatMap((i) => [i + 2]).expectEquals([2, 3, 4]);

        ['t', 'e', 's', 't']
            .flatMap((i) => [i, '.'])
            .expectEquals(['t', '.', 'e', '.', 's', '.', 't', '.']);
      });
    });

    group('forEachIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].forEachIndexed(null)).also(
          verifyArgumentError(
            name: 'indexedAction',
            message: 'Must not be null',
          ),
        );
      });

      test('handles an empty iterable', () {
        expectReturnsNormally(() => [].forEachIndexed((i, e) {}));
      });

      test('passes the correct indices (starting with 0)', () {
        <int>[].also((indices) {
          [5, 5, 5, 5, 5].forEachIndexed((i, e) => indices.add(i));
        }).expectEquals([0, 1, 2, 3, 4]);

        <int>[].also((indices) {
          ['t', 'e', 's', 't'].forEachIndexed((i, e) => indices.add(i));
        }).expectEquals([0, 1, 2, 3]);
      });

      test('passes the correct values', () {
        <int>[].also((values) {
          [5, 5, 5, 5, 5].forEachIndexed((i, e) => values.add(e));
        }).expectEquals([5, 5, 5, 5, 5]);

        <String>[].also((values) {
          ['test'].forEachIndexed((i, e) => values.add(e));
        }).expectEquals(['test']);
      });
    });

    group('groupBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].groupBy(null)).also(
          verifyArgumentError(
            name: 'keySelector',
            message: 'Must not be null',
          ),
        );
      });

      test('handles an empty iterable', () {
        expect([].groupBy((s) => s), {});
      });

      test('groups by the keySelector', () {
        expect(
          ['Hello', 'World', 'Foo'].groupBy((s) => s.length),
          {
            3: ['Foo'],
            5: ['Hello', 'World']
          },
        );
      });
    });

    group('isNullOrEmpty', () {
      test('returns true when the iterable is null or empty', () {
        Iterable iter;
        iter.isNullOrEmpty.expectIsTrue();
        [].isNullOrEmpty.expectIsTrue();
      });

      test('returns false when the iterable has values', () {
        [0, 1].isNullOrEmpty.expectIsFalse();
        ['Hello', 'World'].isNullOrEmpty.expectIsFalse();
      });
    });

    group('lastOrNull', () {
      test('returns null when the list is null or empty', () {
        Iterable<int> iter;
        iter.lastOrNull.expectIsNull();
        <String>[].lastOrNull.expectIsNull();
      });

      test('returns the first element', () {
        [0, 1, 2].lastOrNull.expectEquals(2);
        ['Hello', 'World'].lastOrNull.expectEquals('World');
      });
    });

    group('mapIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].mapIndexed(null)).also(
          verifyArgumentError(
            name: 'indexedTransform',
            message: 'Must not be null',
          ),
        );
      });

      test('handles an empty iterable', () {
        [].mapIndexed((i, j) => i).expectEquals([]);
      });

      test('passes the correct indices (starting with 0)', () {
        [5, 5, 5, 5, 5].mapIndexed((i, e) => i).expectEquals([0, 1, 2, 3, 4]);
        ['t', 'e', 's', 't'].mapIndexed((i, e) => i).expectEquals([0, 1, 2, 3]);
      });

      test('passes the correct values', () {
        [5, 5, 5, 5, 5].mapIndexed((i, e) => e).expectEquals([5, 5, 5, 5, 5]);
        ['test'].mapIndexed((i, e) => e).expectEquals(['test']);
      });

      test('applies transform', () {
        [1, 2, 3].mapIndexed((i, e) => i + e).expectEquals([1, 3, 5]);
      });
    });

    group('mapIndexedNotNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].mapIndexedNotNull(null)).also(
          verifyArgumentError(
            name: 'indexedTransform',
            message: 'Must not be null',
          ),
        );
      });

      test('handles an empty iterable', () {
        [].mapIndexedNotNull((i, e) => e).expectEquals([]);
      });

      test('removes null values', () {
        [0, 1, 2, 3, 4]
            .mapIndexedNotNull((i, e) => e % 2 == 0 ? null : i)
            .expectEquals([1, 3]);

        ['f', 'o', 'o']
            .mapIndexedNotNull((i, e) => e == 'f' ? null : e)
            .expectEquals(['o', 'o']);
      });

      test('passes the correct indices (starting with 0)', () {
        [5, 5, 5, 5, 5]
            .mapIndexedNotNull((i, e) => i)
            .expectEquals([0, 1, 2, 3, 4]);

        ['t', 'e', 's', 't']
            .mapIndexedNotNull((i, e) => i)
            .expectEquals([0, 1, 2, 3]);
      });

      test('passes the correct values', () {
        [5, 5, 5, 5, 5]
            .mapIndexedNotNull((i, e) => e)
            .expectEquals([5, 5, 5, 5, 5]);
        ['test'].mapIndexedNotNull((i, e) => e).expectEquals(['test']);
      });

      test('applies transform', () {
        [1, 2, 3].mapIndexedNotNull((i, e) => i + e).expectEquals([1, 3, 5]);
      });
    });

    group('mapNotNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].mapNotNull(null)).also(
          verifyArgumentError(name: 'transform', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        [].mapNotNull((e) => e).expectEquals([]);
      });

      test('removes null values', () {
        [0, 1, 2, 3, 4].mapNotNull((i) => i % 2 == 0 ? null : i).expectEquals(
          [1, 3],
        );

        ['t', 'e', 's', 't']
            .mapNotNull((i) => i == 't' ? null : i)
            .expectEquals(
          ['e', 's'],
        );
      });

      test('applies transform', () {
        [0, 1, 2, 3, 4].mapNotNull((i) => i + 2).expectEquals([2, 3, 4, 5, 6]);

        ['t', 'e', 's', 't'].mapNotNull((i) => '$i.').expectEquals(
          ['t.', 'e.', 's.', 't.'],
        );
      });
    });

    group('maxBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].maxBy(null)).also(
          verifyArgumentError(name: 'selector', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        <int>[].maxBy((i) => i).expectIsNull();
      });

      test('returns the maximum transformed value', () {
        [0].maxBy((i) => i).expectEquals(0);
        [0, 1, 2].maxBy((i) => -i).expectEquals(0);
        ['Hello', 'Foo'].maxBy((str) => str.length).expectEquals('Hello');
      });

      test('returns the first element when there are duplicates', () {
        ['Foo', 'Bar'].maxBy((str) => str.length).expectEquals('Foo');
      });
    });

    group('maxWith', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].maxWith(null)).also(
          verifyArgumentError(name: 'comparator', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        <int>[].maxWith((i, j) => 1).expectIsNull();
      });

      test('returns the expected max value based on the comparator', () {
        [0, 1, 2, 3].maxWith((i, j) => i > j ? 1 : -1).expectEquals(3);
        [0, 1, 2, 3].maxWith((i, j) => i < j ? 1 : -1).expectEquals(0);
      });

      test('returns the first element when there are duplicates', () {
        ['Foo', 'Bar']
            .maxWith((s1, s2) => s1.length.compareTo(s2.length))
            .expectEquals('Foo');
      });
    });

    group('minBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].minBy(null)).also(
          verifyArgumentError(name: 'selector', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        <int>[].minBy((i) => i).expectIsNull();
      });

      test('returns the minimum transformed value', () {
        [-5, 0, 7].minBy((i) => -i).expectEquals(7);
      });

      test('returns the first element when there are duplicates', () {
        ['Foo', 'Bar'].minBy((str) => str.length).expectEquals('Foo');
      });
    });

    group('minWith', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].maxWith(null)).also(
          verifyArgumentError(name: 'comparator', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        <int>[].minWith((i, j) => 1).expectIsNull();
      });

      test('returns the expected min value based on the comparator', () {
        [0, 1, 2, 3].minWith((i, j) => i > j ? 1 : -1).expectEquals(0);
        [0, 1, 2, 3].minWith((i, j) => i < j ? 1 : -1).expectEquals(3);
      });

      test('returns the first element when there are duplicates', () {
        ['Foo', 'Bar']
            .minWith((s1, s2) => s1.length.compareTo(s2.length))
            .expectEquals('Foo');
      });
    });

    group('none', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].none(null)).also(
          verifyArgumentError(name: 'predicate', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        [].none((i) => false).expectEquals(true);
      });
    });

    group('partition', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].partition(null)).also(
          verifyArgumentError(name: 'predicate', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        [].partition((i) => false).let((pair) {
          pair.first.expectEquals([]);
          pair.second.expectEquals([]);
        });
      });

      test('partitions the iterable based on the predicate', () {
        [0, 1, 2, 3, 4, 5].partition((i) => i > 2).let((partition) {
          partition
            ..first.expectEquals([3, 4, 5])
            ..second.expectEquals([0, 1, 2]);
        });
      });

      test('leaves the original Iterable unmodified', () {
        [0, 1, 2].let((originalList) {
          originalList
            ..partition((i) => i % 2 == 0)
            ..expectEquals([0, 1, 2]);
        });
      });
    });

    group('reduceIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [0].reduceIndexed(null)).also(
          verifyArgumentError(
            name: 'indexedCombine',
            message: 'Must not be null',
          ),
        );
      });

      test('throws when empty', () {
        expectFailsWith<StateError>(() => [].reduceIndexed((i, e, e2) => 0));
      });

      test('returns the correct value', () {
        // (1 + 0 + 1) => (2 + 2 + 2) => 6
        [0, 1, 2].reduceIndexed((index, e1, e2) => index + e1 + e2).expect(6);

        ['H', 'E', 'L', 'L', 'O']
            .reduceIndexed((index, e1, e2) => '$e1$e2-$index')
            .expect('HE-1L-2L-3O-4');
      });
    });

    group('reduceIndexedOrNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].reduceIndexedOrNull(null)).also(
          verifyArgumentError(name: 'combine', message: 'Must not be null'),
        );
      });

      test('returns null when the iterable is empty', () {
        <int>[].reduceIndexedOrNull((index, e1, e2) => 0).expectIsNull();
      });

      test('returns the correct value', () {
        // (1 + 0 + 1) => (2 + 2 + 2) => 6
        [0, 1, 2]
            .reduceIndexedOrNull((index, e1, e2) => index + e1 + e2)
            .expectEquals(6);

        ['H', 'E', 'L', 'L', 'O']
            .reduceIndexedOrNull((index, e1, e2) => '$e1$e2-$index')
            .expectEquals('HE-1L-2L-3O-4');
      });
    });

    group('whereIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].whereIndexed(null)).also(
          verifyArgumentError(
            name: 'indexedPredicate',
            message: 'Must not be null',
          ),
        );
      });

      test('handles an empty iterable', () {
        [].whereIndexed((i, e) => true).expectEquals([]);
      });

      test('passes the correct indices (starting with 0)', () {
        <int>[].let((indices) {
          [5, 5, 5, 5, 5].whereIndexed((i, e) {
            indices.add(i);
            return true;
          }).toList();

          indices.expectEquals([0, 1, 2, 3, 4]);
        });

        <int>[].let((indices) {
          ['t', 'e', 's', 't'].whereIndexed((i, e) {
            indices.add(i);
            return true;
          }).toList();

          indices.expectEquals([0, 1, 2, 3]);
        });
      });

      test('returns values based on the predicate', () {
        [0, 1, 2].whereIndexed((i, e) => i == 0 || i == 1).expectEquals([0, 1]);
      });

      test('leaves the original Iterable unmodified', () {
        [0, 1, 2].let((originalList) {
          originalList
            ..whereIndexed((i, e) => i % 2 == 0)
            ..expectEquals([0, 1, 2]);
        });
      });
    });

    group('whereIsNotNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].whereIsNotNull(null)).also(
          verifyArgumentError(name: 'transform', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        [].whereIsNotNull((i) => i).expectEquals([]);
      });

      test('removes null values', () {
        [1, 2, 3].whereIsNotNull((i) => i == 2 ? null : i).expectEquals([1, 3]);

        final objResult =
            [Pair(null, 5), Pair(4, 2)].whereIsNotNull((o) => o.first);
        objResult.length.expectEquals(1);
        objResult.first.first.expectEquals(4);
      });
    });

    group('whereNot', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].whereNot(null)).also(
          verifyArgumentError(name: 'predicate', message: 'Must not be null'),
        );
      });

      test('handles an empty iterable', () {
        [].whereNot((i) => true).expectEquals([]);
      });

      test('returns all elements that match !predicate', () {
        [0, 1, 2, 3].whereNot((i) => i == 2).expectEquals([0, 1, 3]);
      });
    });

    group('whereNotNull', () {
      test('handles an empty iterable', () {
        expect([].whereNotNull(), []);
      });

      test('removes null values', () {
        expect([null, 1, null, 2].whereNotNull(), [1, 2]);
        expect([null, 't', null, 'e'].whereNotNull(), ['t', 'e']);
      });
    });
  });
}
