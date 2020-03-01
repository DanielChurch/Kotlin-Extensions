@TestOn('vm')

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
        expectFailsWith<ArgumentError>(() => [].associate(null));
      });

      test('handles an empty iterable', () {
        [].associate((i) => {i: i}).expectEquals({});
      });

      test('returns the correct value', () {
        ['Hello', 'World', 'Foo']
            .associate((str) => {str: str.length})
            .expectEquals({'Hello': 5, 'World': 5, 'Foo': 3});

        ['Hello'].associate((s) => {}).expectEquals({});
      });

      test('uses the last common key', () {
        [0, 1, 2].associate((i) => {0: i}).expectEquals({0: 2});
      });

      test('allows multiple key-value pairs & preserves order', () {
        [0, 1, 2]
            .associate((i) => {i: i, -i: i})
            .expectEquals({0: 0, 1: 1, -1: 1, 2: 2, -2: 2});
      });

      test('returns the correct type', () {
        ['Hello', 'World', 'Foo']
            .associate((str) => {str: str.length})
            .expectIsA<Map<String, int>>();
      });

      test('passes the correct type', () {
        var passedValue;
        ['Hello'].associate((s) {
          passedValue = s;
          return {};
        });

        passedValue.expectIsA<String>();

        <int>[0].associate((s) {
          passedValue = s;
          return {};
        });

        passedValue.expectIsA<int>();
      });
    });

    group('associateBy', () {
      test('throws on null input', () {
        expectFailsWith<ArgumentError>(
          () => [].associateBy(key: null, value: null),
        );
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

      test('returns the correct type', () {
        [0, 1, 2]
            .associateBy(key: (i) => Object(), value: (i) => '$i')
            .expectIsA<Map<Object, String>>();

        [0, 1, 2]
            .associateBy(key: (i) => false, value: (i) => Object())
            .expectIsA<Map<bool, Object>>();
      });

      test('passes the correct type', () {
        var passedToKey, passedToValue;
        <int>[0, 1].associateBy(
          key: (i) => passedToKey = i,
          value: (i) => passedToValue = i,
        );

        passedToKey.expectIsA<int>();
        passedToValue.expectIsA<int>();

        ['Hello', 'World'].associateBy(
          key: (str) => passedToKey = str,
          value: (str) => passedToValue = str,
        );

        passedToKey.expectIsA<String>();
        passedToValue.expectIsA<String>();
      });
    });

    group('associateWith', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].associateWith(null));
      });

      test('handles an empty iterable', () {
        [].associateWith((i) => i).expectEquals({});
      });

      test('passes the correct values', () {
        [0, 1, 2, 3].associateWith((i) => i).keys.expectEquals([0, 1, 2, 3]);
      });

      test('correctly applies the valueSelector', () {
        [0, 1, 2, 3]
            .associateWith((i) => -i)
            .values
            .expectEquals([0, -1, -2, -3]);
      });

      test('returns the correct type', () {
        [0, 1, 2, 3]
            .associateWith((i) => '${-i}')
            .expectIsA<Map<int, String>>();

        ['Hello', 'World']
            .associateWith((str) => str.length)
            .expectIsA<Map<String, int>>();
      });

      test('passes the correct type', () {
        var passedValue;
        <int>[0].associateWith((i) => passedValue = i);

        passedValue.expectIsA<int>();

        [''].associateWith((i) => passedValue = i);

        passedValue.expectIsA<String>();
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
        null.firstOrNull.expectEqualsNull();
        [].firstOrNull.expectEqualsNull();
      });

      test('returns the first element', () {
        [0, 1, 2].firstOrNull.expectEquals(0);
        ['Hello', 'World'].firstOrNull.expectEquals('Hello');
      });

      test('returns the correct type', () {
        <int>[0].firstOrNull.expectIsA<int>();
        <num>[0].firstOrNull.expectIsA<num>();
        [''].firstOrNull.expectIsA<String>();
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

      test('results in the correct type', () {
        [].flatMap((e) => [e].expectIsA<Iterable<int>>());
        [].flatMap((e) => ['$e'].expectIsA<Iterable<String>>());
        [].flatMap((e) => [Object()].expectIsA<Iterable<Object>>());
      });

      test('passes the correct type', () {
        var passedValue;
        <int>[0].flatMap((i) {
          passedValue = i;
          return [];
        }).toList();

        passedValue.expectIsA<int>();

        [''].flatMap((str) {
          passedValue = str;
          return [];
        }).toList();

        passedValue.expectIsA<String>();
      });
    });

    group('forEachIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].forEachIndexed(null));
      });

      test('handles an empty iterable', () {
        expect(() => [].forEachIndexed((i, e) {}), returnsNormally);
      });

      test('passes the correct indices (starting with 0)', () {
        <int>[].let((indices) {
          [5, 5, 5, 5, 5].forEachIndexed((i, e) => indices.add(i));

          expect(indices, [0, 1, 2, 3, 4]);
        });

        <int>[].let((indices) {
          ['t', 'e', 's', 't'].forEachIndexed((i, e) => indices.add(i));

          expect(indices, [0, 1, 2, 3]);
        });
      });

      test('passes the correct values', () {
        expect(
          <int>[].also((values) {
            [5, 5, 5, 5, 5].forEachIndexed((i, e) => values.add(e));
          }),
          [5, 5, 5, 5, 5],
        );

        expect(
          <String>[].also((values) {
            ['test'].forEachIndexed((i, e) => values.add(e));
          }),
          ['test'],
        );
      });

      test('passes the correct types', () {
        var passedIndex, passedElement;
        <int>[0].forEachIndexed((i, e) {
          passedIndex = i;
          passedElement = e;
        });

        expect(passedIndex, isA<int>());
        expect(passedElement, isA<int>());

        <String>[''].forEachIndexed((i, e) {
          passedIndex = i;
          passedElement = e;
        });

        expect(passedIndex, isA<int>());
        expect(passedElement, isA<String>());
      });
    });

    group('groupBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].groupBy(null));
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

      test('returns the correct type', () {
        expect(
            [''].groupBy((str) => str.length), isA<Map<int, List<String>>>());
        expect(<int>[0].groupBy((i) => ''), isA<Map<String, List<int>>>());
      });

      test('passes the correct type', () {
        var passedValue;
        [''].groupBy((str) {
          passedValue = str;
          return str.length;
        });

        expect(passedValue, isA<String>());

        <int>[0].groupBy((str) {
          passedValue = str;
          return '';
        });

        expect(passedValue, isA<int>());
      });
    });

    group('isNullOrEmpty', () {
      test('returns true when the iterable is null or empty', () {
        Iterable iter;
        expect(iter.isNullOrEmpty, isTrue);
        expect([].isNullOrEmpty, isTrue);
      });

      test('returns false when the iterable has values', () {
        expect([0, 1].isNullOrEmpty, isFalse);
        expect(['Hello', 'World'].isNullOrEmpty, isFalse);
      });
    });

    group('lastOrNull', () {
      test('returns null when the list is null or empty', () {
        expect(null.lastOrNull, null);
        expect([].lastOrNull, null);
      });

      test('returns the first element', () {
        expect([0, 1, 2].lastOrNull, 2);
        expect(['Hello', 'World'].lastOrNull, 'World');
      });

      test('returns the correct type', () {
        expect(<int>[0].lastOrNull, isA<int>());
        expect([''].lastOrNull, isA<String>());
      });
    });

    group('mapIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].mapIndexed(null));
      });

      test('handles an empty iterable', () {
        expect([].mapIndexed((i, j) => i), []);
      });

      test('passes the correct indices (starting with 0)', () {
        expect([5, 5, 5, 5, 5].mapIndexed((i, e) => i), [0, 1, 2, 3, 4]);
        expect(['t', 'e', 's', 't'].mapIndexed((i, e) => i), [0, 1, 2, 3]);
      });

      test('passes the correct values', () {
        expect([5, 5, 5, 5, 5].mapIndexed((i, e) => e), [5, 5, 5, 5, 5]);
        expect(['test'].mapIndexed((i, e) => e), ['test']);
      });

      test('applies transform', () {
        expect([1, 2, 3].mapIndexed((i, e) => i + e), [1, 3, 5]);
      });

      test('results in the correct type', () {
        expect(<int>[].mapIndexed((i, e) => e), isA<Iterable<int>>());
        expect(<int>[].mapIndexed((i, e) => '$e'), isA<Iterable<String>>());
        expect(
          <String>[].mapIndexed((i, e) => Object()),
          isA<Iterable<Object>>(),
        );
      });

      test('passes the correct types', () {
        var passedIndex, passedValue;
        <int>[0].mapIndexed((i, j) {
          passedIndex = i;
          passedValue = j;
        }).toList();

        expect(passedIndex, isA<int>());
        expect(passedValue, isA<int>());

        [''].mapIndexed((i, str) {
          passedIndex = i;
          passedValue = str;
        }).toList();

        expect(passedIndex, isA<int>());
        expect(passedValue, isA<String>());
      });
    });

    group('mapIndexedNotNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].mapIndexedNotNull(null));
      });

      test('handles an empty iterable', () {
        expect([].mapIndexedNotNull((i, e) => e), []);
      });

      test('removes null values', () {
        expect(
          [0, 1, 2, 3, 4].mapIndexedNotNull((i, e) => e % 2 == 0 ? null : i),
          [1, 3],
        );

        expect(
          ['f', 'o', 'o'].mapIndexedNotNull((i, e) => e == 'f' ? null : e),
          ['o', 'o'],
        );
      });

      test('passes the correct indices (starting with 0)', () {
        expect([5, 5, 5, 5, 5].mapIndexedNotNull((i, e) => i), [0, 1, 2, 3, 4]);
        expect(
          ['t', 'e', 's', 't'].mapIndexedNotNull((i, e) => i),
          [0, 1, 2, 3],
        );
      });

      test('passes the correct values', () {
        expect([5, 5, 5, 5, 5].mapIndexedNotNull((i, e) => e), [5, 5, 5, 5, 5]);
        expect(['test'].mapIndexedNotNull((i, e) => e), ['test']);
      });

      test('applies transform', () {
        expect([1, 2, 3].mapIndexedNotNull((i, e) => i + e), [1, 3, 5]);
      });

      test('results in the correct type', () {
        expect(<int>[].mapIndexedNotNull((i, e) => e), isA<Iterable<int>>());
        expect(
          <int>[].mapIndexedNotNull((i, e) => '$e'),
          isA<Iterable<String>>(),
        );
        expect(
          <String>[].mapIndexedNotNull((i, e) => Object()),
          isA<Iterable<Object>>(),
        );
      });

      test('passes the correct type', () {
        var passedIndex, passedElement;
        <int>[0].mapIndexedNotNull((i, e) {
          passedIndex = i;
          passedElement = e;
        }).toList();

        expect(passedIndex, isA<int>());
        expect(passedElement, isA<int>());

        [''].mapIndexedNotNull((i, e) {
          passedIndex = i;
          passedElement = e;
        }).toList();

        expect(passedIndex, isA<int>());
        expect(passedElement, isA<String>());
      });
    });

    group('mapNotNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].mapNotNull(null));
      });

      test('handles an empty iterable', () {
        expect([].mapNotNull((e) => e), []);
      });

      test('removes null values', () {
        expect(
          [0, 1, 2, 3, 4].mapNotNull((i) => i % 2 == 0 ? null : i),
          [1, 3],
        );

        expect(
          ['t', 'e', 's', 't'].mapNotNull((i) => i == 't' ? null : i),
          ['e', 's'],
        );
      });

      test('applies transform', () {
        expect([0, 1, 2, 3, 4].mapNotNull((i) => i + 2), [2, 3, 4, 5, 6]);
        expect(
          ['t', 'e', 's', 't'].mapNotNull((i) => '$i.'),
          ['t.', 'e.', 's.', 't.'],
        );
      });

      test('results in the correct type', () {
        expect(<int>[].mapNotNull((e) => e), isA<Iterable<int>>());
        expect(<int>[].mapNotNull((e) => '$e'), isA<Iterable<String>>());
        expect(<String>[].mapNotNull((e) => Object()), isA<Iterable<Object>>());
      });

      test('passes the correct type', () {
        var passedElement;
        <int>[0].mapNotNull((i) => passedElement = i).toList();
        expect(passedElement, isA<int>());

        [''].mapNotNull((i) => passedElement = i).toList();
        expect(passedElement, isA<String>());
      });
    });

    group('maxBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].maxBy(null));
      });

      test('handles an empty iterable', () {
        expect(<int>[].maxBy((i) => i), isNull);
      });

      test('returns the maximum transformed value', () {
        expect([0].maxBy((i) => i), 0);
        expect([0, 1, 2].maxBy((i) => -i), 0);
        expect(['Hello', 'Foo'].maxBy((str) => str.length), 'Hello');
      });

      test('returns the first element when there are duplicates', () {
        expect(['Foo', 'Bar'].maxBy((str) => str.length), 'Foo');
      });

      test('returns the correct type', () {
        expect(<int>[0].maxBy((i) => i), isA<int>());
        expect([''].maxBy((i) => i), isA<String>());
      });

      test('passes the correct types', () {
        var passedValue;
        <int>[0, 1].maxBy((i) {
          passedValue = i;
          return i;
        });

        expect(passedValue, isA<int>());

        ['Hello', 'World'].maxBy((i) {
          passedValue = i;
          return i;
        });

        expect(passedValue, isA<String>());
      });
    });

    group('maxWith', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].maxWith(null));
      });

      test('handles an empty iterable', () {
        expect(<int>[].maxWith((i, j) => 1), isNull);
      });

      test('returns the expected max value based on the comparator', () {
        expect(
          [0, 1, 2, 3].maxWith((i, j) => i > j ? 1 : -1),
          3,
        );

        expect(
          [0, 1, 2, 3].maxWith((i, j) => i < j ? 1 : -1),
          0,
        );
      });

      test('returns the first element when there are duplicates', () {
        expect(
            ['Foo', 'Bar'].maxWith((s1, s2) => s1.length.compareTo(s2.length)),
            'Foo');
      });

      test('returns the correct type', () {
        expect(<int>[0].maxWith((i, j) => 1), isA<int>());
        expect([''].maxWith((i, j) => 1), isA<String>());
      });

      test('passes the correct type', () {
        var passedFirstElement, passedSecondElement;
        [0, 1].maxWith((i, j) {
          passedFirstElement = i;
          passedSecondElement = j;

          return 1;
        });

        expect(passedFirstElement, isA<int>());
        expect(passedSecondElement, isA<int>());

        ['Hello', 'World'].maxWith((i, j) {
          passedFirstElement = i;
          passedSecondElement = j;

          return 1;
        });

        expect(passedFirstElement, isA<String>());
        expect(passedSecondElement, isA<String>());
      });
    });

    group('minBy', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].minBy(null));
      });

      test('handles an empty iterable', () {
        expect(<int>[].minBy((i) => i), null);
      });

      test('returns the minimum transformed value', () {
        expect([-5, 0, 7].minBy((i) => -i), 7);
      });

      test('returns the first element when there are duplicates', () {
        expect(['Foo', 'Bar'].minBy((str) => str.length), 'Foo');
      });

      test('returns the correct type', () {
        expect(<int>[0, 1].minBy((i) => i), isA<int>());
        expect(['Hello', 'World'].minBy((i) => i.length), isA<String>());
      });

      test('passes the correct type', () {
        var passedValue;
        [0, 1].minBy((i) => passedValue = i);
        expect(passedValue, isA<int>());

        ['Hello', 'World'].minBy((i) => passedValue = i);
        expect(passedValue, isA<String>());
      });
    });

    group('minWith', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].maxWith(null));
      });

      test('handles an empty iterable', () {
        expect([].minWith((i, j) => 1), null);
      });

      test('returns the expected min value based on the comparator', () {
        expect(
          [0, 1, 2, 3].minWith((i, j) => i > j ? 1 : -1),
          0,
        );

        expect(
          [0, 1, 2, 3].minWith((i, j) => i < j ? 1 : -1),
          3,
        );
      });

      test('returns the first element when there are duplicates', () {
        expect(
            ['Foo', 'Bar'].minWith((s1, s2) => s1.length.compareTo(s2.length)),
            'Foo');
      });

      test('returns the correct type', () {
        expect(<int>[0, 1].minWith((i, j) => 1), isA<int>());
        expect(['a', 'b'].minWith((i, j) => 1), isA<String>());
      });

      test('passes the correct type', () {
        var passedFirstElement, passedSecondElement;
        <int>[0, 1].minWith((i, j) {
          passedFirstElement = i;
          passedSecondElement = j;
          return 1;
        });

        expect(passedFirstElement, isA<int>());
        expect(passedSecondElement, isA<int>());

        ['Hello', 'World'].minWith((i, j) {
          passedFirstElement = i;
          passedSecondElement = j;
          return 1;
        });

        expect(passedFirstElement, isA<String>());
        expect(passedSecondElement, isA<String>());
      });
    });

    group('none', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].none(null));
      });

      test('handles an empty iterable', () {
        [].none((i) => false).expectEquals(true);
      });
    });

    group('partition', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].partition(null));
      });

      test('handles an empty iterable', () {
        [].partition((i) => false).let((pair) {
          expect(pair.first, []);
          expect(pair.second, []);
        });
      });

      test('partitions the iterable based on the predicate', () {
        [0, 1, 2, 3, 4, 5].partition((i) => i > 2).let((partition) {
          expect(partition.first, [3, 4, 5]);
          expect(partition.second, [0, 1, 2]);
        });
      });

      test('leaves the original Iterable unmodified', () {
        [0, 1, 2].let((originalList) {
          originalList.partition((i) => i % 2 == 0);

          expect(originalList, [0, 1, 2]);
        });
      });

      test('returns the correct type', () {
        expect(
          <int>[].partition((i) => false),
          isA<Pair<Iterable<int>, Iterable<int>>>(),
        );

        expect(
          <String>[].partition((i) => false),
          isA<Pair<Iterable<String>, Iterable<String>>>(),
        );
      });
    });

    group('reduceIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [0].reduceIndexed(null));
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
        expectFailsWith<ArgumentError>(() => [].reduceIndexedOrNull(null));
        expectFailsWith<ArgumentError>(() => [0].reduceIndexedOrNull(null));
      });

      test('returns null when the iterable is empty', () {
        expect([].reduceIndexedOrNull((index, e1, e2) => 0), isNull);
      });

      test('returns the correct value', () {
        expect(
          [0, 1, 2].reduceIndexedOrNull((index, e1, e2) => index + e1 + e2),
          6, // (1 + 0 + 1) => (2 + 2 + 2) => 6
        );

        expect(
          ['H', 'E', 'L', 'L', 'O']
              .reduceIndexedOrNull((index, e1, e2) => '$e1$e2-$index'),
          'HE-1L-2L-3O-4',
        );
      });
    });

    group('whereIndexed', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].whereIndexed(null));
      });

      test('handles an empty iterable', () {
        expect([].whereIndexed((i, e) => true), []);
      });

      test('passes the correct indices (starting with 0)', () {
        <int>[].let((indices) {
          [5, 5, 5, 5, 5].whereIndexed((i, e) {
            indices.add(i);
            return true;
          }).toList();

          expect(indices, [0, 1, 2, 3, 4]);
        });

        <int>[].let((indices) {
          ['t', 'e', 's', 't'].whereIndexed((i, e) {
            indices.add(i);
            return true;
          }).toList();

          expect(indices, [0, 1, 2, 3]);
        });
      });

      test('passes the correct values', () {
        <int>[].let((values) {
          [5, 5, 5, 5, 5].whereIndexed((i, e) {
            values.add(e);
            return true;
          }).toList();

          expect(values, [5, 5, 5, 5, 5]);
        });

        <String>[].let((values) {
          ['test'].whereIndexed((i, e) {
            values.add(e);
            return true;
          }).toList();

          expect(values, ['test']);
        });
      });

      test('returns values based on the predicate', () {
        final result = [0, 1, 2].whereIndexed((i, e) {
          return i == 0 || i == 1;
        });

        expect(result, [0, 1]);
      });

      test('leaves the original Iterable unmodified', () {
        final originalList = [0, 1, 2];
        originalList.whereIndexed((i, e) => i % 2 == 0);

        expect(originalList, [0, 1, 2]);
      });
    });

    group('whereIsNotNull', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].whereIsNotNull(null));
      });

      test('handles an empty iterable', () {
        expect([].whereIsNotNull((i) => i), []);
      });

      test('removes null values', () {
        expect([1, 2, 3].whereIsNotNull((i) => i == 2 ? null : i), [1, 3]);

        final objResult =
            [Pair(null, 5), Pair(4, 2)].whereIsNotNull((o) => o.first);
        expect(objResult.length, 1);
        expect(objResult.first.first, 4);
      });

      test('leaves the original Iterable unmodified', () {
        final originalList = [0, 1, 2, null];
        originalList.whereIsNotNull((i) => i);

        expect(originalList, [0, 1, 2, null]);
      });

      test('results in the correct type', () {
        expect(<int>[].whereIsNotNull((i) => i), isA<Iterable<int>>());
        expect(<String>[].whereIsNotNull((i) => i), isA<Iterable<String>>());
        expect(<Object>[].whereIsNotNull((e) => ''), isA<Iterable<Object>>());
      });
    });

    group('whereNot', () {
      test('throws ArgumentError when passed null', () {
        expectFailsWith<ArgumentError>(() => [].whereNot(null));
      });

      test('handles an empty iterable', () {
        expect([].whereNot((i) => true), []);
      });

      test('returns all elements that match !predicate', () {
        expect(
          [0, 1, 2, 3].whereNot((i) => i == 2),
          [0, 1, 3],
        );
      });

      test('returns the correct type', () {
        expect(
          <int>[0, 1, 2].whereNot((i) => true),
          isA<Iterable<int>>(),
        );

        expect(
          ['a'].whereNot((i) => true),
          isA<Iterable<String>>(),
        );
      });

      test('leaves the original Iterable unmodified', () {
        final originalList = [0, 1, 2];
        originalList.whereNot((i) => false);

        expect(originalList, [0, 1, 2]);
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

      test('results in the correct type', () {
        expect(<int>[].whereNotNull(), isA<Iterable<int>>());
        expect(<String>[].whereNotNull(), isA<Iterable<String>>());
        expect(<Object>[].whereNotNull(), isA<Iterable<Object>>());
      });

      test('leaves the original Iterable unmodified', () {
        final originalList = [0, 1, 2, null];
        originalList.whereNotNull();

        expect(originalList, [0, 1, 2, null]);
      });
    });
  });
}
