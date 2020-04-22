import 'package:test/test.dart';

import 'package:kotlin_extensions/map.dart';
import 'package:kotlin_extensions/object.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('on Map<K, V>', () {
    group('getOrNull', () {
      test('returns the value when the key is in the map', () {
        <String, int>{'Hello': 1, 'World': 2} // Format
            .getOrNull('Hello')
            .expectEquals(1);

        <double, int>{5.5: 42, 7.2: 58} // Format
            .getOrNull(5.5)
            .expectEquals(42);

        <double, int>{5.5: 42, 7.2: 58} // Format
            .getOrNull(7.2)
            .expectEquals(58);
      });

      test('returns null when the element is not in the map', () {
        <String, int>{'Hello': 1, 'World': 2} // Format
            .getOrNull('Foo')
            .expectIsNull();

        <double, String>{3.14159265: 'pi'} // Format
            .getOrNull(2.17)
            .expectIsNull();
      });

      test('chains together', () {
        <String, Map<String, Map<String, String>>>{
          'first': {
            'second': {
              'third': 'value',
            }
          }
        }
            .getOrNull('first')
            .expectEquals({
              'second': {'third': 'value'}
            })
            .getOrNull('second')
            .expectEquals({'third': 'value'})
            .getOrNull('third')
            .expectEquals('value');
      });

      test('allows null checking', () {
        expect(null?.getOrNull('test')?.getOrNull('test2'), isNull);
        expect({'test': null}.getOrNull('test')?.getOrNull('test2'), isNull);
      });

      test('returns the correct type', () {
        <String, String>{'Hello': 'World'} // Format
            .getOrNull('Hello')
            .expectIsA<String>();

        <String, int>{'Hello': 5} // Format
            .getOrNull('Hello')
            .expectIsA<int>();
      });
    });

    group('getOrDefault', () {
      test('returns the correct value when the key is in the map', () {
        <String, String>{'Hello': 'World'}
            .getOrDefault('Hello', 'Foo')
            .expectEquals('World');

        <double, int>{5.4: 88} // Format
            .getOrDefault(5.4, 6)
            .expectEquals(88);
      });

      test('returns the default when the key is not in the map', () {
        <String, String>{'Hello': 'World'}
            .getOrDefault('Hallo', 'Foo')
            .expectEquals('Foo');

        <double, int>{5.4: 88} // Format
            .getOrDefault(5.45, 6)
            .expectEquals(6);
      });

      test('returns the correct type', () {
        <String, String>{'Hello': 'World'}
            .getOrDefault('Hello', 'Foo')
            .expectIsA<String>();

        <String, int>{'Hello': 5} // Format
            .getOrDefault('Hello', 8)
            .expectIsA<int>();

        <String, String>{'Hello': 'World'}
            .getOrDefault('Hallo', 'Foo')
            .expectIsA<String>();

        <String, int>{'Hello': 5} // Format
            .getOrDefault('Hallo', 8)
            .expectIsA<int>();
      });
    });

    group('getOrElse', () {
      test('returns the correct value when the key is in the map', () {
        <String, String>{'Hello': 'World'}
            .getOrElse('Hello', () => 'Foo')
            .expectEquals('World');

        <double, int>{5.4: 88} // Format
            .getOrElse(5.4, () => 6)
            .expectEquals(88);
      });

      test('returns the result of defaultValue not in the map', () {
        <String, String>{'Hello': 'World'}
            .getOrElse('Hallo', () => 'Foo')
            .expectEquals('Foo');

        <double, int>{5.4: 88} // Format
            .getOrElse(5.45, () => 10 + 5)
            .expectEquals(15);
      });

      test('does not call defaultValue when the key is in the map', () {
        String param;

        <String, String>{'Hello': 'World'}
            .getOrElse('Hello', () => param = 'Foo');

        param.expectIsNull();
      });

      test('returns the correct type', () {
        <String, String>{'Hello': 'World'}
            .getOrElse('Hello', () => 'Foo')
            .expectIsA<String>();

        <String, int>{'Hello': 5} // Format
            .getOrElse('Hello', () => 8)
            .expectIsA<int>();

        <String, String>{'Hello': 'World'}
            .getOrElse('Hallo', () => 'Foo')
            .expectIsA<String>();

        <String, int>{'Hello': 5}.getOrElse('Hallo', () => 8).expectIsA<int>();
      });
    });

    group('mapKeys', () {
      test('handles empty map', () {
        <int, int>{} // Format
            .mapKeys((k, v) => k)
            .expectEquals({});
      });

      test('maps the keys of the map', () {
        <int, int>{0: 1, 2: 3} // Format
            .mapKeys((k, v) => '$k')
            .keys
            .expectEquals(['0', '2']);
      });

      test('keeps the same values of the map', () {
        <int, int>{0: 1, 2: 3} // Format
            .mapKeys((k, v) => '$k')
            .values
            .expectEquals([1, 3]);
      });

      test('leaves the original map unmodified', () {
        <String, int>{'Hello': 0, 'World': 42}.let((originalMap) {
          originalMap
            ..mapKeys((k, v) => '$k-').expectEquals({'Hello-': 0, 'World-': 42})
            ..expectEquals({'Hello': 0, 'World': 42});
        });
      });
    });

    group('mapValues', () {
      test('handles an empty map', () {
        <int, int>{} // Format
            .mapValues((k, v) => k)
            .expectEquals({});
      });

      test('maps the values of the map', () {
        <int, int>{0: 1, 2: 3} // Format
            .mapValues((k, v) => '$v')
            .values
            .expectEquals(['1', '3']);
      });

      test('keeps the same keys of the map', () {
        <int, int>{0: 1, 2: 3} // Format
            .mapValues((k, v) => '$v')
            .keys
            .expectEquals([0, 2]);
      });

      test('leaves the original map unmodified', () {
        <String, int>{'Hello': 0, 'World': 42}.let((originalMap) {
          originalMap
            ..mapValues((k, v) => v + 5).expectEquals({'Hello': 5, 'World': 47})
            ..expectEquals({'Hello': 0, 'World': 42});
        });
      });
    });

    group('mapToIterable', () {
      test('throws ArgumentError when null is passed', () {
        expectFailsWith<ArgumentError>(() => {}.mapToIterable(null))
            .verifyArgumentError(
                name: 'transform', message: 'Must not be null');
      });

      test('returns the correct value', () {
        <int, int>{1: 2, 3: 4} // Format
            .mapToIterable((k, v) => '$k$v')
            .expectEquals(['12', '34']);
      });
    });

    group('any', () {
      test('returns the correct result', () {
        <String, int>{'Hello': 1, 'World': 2}
            .any((k, v) => k.contains('ello'))
            .expect(isTrue);

        <String, int>{'Hello': 1, 'World': 2}
            .any((k, v) => k.contains('jello'))
            .expect(isFalse);

        <String, int>{'Hello': 1, 'World': 2} // Format
            .any((k, v) => v > 0)
            .expect(isTrue);

        <String, int>{'Hello': 1, 'World': 2}
            .any((k, v) => v < 0)
            .expect(isFalse);
      });
    });

    group('asIterable', () {
      test('returns the correct result', () {
        <String, int>{'H': 1, 'E': 2}.asIterable().let((entries) {
          entries.first.key.expectEquals('H');
          entries.first.value.expectEquals(1);

          entries.toList()[1].key.expectEquals('E');
          entries.toList()[1].value.expectEquals(2);
        });

        <int, String>{1: 'H', 2: 'E'}.asIterable().let((entries) {
          entries.first.key.expectEquals(1);
          entries.first.value.expectEquals('H');

          entries.toList()[1].key.expectEquals(2);
          entries.toList()[1].value.expectEquals('E');
        });
      });
    });

    group('copy', () {
      test('returns the correct result', () {
        <String, String>{'C': 'O', 'O': 'L'}.copy().let((copy) {
          copy
            ..expectEquals({'C': 'O', 'O': 'L'})
            ..remove('C')
            ..expectEquals({'O': 'L'});
        });

        <double, int>{42.5: 5, 89.7: 32}.copy().let((copy) {
          copy
            ..expectEquals({42.5: 5, 89.7: 32})
            ..remove(42.5)
            ..expectEquals({89.7: 32});
        });
      });

      test('leaves the original map untouched', () {
        <String, String>{'C': 'O', 'O': 'L'}.let((original) {
          original.copy()..clear();
          original.expectEquals({'C': 'O', 'O': 'L'});
        });

        <double, int>{42.5: 5, 89.7: 32}.let((original) {
          original.copy()..clear();
          original.expectEquals({42.5: 5, 89.7: 32});
        });
      });
    });

    group('every', () {
      test('returns the correct result', () {
        <String, int>{'H': 5} // Format
            .every((k, v) => '$k$v' == 'H5')
            .expect(isTrue);

        <String, int>{'H': 5, 'E': 4}
            .every((k, v) => '$k$v' == 'H5')
            .expect(isFalse);

        <String, int>{'N': 5, 'O': 3, 'D': 2}
            .every((k, v) => v < 5 || k == 'N')
            .expect(isTrue);
      });
    });

    group('flatMap', () {
      test('returns the correct result', () {
        <String, int>{'Y': 1, 'O': 2}
            .flatMap((k, v) => [k, '$k-'])
            .expectEquals(['Y', 'Y-', 'O', 'O-']);

        <String, int>{'Y': 1, 'O': 2}
            .flatMap((k, v) => [v, v * 2])
            .expectEquals([1, 2, 2, 4]);

        <String, int>{'Y': 1, 'O': 2}
            .flatMap((k, v) => ['$k$v', '${k}O${v + 1}'])
            .expectEquals(['Y1', 'YO2', 'O2', 'OO3']);
      });
    });

    group('getValue', () {
      test('returns the correct result', () {
        <String, String>{'H': 'I'} // Format
            .getValue('H')
            .expectEquals('I');

        <int, double>{1: 2.3, 4: 5.6} // Format
            .getValue(4)
            .expectEquals(5.6);
      });

      test('throws StateError when the key is not in the map', () {
        expectFailsWith<StateError>(() => {}.getValue('hello'));
        expectFailsWith<StateError>(() => {'H': 5}.getValue('hello'));
      });
    });

    group('isNullOrEmpty', () {
      test('returns the correct value', () {
        <int, int>{}.isNullOrEmpty.expect(isTrue);

        null.isNullOrEmpty.expect(isTrue);

        <int, int>{1: 2}.isNullOrEmpty.expect(isFalse);
      });
    });

    group('mapNotNull', () {
      test('returns the correct value', () {
        <String, int>{'H': 1, 'I': 2}
            .mapNotNull((k, v) => v > 1 ? null : v)
            .expectEquals([1]);
      });
    });

    group('maxBy', () {
      test('returns the correct value', () {
        <String, int>{'Hi': 7, 'Four': 24}.maxBy((k, v) => k.length + v)
          ..key.expectEquals('Four')
          ..value.expectEquals(24);

        <String, int>{'Hi': 107, 'Four': 24}.maxBy((k, v) => k.length + v)
          ..key.expectEquals('Hi')
          ..value.expectEquals(107);
      });
    });

    group('maxWith', () {
      test('returns the correct value', () {
        <String, int>{'Hi': 7, 'Four': 24}
            .maxWith((e1, e2) => e1.value.compareTo(e2.value))
              ..key.expectEquals('Four')
              ..value.expectEquals(24);

        <String, int>{'Hi': 7, 'Four': 24}
            .maxWith((e1, e2) => e2.value.compareTo(e1.value))
              ..key.expectEquals('Hi')
              ..value.expectEquals(7);
      });
    });

    group('minBy', () {
      test('returns the correct value', () {
        <String, int>{'Hi': 7, 'Four': 24}.minBy((k, v) => k.length + v)
          ..key.expectEquals('Hi')
          ..value.expectEquals(7);

        <String, int>{'Hi': 107, 'Four': 24}.minBy((k, v) => k.length + v)
          ..key.expectEquals('Four')
          ..value.expectEquals(24);
      });
    });

    group('minWith', () {
      test('returns the correct value', () {
        <String, int>{'Hi': 7, 'Four': 24}
            .minWith((e1, e2) => e1.value.compareTo(e2.value))
              ..key.expectEquals('Hi')
              ..value.expectEquals(7);

        <String, int>{'Hi': 7, 'Four': 24}
            .minWith((e1, e2) => e2.value.compareTo(e1.value))
              ..key.expectEquals('Four')
              ..value.expectEquals(24);
      });
    });

    group('none', () {
      test('throws ArgumentError when null is passed', () {
        expectFailsWith<ArgumentError>(() => {}.none(null)).verifyArgumentError(
            name: 'predicate', message: 'Must not be null',);
      });

      test('returns the correct value', () {
        <String, int>{'Hi': 7, 'Four': 24}
            .none((k, v) => k == 'Foo')
            .expect(isTrue);

        <String, int>{'Hi': 7, 'Four': 24}
            .none((k, v) => k == 'Hi')
            .expect(isFalse);

        <String, int>{'Hi': 7, 'Four': 24}
            .none((k, v) => v == 24)
            .expect(isFalse);
      });
    });

    group('onEach', () {
      test('throws ArgumentError when null is passed', () {
        expectFailsWith<ArgumentError>(() => {}.onEach(null))
            .verifyArgumentError(name: 'action', message: 'Must not be null');
      });

      test('functions correctly', () {
        <int, int>{1: 2, 3: 4}.onEach((k, v) {}); // TODO
      });
    });

    group('orEmpty', () {
      test('returns the same map if not null', () {
        <int, int>{1: 2}.let((map) {
          map.orEmpty().expectMatchesReference(map);
        });

        <String, String>{}.let((map) {
          map.orEmpty().expectMatchesReference(map);
        });
      });

      test('returns a new empty map if null', () {
        null.orEmpty().expectEquals({});

        Map map;
        map.orEmpty().expectEquals({});
      });
    });

    group('plus', () {
      test('throws ArgumentError when either map is null', () {
        Map nullMap;
        var nonNullMap = {};

        expectFailsWith<ArgumentError>(() => nonNullMap + nullMap)
            .verifyArgumentError(message: 'both maps must not be null');

        expectFailsWith<ArgumentError>(() => nullMap + nonNullMap)
            .verifyArgumentError(message: 'both maps must not be null');
      });

      test('returns the correct value', () {
        ({1: 2, 3: 4} + {5: 6}).expectEquals({1: 2, 3: 4, 5: 6});

        ({'H': 'E'} + {'L': 'L', 'O': ''})
            .expectEquals({'H': 'E', 'L': 'L', 'O': ''});
      });

      test('leaves the original maps unmodified', () {
        final m1 = {'R': 2, 'D': 2};
        final m2 = {'Y': 1, 'O': 5};

        (m1 + m2).expectEquals({'R': 2, 'D': 2, 'Y': 1, 'O': 5});

        m1.expectEquals({'R': 2, 'D': 2});
        m2.expectEquals({'Y': 1, 'O': 5});
      });
    });

    group('toList', () {
      test('returns the correct result', () {
        <String, int>{'H': 1, 'E': 2}.toList().let((entries) {
          entries.first.key.expectEquals('H');
          entries.first.value.expectEquals(1);

          entries[1].key.expectEquals('E');
          entries[1].value.expectEquals(2);
        });

        <int, String>{1: 'H', 2: 'E'}.toList().let((entries) {
          entries.first.key.expectEquals(1);
          entries.first.value.expectEquals('H');

          entries.toList()[1].key.expectEquals(2);
          entries.toList()[1].value.expectEquals('E');
        });
      });
    });

    group('where', () {
      test('returns the correct result', () {
        <String, int>{'H': 1, 'E': 2} // Format
            .where((k, v) => k == 'H')
            .expectEquals({'H': 1});

        <int, String>{1: 'H', 2: 'E'}
            .where((k, v) => k == 2 || v == 'H')
            .expectEquals({1: 'H', 2: 'E'});
      });
    });

    group('whereKeys', () {
      test('returns the correct result', () {
        <String, int>{'H': 1, 'E': 2} // Format
            .whereKeys((k) => k == 'H')
            .expectEquals({'H': 1});

        <int, String>{1: 'H', 2: 'E'} // Format
            .whereKeys((k) => k == 2)
            .expectEquals({2: 'E'});
      });
    });

    group('whereNot', () {
      test('returns the correct result', () {
        <String, int>{'H': 1, 'E': 2}
            .whereNot((k, v) => k == 'E')
            .expectEquals({'H': 1});

        <int, String>{1: 'H', 2: 'E'} // Format
            .whereNot((k, v) => k == 1)
            .expectEquals({2: 'E'});

        <int, String>{1: 'H', 2: 'E'}
            .whereNot((k, v) => k == 2 || v == 'H')
            .expectEquals({});
      });
    });

    group('whereValues', () {
      test('returns the correct result', () {
        <String, int>{'H': 1, 'E': 2} // Format
            .whereValues((v) => v == 1)
            .expectEquals({'H': 1});

        <int, String>{1: 'H', 2: 'E'}
            .whereValues((v) => v == 'E')
            .expectEquals({2: 'E'});
      });
    });
  });
}
